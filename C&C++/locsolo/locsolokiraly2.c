#include <stdio.h> 
#include <stdlib.h> 
#include <unistd.h> 
#include <errno.h> 
#include <string.h> 
#include <signal.h> 
#include <fcntl.h> 
#include <time.h> 
#include <mqueue.h> 
#include <sys/msg.h> 
#include <sys/sem.h> 
#include <sys/shm.h> 
#include <sys/stat.h> 
#include <sys/time.h> 
#include <sys/types.h> 
#include <sys/wait.h>
#include <ctype.h>

#define pt(fstr, ...) {printf("[%s] "fstr"\n", whoami ?: "N/A", ##__VA_ARGS__);} 
#define VERSHOSSZ 200
#define NEVSHOSSZ 20
#define MAXNYUSZI 100

void handler(int receivedsignal){}
char* whoami = 0;

void szimulacio(char* file);
void jelentkezes(char* file);
void modositas(char* file);
void torles(char* file);
void listazas(char* file);

struct nyuszi {
	char nev[NEVSHOSSZ];
	char vers[VERSHOSSZ];
	int tojas;
};

int main(){
	int f = open("nyuszik.txt", O_CREAT, S_IRUSR | S_IWUSR | S_IXUSR);
	if (f < 0) {printf("HIBA: problema a fajlkezdessel.\n"); }

	close(f);

	int active = 1;
	char in, c;

	char* file = "nyuszik.txt";

	while (active) {
		printf("\n======LOCSOLOKIRALY VALASZTAS======\n");
		printf("Opciok:\n");
		printf("1. Jelentkezes\n");
		printf("2. Adat Modositasa\n");
		printf("3. Adat torlese\n");
		printf("4. Adatok listazasa\n");
		printf("5. Húsvét hétfő\n");
		printf("6. Kilepes\n");
	
		printf("Dontes: ");
		scanf("%c", &in);
		do {
			scanf("%c", &c);
		} while (c != '\n');
	
		//printf("in: %c dump: %c", in, c);
	
		switch(in){
			case '1':	jelentkezes(file);	break;
			case '2':	modositas(file);	break;
			case '3':	torles(file);		break;
			case '4':	listazas(file);		break;
			case '5':	szimulacio(file);	break;
			case '6':	active = 0;			break;
			default:
				printf("\nHIBA: 1-6-ig adja meg az utasitast!\n");
		}

	}

	printf("KILEPES...\n");

	return 0;
}

void szimulacio(char* file){
	printf("\n======HUSVET HETFO======\n");
	
	struct nyuszi nyuszik[MAXNYUSZI];
	
	FILE *f;
	f = fopen(file, "r");
	if (f == NULL) { printf("HIBA: fajl betoltes sikertelen!\n"); return; }
	
	int bunnies = 0;
	while (fgets(nyuszik[bunnies].nev, NEVSHOSSZ, f) != NULL){
		fgets(nyuszik[bunnies].vers, VERSHOSSZ, f);
		fscanf(f, "%d\n", &nyuszik[bunnies].tojas);
		
		nyuszik[bunnies].nev[strlen(nyuszik[bunnies].nev) - 1] = '\0';
		nyuszik[bunnies].vers[strlen(nyuszik[bunnies].vers) - 1] = '\0';

		printf("%d. Nyuszi: %s\n", bunnies, nyuszik[bunnies].nev);
		printf("%d. Vers  : %s\n", bunnies, nyuszik[bunnies].vers);
		printf("%d. Tojas : %d\n", bunnies, nyuszik[bunnies].tojas);
		bunnies++;
	}

	fclose(f);

    int rabbithole[2];
    pipe(rabbithole);

	pid_t gy1 = fork(); 
	if (gy1) {			//parent
		whoami = "fonyuszi";
		close(rabbithole[1]);	//csak olvas

		int num = 0;
		for (int i = 0; i < bunnies; i++){
			sleep(1);
			kill(gy1, SIGUSR1);
			read(rabbithole[0], &num, sizeof(num));
			pt("%d megkapva", num);
			nyuszik[i].tojas += num;
		}
		close(rabbithole[0]);
		pt("osszegzes...");

		int max = -1;
		int maxindex = -1;
		for (int i = 0; i < bunnies; i++){
			if (nyuszik[i].tojas > max){
				max = nyuszik[i].tojas;
				maxindex = i;
			}
		}

		pt("A locsolokiraly nyuszi sorszama: %d", maxindex);
		pt("A locsolokiraly nyuszi neve   : %s", nyuszik[maxindex].nev);
		pt("A locsolokiraly nyuszi verse  : %s", nyuszik[maxindex].vers);
		pt("A locsolokiraly nyuszi tojasai: %d", nyuszik[maxindex].tojas);
		
		int temp = open("temp.txt", O_CREAT | O_EXCL | O_WRONLY, S_IRUSR | S_IWUSR | S_IXUSR);
		if (temp < 0) { printf("HIBA: temp fajl betoltes sikertelen!\n"); return; }
		
		for (int i = 0; i < bunnies; i++){
			write(temp, nyuszik[i].nev, sizeof(char)*strlen(nyuszik[i].nev));
			write(temp, "\n", sizeof(char));
			write(temp, nyuszik[i].vers, sizeof(char)*strlen(nyuszik[i].vers));
			write(temp, "\n", sizeof(char));
			char egg[7];
			sprintf(egg, "%d", nyuszik[i].tojas);
			write(temp, egg, sizeof(char)*strlen(egg));
			write(temp, "\n", sizeof(char));
		}

		close(temp);

		remove("nyuszik.txt");
		rename("temp.txt", "nyuszik.txt");
		
		sleep(1);
		pt("osszegzes vege");
	}else{				//child
		whoami = "nyuszifiuk";
		close(rabbithole[0]);	//csak ir

		signal(SIGUSR1, handler);

		srand(time(NULL));
		for (int i = 0; i < bunnies; i++){
			pause();
			pt("%d. nyuszi: %s", i, nyuszik[i].vers);
			int num = rand() % 20 + 1;
			pt("%d. nyuszi: %d tojast kap!", i, num);
			write(rabbithole[1], &num, sizeof(num));
		}

		close(rabbithole[1]);

		pt("locsolas vege");
		kill(getpid(), SIGKILL);
	}
}

void jelentkezes(char* file){
	printf("\n======LOCSOLOKIRALY: JELENTKEZES======\n");

	char name[21];
	char vers[201];

	char c;
	printf("Adja meg a nevet: ");
	scanf("%20[^\n]s", &name);
	do {
		scanf("%c", &c);
	} while (c != '\n');
	printf("Adja meg a versiket: ");
	scanf("%200[^\n]s", &vers);
	do {
		scanf("%c", &c);
	} while (c != '\n');

	//printf("%s %s", name, vers);

	int f = open(file, O_WRONLY | O_APPEND);
	if (f < 0) { printf("HIBA: fajl betoltes sikertelen!"); return; }
	
	write(f, name, strlen(name)*sizeof(char));
	write(f, "\n", sizeof(char));
	write(f, vers, strlen(vers)*sizeof(char));
	write(f, "\n0\n", 3*sizeof(char));

	close(f);

	printf("Versenyzo letrehozva a kovetkezo adatokkal:\nNEV: %s\nVERS: %s\nTOJAS DB: 0\n", name, vers);
}

void modositas(char* file){
	printf("\n======LOCSOLOKIRALY: MODOSITAS======\n");

	char c;
	int id;
	
	char name[21];
	char vers[201];
	char egg[7];

	printf("Adja meg, melyik sorszamu nyuszit adatait modositsuk: ");
	scanf("%d", &id);
	do {
		scanf("%c", &c);
	} while (c != '\n');
	printf("Adja meg az uj nevet: ");
	scanf("%20[^\n]s", &name);
	do {
		scanf("%c", &c);
	} while (c != '\n');
	printf("Adja meg az uj versiket: ");
	scanf("%200[^\n]s", &vers);
	do {
		scanf("%c", &c);
	} while (c != '\n');
	printf("Adja meg az uj tojas szamot: ");
	scanf("%6[^\n]s", &egg);
	do {
		scanf("%c", &c);
	} while (c != '\n');

	for (int i = 0; i < strlen(egg); i++){
		if (!isdigit(egg[i])) { printf("HIBA: nem megfelelo formatum!\n"); return; }
	}

	int temp = open("temp.txt", O_CREAT | O_EXCL | O_WRONLY, S_IRUSR | S_IWUSR | S_IXUSR);
	if (temp < 0) { printf("HIBA: temp fajl betoltes sikertelen!\n"); return; }

	int f = open(file, O_RDONLY);
	if (f < 0) { printf("HIBA: alap fajl betoltes sikertelen\n"); return; }

	int rows = 0;
	int bunnies = 0;
	int reached = 0;

	while(read(f, &c, sizeof(c))){
		if (bunnies == id) {
			if (!reached) {
				//printf("%s", name);
				//printf("\n");
				//printf("%s", vers);
				//printf("\n");
				//printf("%s", egg);
				//printf("\n");
				write(temp, name, sizeof(char)*strlen(name));
				write(temp, "\n", sizeof(char));
				write(temp, vers, sizeof(char)*strlen(vers));
				write(temp, "\n", sizeof(char));
				write(temp,  egg, sizeof(char)*strlen(egg));
				write(temp, "\n", sizeof(char));
			}
			reached = 1;

		} else {
			//printf("%c", c);
			write(temp, &c, sizeof(char));
		}
		if (c == '\n') {
			rows++;
			if (rows % 3 == 0) {
				bunnies++;
			}
		}
	}



	close(temp);
	close(f);

	remove("nyuszik.txt");
	rename("temp.txt", "nyuszik.txt");

	printf("%d. jelentkezo adatai a kovetkezokre modosultak:\nNEV: %s\nVERS: %s\nTOJAS DB: %s\n", id, name, vers, egg);
}

void torles(char* file){
	printf("\n======LOCSOLOKIRALY: TORLES======\n");

	int id;
	char c;
	
	printf("Adja meg, melyik sorszamu nyuszit toroljuk: ");
	scanf("%d", &id);
	do {
		scanf("%c", &c);
	} while (c != '\n');

	//printf("%d\n", id);

	if (id < 0) { printf("HIBA: 0-nal nagyobb szamot adjon meg!\n"); return; }
	if (id > 200) { printf("HIBA: megadott ertek tul nagy!\n"); return; }

	int f = open(file, O_RDWR);
	if (f < 0) { printf("HIBA: fajl betoltes sikertelen!\n"); return; }

	int temp = open("temp.txt", O_CREAT | O_EXCL | O_WRONLY, S_IRUSR | S_IWUSR | S_IXUSR);
	if (temp < 0) { printf("HIBA: temp fajl betoltes sikertelen!"); return; }

	int rows = 0;
	int bunnies = 0;
	int reached = 0;

	while (read(f, &c, sizeof(c))){
		if (bunnies != id){
			write(temp, &c, sizeof(char));
		}
		if (c == '\n'){
			rows++;
			if (rows % 3 == 0){
				bunnies++;
			}
		}
	}

	close(f);
	close(temp);

	remove("nyuszik.txt");
	rename("temp.txt", "nyuszik.txt");

	printf("%d. jelentkezo torolve.\n", id);
}

void listazas(char* file){
	printf("\n======LOCSOLOKIRALY: LISTAZAS======\n");

	int f = open(file, O_RDONLY);
	if (f < 0) { printf("HIBA: fajl betoltes sikertelen!\n"); return; }

	int rows = 0;
	int bunnies = 0;
	char c;

	printf("NYUSZI %i:\n\t", bunnies);
	while (read(f, &c, sizeof(c))){
		if (c != '\n'){
			printf("%c", c);
		}
		if (c == '\n'){
			rows++;
			if (rows % 3 != 0){
				printf("\n\t", c);
			} else {
				bunnies++;
				printf("\n\nNYUSZI %i:\n\t", bunnies);
			}	
		}
	}
	printf("---uj nyuszi ide fog kerulni---");

	close(f);
}

