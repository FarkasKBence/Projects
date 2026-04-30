#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "BIV5IL_main.h"

int main()
{
	char parancs_raw[2], parancs;
	char file_input[20];
	char *split;
	
	int meret, meret_fake;			/* 1 - 20 */
	int indulas, indulas_fake;		/* 0 = balra, 1 = fel, 2 = jobbra, 3 = le */
	int forgas, forgas_fake;		/* 0 = cw, 1 = ccw */
	int* matrix = malloc(sizeof(int));
	int van_aktual = 0;
	
	for (;;)
	{
		consoleprint(0);
		
		scanf(" %s", parancs_raw);
		parancs = parancs_raw[0];
	
		if (strlen(parancs_raw) == 1)
		{
			switch (parancs)
			{
				case '0':	//fomenu
					consoleprint(-1);
					break;
					
				case '1':	//generalas
					meret = adatok_meret(meret);
					indulas = adatok_indulas(indulas);
					forgas = adatok_forgas(forgas);
					
					van_aktual = 1;
					break;
					
				case '2':	//mentes
					if (van_aktual == 1)
					{
						free(matrix);
						int* matrix = malloc((meret * meret) * sizeof(int));
						matrix_fill(meret, matrix);
						matrix_spiral(indulas, forgas, meret, matrix);
						matrix_filecsinalo(meret, indulas, forgas, matrix);
					}
					else
					{
						consoleprint(10);
					}
					break;
					
				case '3':	//fajbol toltes
					printf("Fajl: ");
					scanf("%s", &file_input);
					
					FILE *file = fopen(file_input, "r");

					if (file == NULL)
					{
						printf("Nincs ilyen fajl!\n");
						fclose(file);
					}
					else
					{	
						printf("Betoltes, kerem varjon...\n");
						
						split = strtok(file_input, "-");
   
						for (int i = 1; i <= 3; i++ ) 
						{
							split = strtok(NULL, "-");
							if (i == 1)
							{
								meret_fake = atoi(split);
							}
							else if (i == 2)
							{
								indulas_fake = atoi(split);
							}
							else
							{
								forgas_fake = atoi(split);
							}
						}
						
						if ( meret_fake >= 1 && meret_fake <= 20 && forgas_fake >= 0 && forgas_fake <= 1 && indulas_fake >= 0 && indulas_fake <= 3 )
						{
							meret = meret_fake;
							forgas = forgas_fake;
							indulas = indulas_fake;
							printf("Fajl betoltve!\n");
							van_aktual = 1;
						}
						else
						{
							printf("Hibas fajl!\n");
						}
						fclose(file);
					}
					break;
					
				case '4':	//kiiratas
					if (van_aktual == 1)
					{
						free(matrix);
						int* matrix = malloc((meret * meret) * sizeof(int));
						matrix_fill(meret, matrix);
						matrix_spiral(indulas, forgas, meret, matrix);
						matrix_print(meret, matrix);
					}
					else
					{
						consoleprint(10);
					}
					break;
					
				case '5':	//viszlat
					printf("Kilepes...");
					free(matrix);
					exit(1);
					
				default:	//hiba
					consoleprint(20);
					break;
			}
		}
		else
		{
			consoleprint(20);
		}
	}
	return 0;
}