namespace Turistak
{
    internal class Program
    {
        static void Main(string[] args)
        {
            string[] bevitel;
            Varos v = null;

            Console.Write("Fájl neve: ");
            string bemenet = Console.ReadLine();
            using StreamReader inFile = new StreamReader(bemenet);

            if (!inFile.EndOfStream)
            {
                v = new Varos(int.Parse(inFile.ReadLine()));
                Console.WriteLine("{0}. év:", v.ev);
                Console.WriteLine("Város állapota: {0} - {1}", v.allapot, ÁllapotString(v));
            }

            while (!inFile.EndOfStream)
            {
                bevitel = inFile.ReadLine().Split();
                Turista japan = new Japan(int.Parse(bevitel[0]));
                Turista nyugati = new Nyugati(int.Parse(bevitel[1]));
                Turista egyeb = new Egyeb(int.Parse(bevitel[2]));
                v.UjEv();
                Console.WriteLine("{0}. év:", v.ev);
                Console.WriteLine("Japán turisták: tervezett: {0} - tényleges: {1}", japan.fo, japan.TenylegesTurista(v.statusz));
                Console.WriteLine("Nyugati turisták: tervezett: {0} - tényleges: {1}", nyugati.fo, nyugati.TenylegesTurista(v.statusz));
                Console.WriteLine("Egyéb turisták: tervezett: {0} - tényleges: {1}", egyeb.fo, egyeb.TenylegesTurista(v.statusz));
                v.TuristaHullam(japan, nyugati, egyeb);
                Console.WriteLine("Éves bevétel: {0} Ft", v.bevetel);
                Console.WriteLine("Város állapota: {0} - {1}", v.allapot, ÁllapotString(v));
            }

            Console.WriteLine("\nEbben az évben volt a legjobb a város állapota: {0}", v.max_ev);
        }
        static string ÁllapotString(Varos v)
        {
            if (v.allapot >= 67) return "Jó";
            else if (v.allapot >= 34) return "Átlagos";
            else return "Lepusztult";
        }
    }
}
