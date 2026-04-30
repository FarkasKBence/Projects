#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <math.h>
#include "BIV5IL_main.h"

int adatok_meret(int meret)
{
	char meret_raw[3];
	
	consoleprint(1);
	for (;;)
	{
		int megfelelo = 1;
		printf("Parancs: ");
		scanf("%s", &meret_raw);
		
		for (int i = 0; i < strlen(meret_raw); i++)
		{
			if (!isdigit(meret_raw[i])) { megfelelo = 0; }
		}
		
		if (megfelelo == 1)
		{
			meret = atoi(meret_raw);
			if (meret <= 20 && meret >= 1) { return meret; }
			else { consoleprint(21); }
		}
		else { consoleprint(21); }
	}
}

int adatok_indulas(int indulas)
{
	char indulas_raw[3];
	
	consoleprint(2);
	for (;;)
	{
		int megfelelo = 1;
		printf("Parancs: ");
		scanf("%s", &indulas_raw);
		
		for (int i = 0; i < strlen(indulas_raw); i++)
		{
			if (!isdigit(indulas_raw[i])) { megfelelo = 0; }
		}
		
		if (megfelelo == 1)
		{
			indulas = atoi(indulas_raw);
			if (indulas <= 3 && indulas >= 0) { return indulas; }
			else { consoleprint(22); }
		}
		else { consoleprint(22); }
	}
}

int adatok_forgas(int forgas)
{
	char forgas_raw[3];
	
	consoleprint(3);
	for (;;)
	{
		int megfelelo = 1;
		printf("Parancs: ");
		scanf("%s", &forgas_raw);
		
		for (int i = 0; i < strlen(forgas_raw); i++)
		{
			if (!isdigit(forgas_raw[i])) { megfelelo = 0; }
		}
		
		if (megfelelo == 1)
		{
			forgas = atoi(forgas_raw);
			if (forgas <= 1 && forgas >= 0) { return forgas; }
			else { consoleprint(23); }
		}
		else { consoleprint(23); }
	}
}

void matrix_filecsinalo(int meret, int indulas, int forgas, int matrix[meret*meret])
{
	char file[100] = "spiral-";
	char meret_c[3];
	char indulas_c[2];
	char forgas_c[2];
	
	itoa(meret, meret_c, 10);
	itoa(indulas, indulas_c, 10);
	itoa(forgas, forgas_c, 10);
	
	strcat(file, meret_c);
	strcat(file, "-");
	strcat(file, indulas_c);
	strcat(file, "-");
	strcat(file, forgas_c);
	strcat(file, "-.txt");
	
	printf("Spiral matrix ide lett elmentve: %s\n", file);
	
	FILE *ide;
	
	ide = fopen(file, "w");
	
	int leghosszabb = floor(log10(meret * meret));
	
	for (int i = 0; i < meret; i++)
	{
		for (int j = 0; j < meret; j++)
		{
			if (j != 0)
			{
				fprintf(ide, " ");
			}
			for (int k = 0; k < leghosszabb - floor(log10(matrix[i * meret + j])); k++)
			{
				fprintf(ide, " ");
			}
			fprintf(ide, "%d", matrix[i * meret + j]);
		}
		fprintf(ide, "\n");
    }	
	
	fclose(ide);
}