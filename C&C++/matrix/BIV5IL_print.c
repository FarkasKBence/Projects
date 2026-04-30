#include <stdio.h>
#include <math.h>

void matrix_print(int meret, int matrix[meret*meret])
{
	int leghosszabb = floor(log10(meret * meret));
	
	for (int i = 0; i < meret; i++)
	{
		for (int j = 0; j < meret; j++)
		{
			if (j != 0)
			{
				printf(" ");
			}
			for (int k = 0; k < leghosszabb - floor(log10(matrix[i * meret + j])); k++)
			{
				printf(" ");
			}
			printf("%d", matrix[i * meret + j]);
		}
		printf("\n");
    }	
}

void consoleprint(int meik)
{
	if (meik == -1)
	{
		printf("|==================================================================|\n");
		printf("|                KEZIKONYV: Spiral Matrix Generator                |\n");
		printf("|==================================================================|\n");
		printf("| | Felhasznaloi Kezikonyv:                                        |\n");
		printf("|0| On itt all.  Rovid leirast ad az egyes funkciok mukodeserol.   |\n");
		printf("| |                                                                |\n");
		printf("|==================================================================|\n");
		printf("| | Uj Matrix Generalas:                                           |\n");
		printf("| | Ez a menupont felelos egy uj matrix legeneralasaert.           |\n");
		printf("| | A program harom tulajdonsagot ker be:                          |\n");
		printf("| |  - matrix merete: 1-20 (negyzetmatrix)                         |\n");
		printf("|1|  - indulasi iranya: (0)- balra     (2) - jobbra                |\n");
		printf("| |                     (1)- fel       (3) - le                    |\n");
		printf("| |  - forgas iranya: oramutato jarasaval (0) - megegyezoen es     |\n");
		printf("| |                                       (1) - ellentetesen       |\n");
		printf("| |                                                                |\n");
		printf("|==================================================================|\n");
		printf("| | Matrix Mentese:                                                |\n");
		printf("| | Az aktualis matrixot kiiratja egy .txt allomanyba.             |\n");
		printf("| | Az allomany neve tukrozni fogja a matrix tulajdonsagait.       |\n");
		printf("|2| Pl.: spiral-3-0-0-.txt, spiral-20-2-1-.txt                     |\n");
		printf("| |      ...ahol az elso szam a matrix meretet, masodik az         |\n");
		printf("| |         indulasi, harmadik szam a forgasi iranyat jeloli.      |\n");
		printf("| |                                                                |\n");
		printf("|==================================================================|\n");
		printf("| | Matrix Toltese Fajlbol:                                        |\n");
		printf("|3| A korabban lementett matrixok megnyitasara ad lehetoseget.     |\n");
		printf("| |                                                                |\n");
		printf("|==================================================================|\n");
		printf("| | Aktualis Matrix Kiiratasa:                                     |\n");
		printf("|4| Az aktualis matrixot kiiratja a terminalba.                    |\n");
		printf("| |                                                                |\n");
		printf("|==================================================================|\n");
		printf("| | Kilepes:                                                       |\n");
		printf("|5| Hivasaval a program befejezodik.                               |\n");
		printf("| |                                                                |\n");
		printf("|==================================================================|\n");
	}
	else if (meik == 0)
	{
		printf("|=================================|\n");
		printf("| FOMENU: Spiral Matrix Generator |\n");
		printf("|=================================|\n");
		printf("|0| Felhasznaloi Kezikonyv        |\n");
		printf("|1| Uj Matrix Generalas           |\n");
		printf("|2| Matrix Mentese                |\n");
		printf("|3| Matrix Toltese Fajlbol        |\n");
		printf("|4| Aktualis Matrix Kiiratasa     |\n");
		printf("|5| Kilepes                       |\n");
		printf("|=================================|\n");
		printf("Parancs: ");
	}
	else if (meik == 1)
	{
		printf("|==============================|\n");
		printf("| GENERALAS 1.: Matrix Merete  |\n");
		printf("|==============================|\n");
		printf("| Opciok:                      |\n");
		printf("| 1, 2, 3, ... , 18, 19, 20    |\n");
		printf("|                              |\n");
		printf("|==============================|\n");
	}
	else if (meik == 2)
	{
		printf("|==============================|\n");
		printf("| GENERALAS 2.: Indulasi Irany |\n");
		printf("|==============================|\n");
		printf("| Opciok:                      |\n");
		printf("| (0)- balra     (2) - jobbra  |\n");
		printf("| (1)- fel       (3) - le      |\n");
		printf("|                              |\n");
		printf("|==============================|\n");
	}
	else if (meik == 3)
	{
		printf("|==============================|\n");
		printf("| GENERALAS 3.: Forgasi Irany  |\n");
		printf("|==============================|\n");
		printf("| Opciok:                      |\n");
		printf("| oramutato jarasaval...       |\n");
		printf("| (0) - megegyezoen            |\n");
		printf("| (1) - ellentetesen           |\n");
		printf("|                              |\n");
		printf("|==============================|\n");
	}                                      
	else if (meik == 20)
	{
		printf("|=====================|\n");
		printf("| INPUT HIBA: FOMENU  |\n");
		printf("|=====================|\n");
		printf("| Alkalmas bemenetek: |\n");
		printf("| 0, 1, 2, 3, 4, 5    |\n");
		printf("|                     |\n");
		printf("|=====================|\n");
	}
	else if (meik == 21)
	{
		printf("|==========================|\n");
		printf("| INPUT HIBA: GENERALAS 1. |\n");
		printf("|==========================|\n");
		printf("| Alkalmas bemenetek:      |\n");
		printf("| 1, 2, ... , 18, 19, 20   |\n");
		printf("|                          |\n");
		printf("|==========================|\n");
	}
	else if (meik == 22)
	{
		printf("|==========================|\n");
		printf("| INPUT HIBA: GENERALAS 2. |\n");
		printf("|==========================|\n");
		printf("| Alkalmas bemenetek:      |\n");
		printf("| (0) - balra (2) - jobbra |\n");
		printf("| (1) - fel   (3) - le     |\n");
		printf("|                          |\n");
		printf("|==========================|\n");
	}
	else if (meik == 23)
	{
		printf("|==========================|\n");
		printf("| INPUT HIBA: GENERALAS 3. |\n");
		printf("|==========================|\n");
		printf("| Alkalmas bemenetek:      |\n");
		printf("| oramutato jarasaval...   |\n");
		printf("| (0) - megegyezoen        |\n");
		printf("| (1) - ellentetesen       |\n");
		printf("|                          |\n");
		printf("|==========================|\n");
	}
	else if (meik == 10)
	{
		printf("Nincs aktualis matrix!\n");
	}
	else
	{
		printf("|==================================|\n");
		printf("| HIBA A CONSOLEPRINT MEGHIVASABAN |\n");
		printf("|==================================|\n");
	}
}