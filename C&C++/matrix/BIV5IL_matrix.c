void matrix_fill(int meret, int matrix[meret*meret])
{
	for (int i = 0; i < meret; i++)
	{
		for (int j = 0; j < meret; j++)
		{
			matrix[i * meret + j] = -1;
		}
    }
}

void le_majd_jobb(int *ind_x, int *ind_y, int meret, int matrix[meret*meret], int *kitoltendo)
{
	int temp_ind_x = *ind_x;
	int temp_ind_y = *ind_y;
	int temp_kitoltendo = *kitoltendo;
	
	for (;;) //lefele, majd jobbra
	{
		if (matrix[temp_ind_y * meret + temp_ind_x] != -1)
		{
			temp_ind_y--;
			temp_ind_x++;
			break;
		}
		
		matrix[temp_ind_y * meret + temp_ind_x] = temp_kitoltendo;
		temp_kitoltendo--;
		temp_ind_y++;
		
		if (temp_ind_y == meret)
		{
			temp_ind_y--;
			temp_ind_x++;
			break;
		}
	}
	*ind_x = temp_ind_x;
	*ind_y = temp_ind_y,
	*kitoltendo = temp_kitoltendo;
}

void jobb_majd_fel(int *ind_x, int *ind_y, int meret, int matrix[meret*meret], int *kitoltendo)
{
	int temp_ind_x = *ind_x;
	int temp_ind_y = *ind_y;
	int temp_kitoltendo = *kitoltendo;
	
	for (;;) //jobbra, majd felfele
	{
		if (matrix[temp_ind_y * meret + temp_ind_x] != -1)
		{
			temp_ind_y--;
			temp_ind_x--;
			break;
		}
		
		matrix[temp_ind_y * meret + temp_ind_x] = temp_kitoltendo;
		temp_kitoltendo--;
		temp_ind_x++;
		
		if (temp_ind_x == meret)
		{
			temp_ind_y--;
			temp_ind_x--;
			break;
		}
	}
	
	*ind_x = temp_ind_x;
	*ind_y = temp_ind_y,
	*kitoltendo = temp_kitoltendo;
}

void fel_majd_bal(int *ind_x, int *ind_y, int meret, int matrix[meret*meret], int *kitoltendo)
{
	int temp_ind_x = *ind_x;
	int temp_ind_y = *ind_y;
	int temp_kitoltendo = *kitoltendo;
		
	for (;;) //felfele, majd balra
	{
		if (matrix[temp_ind_y * meret + temp_ind_x] != -1)
		{
			temp_ind_y++;
			temp_ind_x--;
			break;
		}
		
		matrix[temp_ind_y * meret + temp_ind_x] = temp_kitoltendo;
		temp_kitoltendo--;
		temp_ind_y--;
		
		if (temp_ind_y < 0)
		{
			temp_ind_y++;
			temp_ind_x--;
			break;
		}
	}
	
	*ind_x = temp_ind_x;
	*ind_y = temp_ind_y,
	*kitoltendo = temp_kitoltendo;
}

void bal_majd_le(int *ind_x, int *ind_y, int meret, int matrix[meret*meret], int *kitoltendo)
{
	int temp_ind_x = *ind_x;
	int temp_ind_y = *ind_y;
	int temp_kitoltendo = *kitoltendo;
		
	for (;;) //balra, majd lefele
	{
		if (matrix[temp_ind_y * meret + temp_ind_x] != -1)
		{
			temp_ind_y++;
			temp_ind_x++;
			break;
		}
		
		matrix[temp_ind_y * meret + temp_ind_x] = temp_kitoltendo;
		temp_kitoltendo--;
		temp_ind_x--;
		
		if (temp_ind_x < 0)
		{
			temp_ind_y++;
			temp_ind_x++;
			break;
		}
	}
	
	*ind_x = temp_ind_x;
	*ind_y = temp_ind_y,
	*kitoltendo = temp_kitoltendo;
}

void le_majd_bal(int *ind_x, int *ind_y, int meret, int matrix[meret*meret], int *kitoltendo)
{
	int temp_ind_x = *ind_x;
	int temp_ind_y = *ind_y;
	int temp_kitoltendo = *kitoltendo;
		
	for (;;)
	{
		if (matrix[temp_ind_y * meret + temp_ind_x] != -1)
		{
			temp_ind_y--;
			temp_ind_x--;
			break;
		}
		
		matrix[temp_ind_y * meret + temp_ind_x] = temp_kitoltendo;
		temp_kitoltendo--;
		temp_ind_y++;
		
		if (temp_ind_y == meret)
		{
			temp_ind_y--;
			temp_ind_x--;
			break;
		}
	}
	
	*ind_x = temp_ind_x;
	*ind_y = temp_ind_y,
	*kitoltendo = temp_kitoltendo;
}

void bal_majd_fel(int *ind_x, int *ind_y, int meret, int matrix[meret*meret], int *kitoltendo)
{
	int temp_ind_x = *ind_x;
	int temp_ind_y = *ind_y;
	int temp_kitoltendo = *kitoltendo;
		
	for (;;)
	{
		if (matrix[temp_ind_y * meret + temp_ind_x] != -1)
		{
			temp_ind_y--;
			temp_ind_x++;
			break;
		}
		
		matrix[temp_ind_y * meret + temp_ind_x] = temp_kitoltendo;
		temp_kitoltendo--;
		temp_ind_x--;
		
		if (temp_ind_x < 0)
		{
			temp_ind_y--;
			temp_ind_x++;
			break;
		}
	}
	
	*ind_x = temp_ind_x;
	*ind_y = temp_ind_y,
	*kitoltendo = temp_kitoltendo;
}

void fel_majd_jobb(int *ind_x, int *ind_y, int meret, int matrix[meret*meret], int *kitoltendo)
{
	int temp_ind_x = *ind_x;
	int temp_ind_y = *ind_y;
	int temp_kitoltendo = *kitoltendo;
		
	for (;;)
	{
		if (matrix[temp_ind_y * meret + temp_ind_x] != -1)
		{
			temp_ind_y++;
			temp_ind_x++;
			break;
		}
		
		matrix[temp_ind_y * meret + temp_ind_x] = temp_kitoltendo;
		temp_kitoltendo--;
		temp_ind_y--;
		
		if (temp_ind_y < 0)
		{
			temp_ind_y++;
			temp_ind_x++;
			break;
		}
	}
	
	*ind_x = temp_ind_x;
	*ind_y = temp_ind_y,
	*kitoltendo = temp_kitoltendo;
}

void jobb_majd_le(int *ind_x, int *ind_y, int meret, int matrix[meret*meret], int *kitoltendo)
{
	int temp_ind_x = *ind_x;
	int temp_ind_y = *ind_y;
	int temp_kitoltendo = *kitoltendo;
		
	for (;;)
	{
		if (matrix[temp_ind_y * meret + temp_ind_x] != -1)
		{
			temp_ind_y++;
			temp_ind_x--;
			break;
		}
		
		matrix[temp_ind_y * meret + temp_ind_x] = temp_kitoltendo;
		temp_kitoltendo--;
		temp_ind_x++;
		
		if (temp_ind_x == meret)
		{
			temp_ind_y++;
			temp_ind_x--;
			break;
		}
	}
	
	*ind_x = temp_ind_x;
	*ind_y = temp_ind_y,
	*kitoltendo = temp_kitoltendo;
}

void matrix_spiral(int indulas, int forgas, int meret, int matrix[meret*meret])
{	
	if (meret == 1)
	{
		matrix[0] = 1;
	}
	else
	{
		int kitoltendo = meret * meret;
		
		if (forgas == 0) 	//clockwise
		{
			if ((indulas == 1 && meret % 2 == 1) || (indulas == 3 && meret % 2 == 0)) 
			{	//fel és paratlan VAGY le és páros
				int ind_x = 0;
				int ind_y = 0;
				while (kitoltendo > 0)
				{
					le_majd_jobb(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					jobb_majd_fel(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					fel_majd_bal(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					bal_majd_le(&ind_x, &ind_y, meret, matrix, &kitoltendo);
				}
			}
			else if ((indulas == 1 && meret % 2 == 0) || (indulas == 3 && meret % 2 == 1)) 
			{	//fel és páros VAGY le és páratlan
				int ind_x = meret - 1;
				int ind_y = meret - 1;
				while (kitoltendo > 0)
				{
					fel_majd_bal(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					bal_majd_le(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					le_majd_jobb(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					jobb_majd_fel(&ind_x, &ind_y, meret, matrix, &kitoltendo);
				}
			}
			else if ((indulas == 0 && meret % 2 == 1) || (indulas == 2 && meret % 2 == 0)) 
			{	//balra és páratlan VAGY jobbra és páros
				int ind_x = 0;
				int ind_y = meret - 1;
				while (kitoltendo > 0)
				{
					jobb_majd_fel(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					fel_majd_bal(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					bal_majd_le(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					le_majd_jobb(&ind_x, &ind_y, meret, matrix, &kitoltendo);
				}
			}
			else if ((indulas == 0 && meret % 2 == 0) || (indulas == 2 && meret % 2 == 1)) 
			{	//balra és páros VAGY jobbra és páratlan
				int ind_x = meret - 1;
				int ind_y = 0;
				while (kitoltendo > 0)
				{
					bal_majd_le(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					le_majd_jobb(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					jobb_majd_fel(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					fel_majd_bal(&ind_x, &ind_y, meret, matrix, &kitoltendo);
				}
			}
		}
		else				//counter-clockwise
		{
			if ((indulas == 1 && meret % 2 == 1) || (indulas == 3 && meret % 2 == 0))
			{ //fel és páratlan VAGY le és páros
				int ind_x = meret - 1;
				int ind_y = 0;
				while (kitoltendo > 0)
				{
					le_majd_bal(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					bal_majd_fel(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					fel_majd_jobb(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					jobb_majd_le(&ind_x, &ind_y, meret, matrix, &kitoltendo);
				}
			}
			else if ((indulas == 1 && meret % 2 == 0) || (indulas == 3 && meret % 2 == 1))
			{ //fel és páros VAGY le és páratlan
				int ind_x = 0;
				int ind_y = meret - 1;
				while (kitoltendo > 0)
				{
					fel_majd_jobb(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					jobb_majd_le(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					le_majd_bal(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					bal_majd_fel(&ind_x, &ind_y, meret, matrix, &kitoltendo);
				}
			}
			else if ((indulas == 0 && meret % 2 == 1) || (indulas == 2 && meret % 2 == 0))
			{ //balra és páratlan VAGY jobbra és páros
				int ind_x = 0;
				int ind_y = 0;
				while (kitoltendo > 0)
				{
					jobb_majd_le(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					le_majd_bal(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					bal_majd_fel(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					fel_majd_jobb(&ind_x, &ind_y, meret, matrix, &kitoltendo);
				}
			}
			else if ((indulas == 0 && meret % 2 == 0) || (indulas == 2 && meret % 2 == 1))
			{ //balra és páros VAGY jobbra és páratlan
				int ind_x = meret - 1;
				int ind_y = meret - 1;
				while (kitoltendo > 0)
				{
					bal_majd_fel(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					fel_majd_jobb(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					jobb_majd_le(&ind_x, &ind_y, meret, matrix, &kitoltendo);
					le_majd_bal(&ind_x, &ind_y, meret, matrix, &kitoltendo);
				}
			}
		}
	}
}