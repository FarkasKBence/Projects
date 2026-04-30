/*
 Készítette: Farkas Bence
 Neptun: BIV5IL
 E-mail: biv5il@inf.elte.hu
 Feladat: kis maximumú település
 */

using System;

namespace kismaximumutelepules
{
    internal class Program
    {
        static void Main(string[] args)
        {
            //deklarációk és adatbeolvasás
            int ki;
            int[,] h;
            bool van;

            h = beolvas();

            //feladatmegoldás
            (van, ki) = kereses(h);

            //eredménykiírás
            kiir(van, ki);
        }

        static int[,] beolvas()
        {
            if (Console.IsInputRedirected)
            {
                return beolvas_biro();
            }
            else
            {
                return beolvas_kezi();
            }
        }

        static int[,] beolvas_biro()
        {
            int n, m, i, j;
            string[] bemenet;

            bemenet = Console.ReadLine().Split(" ");
            n = int.Parse(bemenet[0]);
            m = int.Parse(bemenet[1]);

            int[,] h = new int[n + 1, m + 1];

            for (i = 1; i <= n; i++)
            {
                bemenet = Console.ReadLine().Split(" ");
                for (j = 1; j <= m; j++)
                {
                    h[i, j] = int.Parse(bemenet[j - 1]);
                }
            }
            return h;
        }

        static int[,] beolvas_kezi()
        {
            int n, m, i, j;
            bool jo;
            do
            {
                Console.ResetColor();
                Console.Write("Települések száma = ");
                jo = int.TryParse(Console.ReadLine(), out n) && n >= 0;
                if (!jo)
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine("HIBA: Nemnegatív egész szám kell!");
                }
            } while (!jo);
            do
            {
                Console.ResetColor();
                Console.Write("Időjárási előrejelzések száma napokban = ");
                jo = int.TryParse(Console.ReadLine(), out m) && m >= 0;
                if (!jo)
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine("HIBA: Nemnegatív egész szám kell!");
                }
            } while (!jo);

            int[,] h = new int[n + 1, m + 1];
            for (i = 1; i <= n; i++)
            {
                for (j = 1; j <= m; j++)
                {
                    do
                    {
                        Console.ResetColor();
                        Console.Write("{0}. település {1}. napi előrejelzése = ", i, j);
                        jo = int.TryParse(Console.ReadLine(), out h[i, j]);
                        if (!jo)
                        {
                            Console.ForegroundColor = ConsoleColor.Red;
                            Console.WriteLine("HIBA: Egész szám kell!");
                        }
                    } while (!jo);
                }
            }

            return h;
        }

        static (bool van, int ki) kereses(int[,] h)
        {
            int n, telepules, ki;
            n = h.GetLength(0) - 1;
            bool van;

            telepules = 1;
            while (telepules <= n && !van_e_kisebb(telepules, h))
            {
                telepules++;
            }
            van = telepules <= n;
            if (van)
            {
                ki = telepules;
            }
            else
            {
                ki = -1;
            }

            return (van, ki);
        }

        static bool van_e_kisebb(int telepules_ind, int[,] h)
        {
            int n, i;
            bool van;

            n = h.GetLength(0) - 1;

            i = 1;
            while (i <= n && !(mind_kisebb_e(telepules_ind, atlag_hom(i, h), h)))
            {
                i++;
            }
            van = i <= n;
            return van;
        }

        static bool mind_kisebb_e(int telepules_ind, float atlag, int[,] h)
        {
            int m, i;
            bool mind;

            m = h.GetLength(1) - 1;

            i = 1;
            while (i <= m && h[telepules_ind, i] < atlag)
            {
                i++;
            }
            mind = i > m;
            return mind;
        }

        static float atlag_hom(int telepules_ind, int[,] h)
        {
            int m, i, szum;
            float atlag;

            m = h.GetLength(1) - 1;

            szum = 0;
            for (i = 1; i <= m; i++)
            {
                szum = szum + h[telepules_ind, i];
            }

            atlag = (float)szum / m;
            return atlag;
        }

        static void kiir(bool van, int ki)
        {
            if (Console.IsOutputRedirected)
            {
                Console.WriteLine(ki);
            }
            else
            {
                if (!van)
                {
                    Console.ForegroundColor = ConsoleColor.Green;
                    Console.WriteLine("Nincs a feltételnek megfelelő település!");
                }
                else
                {
                    Console.ForegroundColor = ConsoleColor.Green;
                    Console.WriteLine("Van olyan település megfelel a feltételeknek, ilyen például a/az {0}. sorszámú.", ki);
                }
                Console.ForegroundColor = ConsoleColor.Black;
                Console.BackgroundColor = ConsoleColor.Gray;
                Console.WriteLine("Kérem, nyomjon ENTER-t a folytatáshoz!");
                Console.ResetColor();
                Console.ReadLine();
            }
        }
    }
}