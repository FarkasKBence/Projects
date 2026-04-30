#ifndef _BIV5IL_SPIRAL_
#define _BIV5IL_SPIRAL_

void matrix_print(int meret, int matrix[meret*meret]);
void consoleprint(int meik);

void matrix_fill(int meret, int matrix[meret*meret]);
void le_majd_jobb(int *ind_x, int *ind_y, int meret, int matrix[meret*meret], int *kitoltendo);
void jobb_majd_fel(int *ind_x, int *ind_y, int meret, int matrix[meret*meret], int *kitoltendo);
void fel_majd_bal(int *ind_x, int *ind_y, int meret, int matrix[meret*meret], int *kitoltendo);
void bal_majd_le(int *ind_x, int *ind_y, int meret, int matrix[meret*meret], int *kitoltendo);
void le_majd_bal(int *ind_x, int *ind_y, int meret, int matrix[meret*meret], int *kitoltendo);
void bal_majd_fel(int *ind_x, int *ind_y, int meret, int matrix[meret*meret], int *kitoltendo);
void fel_majd_jobb(int *ind_x, int *ind_y, int meret, int matrix[meret*meret], int *kitoltendo);
void jobb_majd_le(int *ind_x, int *ind_y, int meret, int matrix[meret*meret], int *kitoltendo);
void matrix_spiral(int indulas, int forgas, int meret, int matrix[meret*meret]);

int adatok_meret(int meret);
int adatok_indulas(int indulas);
int adatok_forgas(int forgas);
void matrix_filecsinalo(int meret, int indulas, int forgas, int matrix[meret*meret]);

#endif