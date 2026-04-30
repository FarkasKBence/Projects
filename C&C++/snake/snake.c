#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SOROK 10
#define OSZLOPOK 20
#define KIGYOSIZE 9
#define BASEALMACOUNT 10

void init_field(char jatekter[SOROK][OSZLOPOK], int almaszam){
    int i,j;
    for(i = 0; i < SOROK; i++){
        for(j = 0; j < OSZLOPOK; j++){
            jatekter[i][j] = ' ';
        }
    }

    //MJ. Bar ez elmeletben akarmeddig futhat, gyakorlatban gyors lesz ilyen szamokkal.
    int almak = 0;
    while(almak < almaszam){
        int rx = rand()%SOROK, ry = rand()%OSZLOPOK;
        if(jatekter[rx][ry]==' '){
            jatekter[rx][ry]='a';
            almak++;
        }
    }
}

void init_snake(int kigyo[KIGYOSIZE][2]){
    kigyo[0][0]=9;
    kigyo[0][1]=0;
    kigyo[1][0]=8;
    kigyo[1][1]=0;
    kigyo[2][0]=7;
    kigyo[2][1]=0;
    kigyo[3][0]=6;
    kigyo[3][1]=0;
    kigyo[4][0]=5;
    kigyo[4][1]=0;
    kigyo[5][0]=4;
    kigyo[5][1]=0;
    kigyo[6][0]=3;
    kigyo[6][1]=0;
    kigyo[7][0]=2;
    kigyo[7][1]=0;
    kigyo[8][0]=1;
    kigyo[8][1]=0;
}

void print_game(char jatekter[SOROK][OSZLOPOK],int kigyo[KIGYOSIZE][2]){
    int i,j;
    char munka[SOROK][OSZLOPOK];
    //jatekter -> munka
    for (i = 0; i < SOROK; i++)
        for (j = 0; j < OSZLOPOK; j++)
            munka[i][j]=jatekter[i][j];
    //kigyo -> munka
    for (i = 0; i < KIGYOSIZE; i++)
        munka[kigyo[i][0]][kigyo[i][1]] = (i==0 ? '8' : '0');
    //kirajzolas
    for(i = -1; i<=SOROK; i++){
        for(j=-1; j <= OSZLOPOK; j++)
            if(j==-1 || i == -1) printf("#");
            else if (j==OSZLOPOK || i==SOROK) printf("#");
            else {
               printf("%c",munka[i][j]); 
            }
        printf("\n");
    }
}

int lentvanapalyarol(int x, int y){
    return (x < 0 || x >= SOROK || y < 0 || y >= OSZLOPOK);
}

int onmagavalutkozott(int kigyo[KIGYOSIZE][2], int fejx, int fejy){
    int i;
    for(i = 0; i < KIGYOSIZE-1; i++){ //MJ. UTOLSOVAL VALO UTKOZEST NEM NEZZUK!!!! MJ2: mivel 9 hosszu a kigyo, ez nem fog elofordulni
        if(kigyo[i][0]==fejx && kigyo[i][1]==fejy) return 1;
    }
    return 0;
}

//tortent-e alma begyujtes(1) vagy nem(0), sikertelenseg eseten jelzi, hogy a palya szelevel(-1) vagy a kigyó onmagaval(-2) utkozott-e
int update_snake(char jatekter[SOROK][OSZLOPOK], int kigyo[KIGYOSIZE][2], char direction){
    int x=0,y=0;
    switch(direction){
        case 'w':
            x=-1;
            break;
        case 'a':
            y=-1;
            break;
        case 's':
            x=1;
            break;
        case 'd':
            y=1;
            break;
        default:
            printf("Nem megfelelo irany: %c!\n",direction); 
            return 0; //nem fejezi be a jatekot, hagyja folytatni a jatekost. Ha -1-t returnolunk, az veget vet a jateknak.
    }
    int fejx=kigyo[0][0],fejy=kigyo[0][1];
    fejx+=x; fejy+=y;

    int eredmeny;
    if(lentvanapalyarol(fejx,fejy)){
        //lefutott
        eredmeny=-1;
    } else if (onmagavalutkozott(kigyo, fejx, fejy)){
        //onmagaval utkozott
        eredmeny=-2;
    } else if (jatekter[fejx][fejy] == 'a'){
        //alma
        jatekter[fejx][fejy]=' ';
        eredmeny=1;
    } else {
        //semmi baj, de nincs alma
        eredmeny=0;
    }
    
    int i;
    for(i=KIGYOSIZE-1; i > 0; i--){
        kigyo[i][0]=kigyo[i-1][0];
        kigyo[i][1]=kigyo[i-1][1];
    }
    kigyo[0][0]=fejx; kigyo[0][1]=fejy;
    return eredmeny;
}

int main(){
    srand(time(NULL));

    //koszontes
    printf("Udvozollek a Snake jatek C-s implementaciojaban!\n");
    printf("Feladatod osszegyujteni az almakat a kigyoval anelkul, hogy a falba, vagy magadba utkoznel.\n");
    printf("Iranyitas: egy sorban 'w', 'a', 's' es 'd' karakterek sorozata, a lepesek iranyanak megfeleloen. (Pl. ddwa: kettot lep jobbra, egyet fel, majd egyet balra.)\n");

    //deklaraciok
    char jatekter[SOROK][OSZLOPOK];
    int kigyo[KIGYOSIZE][2];
    int almacounter=BASEALMACOUNT;
    
    //init game
    init_field(jatekter,BASEALMACOUNT);
    init_snake(kigyo);

    //gameplay loop
    int gamestate = 0; //possible values: 0-playing 1-won -1-loss by wall collision -2-loss by self collision
    char c;
    print_game(jatekter,kigyo);   
    while(gamestate == 0 && (c=getchar())!=EOF){
        if(c!='\n'){
            int lepeseredmeny=update_snake(jatekter,kigyo,c);
            
            if(lepeseredmeny < 0){
                gamestate = lepeseredmeny;
            } else {
                print_game(jatekter,kigyo);
                if(lepeseredmeny==1) almacounter--;
                if(almacounter<=0) gamestate=1;    
            }
        }
    }

    //jatek vege
    if(c==EOF) printf("Viszlat!\n");
    else if(gamestate<0) printf("Vesztettel! Utkoztel %s.\n", (gamestate==-1 ? "a palya szelevel":"magaddal"));
    else printf("Nyertel! Minden almat megettel.\n");

    return 0;
}