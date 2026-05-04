namespace Turistak
{
    public class Varos
    {
        public long bevetel;    // 1 fő = 100.000 Ft, 200.000 fő = 20 milliárd Ft, 5000 fő = 50 millió
        public int allapot;
        public int max_allapot;
        public int ev;
        public int max_ev;
        public Allapot statusz;
        public Varos(int allapot)
        {
            bevetel = 0;
            this.allapot = allapot;
            max_allapot = allapot;
            ev = 0;
            max_ev = 0;
            statusz = UjAllapot();
        }
        public Allapot UjAllapot()
        {
            if (allapot >= 67)
                return Jo.Instance();
            else if (allapot >= 34)
                return Atlagos.Instance();
            else
                return Rossz.Instance();
        }

        public void UjEv()
        {
            ev = ev + 1;
        }

        public void TuristaHullam(Turista japan, Turista nyugati, Turista egyeb)
        {
            long latogato = 0;   // 1 fő = 100000 Ft, 200000 fő = 20 milliárd Ft, 500 fő = 50 millió

            latogato += japan.TenylegesTurista(statusz);
            latogato += nyugati.TenylegesTurista(statusz);
            latogato += egyeb.TenylegesTurista(statusz);
            allapot -= nyugati.TenylegesTurista(statusz) / 100;
            allapot -= egyeb.TenylegesTurista(statusz) / 50;

            allapot = Math.Max(1, allapot);

            if (latogato >= 200000)
            {
                allapot += (int)(latogato - 200000) / 500;
            }
            bevetel = latogato * 100000;

            allapot = Math.Min(100, allapot);
            statusz = UjAllapot();
            
            if (allapot > max_allapot)
            {
                max_allapot = allapot;
                max_ev = ev;
            }
        }
    }
}
