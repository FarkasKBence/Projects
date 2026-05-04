namespace Turistak
{
    public interface Allapot
    {
        int AllapotVonzas(Japan t);
        int AllapotVonzas(Nyugati t);
        int AllapotVonzas(Egyeb t);
    }
    public class Jo : Allapot
    {
        public int AllapotVonzas(Japan t)
        {
            return (int)(t.fo * 1.2);
        }
        public int AllapotVonzas(Nyugati t)
        {
            return (int)(t.fo * 1.3);
        }
        public int AllapotVonzas(Egyeb t)
        {
            return t.fo;
        }
        private static Jo instance = null;
        public static Jo Instance()
        {
            if (instance == null)
                instance = new Jo();
            return instance;
        }
    }
    public class Atlagos : Allapot
    {
        public int AllapotVonzas(Japan t)
        {
            return t.fo;
        }
        public int AllapotVonzas(Nyugati t)
        {
            return (int)(t.fo * 1.1);
        }
        public int AllapotVonzas(Egyeb t)
        {
            return (int)(t.fo * 1.1);
        }
        private static Atlagos instance = null;
        public static Atlagos Instance()
        {
            if (instance == null)
                instance = new Atlagos();
            return instance;
        }
    }
    public class Rossz : Allapot
    {
        public int AllapotVonzas(Japan t)
        {
            return 0;
        }
        public int AllapotVonzas(Nyugati t)
        {
            return t.fo;
        }
        public int AllapotVonzas(Egyeb t)
        {
            return t.fo;
        }
        private static Rossz instance = null;
        public static Rossz Instance()
        {
            if (instance == null)
                instance = new Rossz();
            return instance;
        }
    }
}
