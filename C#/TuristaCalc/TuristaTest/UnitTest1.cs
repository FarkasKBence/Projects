using Turistak;
namespace TuristaTest
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TuristaInit()
        {
            Japan japan = new Japan(1000);
            Nyugati nyugati = new Nyugati(2000);
            Egyeb egyeb = new Egyeb(3000);

            Assert.AreEqual(1000, japan.fo);
            Assert.AreEqual(2000, nyugati.fo);
            Assert.AreEqual(3000, egyeb.fo);
        }

        [TestMethod]
        public void AllapotInstance()
        {
            Allapot allapot = Jo.Instance();
            Assert.AreEqual(allapot, Jo.Instance());
            allapot = Atlagos.Instance();
            Assert.AreEqual(allapot, Atlagos.Instance());
            allapot = Rossz.Instance();
            Assert.AreEqual(allapot, Rossz.Instance());
        }

        [TestMethod]
        public void JoAllapot()
        {
            Allapot allapot = Jo.Instance();
            Japan japan = new Japan(10);
            Nyugati nyugati = new Nyugati(100);
            Egyeb egyeb = new Egyeb(1000);

            Assert.AreEqual(12, allapot.AllapotVonzas(japan));
            Assert.AreEqual(130, allapot.AllapotVonzas(nyugati));
            Assert.AreEqual(1000, allapot.AllapotVonzas(egyeb));
        }

        [TestMethod]
        public void AtlagosAllapot()
        {
            Allapot allapot = Atlagos.Instance();
            Japan japan = new Japan(10);
            Nyugati nyugati = new Nyugati(100);
            Egyeb egyeb = new Egyeb(1000);

            Assert.AreEqual(10, allapot.AllapotVonzas(japan));
            Assert.AreEqual(110, allapot.AllapotVonzas(nyugati));
            Assert.AreEqual(1100, allapot.AllapotVonzas(egyeb));
        }

        [TestMethod]
        public void RosszAllapot()
        {
            Allapot allapot = Rossz.Instance();
            Japan japan = new Japan(10);
            Nyugati nyugati = new Nyugati(100);
            Egyeb egyeb = new Egyeb(1000);

            Assert.AreEqual(0, allapot.AllapotVonzas(japan));
            Assert.AreEqual(100, allapot.AllapotVonzas(nyugati));
            Assert.AreEqual(1000, allapot.AllapotVonzas(egyeb));
        }

        [TestMethod]
        public void JapanTurista()
        {
            Japan japan = new Japan(1000);

            Allapot allapot = Jo.Instance();
            Assert.AreEqual(1200, japan.TenylegesTurista(allapot));
            allapot = Atlagos.Instance();
            Assert.AreEqual(1000, japan.TenylegesTurista(allapot));
            allapot = Rossz.Instance();
            Assert.AreEqual(0, japan.TenylegesTurista(allapot));
        }

        [TestMethod]
        public void NyugatiTurista()
        {
            Nyugati nyugati = new Nyugati(1000);

            Allapot allapot = Jo.Instance();
            Assert.AreEqual(1300, nyugati.TenylegesTurista(allapot));
            allapot = Atlagos.Instance();
            Assert.AreEqual(1100, nyugati.TenylegesTurista(allapot));
            allapot = Rossz.Instance();
            Assert.AreEqual(1000, nyugati.TenylegesTurista(allapot));
        }

        [TestMethod]
        public void EgyebTurista()
        {
            Egyeb egyeb = new Egyeb(1000);

            Allapot allapot = Jo.Instance();
            Assert.AreEqual(1000, egyeb.TenylegesTurista(allapot));
            allapot = Atlagos.Instance();
            Assert.AreEqual(1100, egyeb.TenylegesTurista(allapot));
            allapot = Rossz.Instance();
            Assert.AreEqual(1000, egyeb.TenylegesTurista(allapot));
        }

        [TestMethod]
        public void VarosInitJo()
        {
            Varos varos;

            varos = new Varos(100);
            Assert.AreEqual(0, varos.bevetel);
            Assert.AreEqual(0, varos.ev);
            Assert.AreEqual(0, varos.max_ev);
            Assert.AreEqual(100, varos.allapot);
            Assert.AreEqual(100, varos.max_allapot);
            Assert.AreEqual(Jo.Instance(), varos.statusz);
        }

        [TestMethod]
        public void VarosInitAtlagos()
        {
            Varos varos = new Varos(66);
            Assert.AreEqual(0, varos.bevetel);
            Assert.AreEqual(0, varos.ev);
            Assert.AreEqual(0, varos.max_ev);
            Assert.AreEqual(66, varos.allapot);
            Assert.AreEqual(66, varos.max_allapot);
            Assert.AreEqual(Atlagos.Instance(), varos.statusz);
        }

        [TestMethod]
        public void VarosInitRossz()
        {
            Varos varos = new Varos(33);
            Assert.AreEqual(0, varos.bevetel);
            Assert.AreEqual(0, varos.ev);
            Assert.AreEqual(0, varos.max_ev);
            Assert.AreEqual(33, varos.allapot);
            Assert.AreEqual(33, varos.max_allapot);
            Assert.AreEqual(Rossz.Instance(), varos.statusz);
        }

        [TestMethod]
        public void VarosUjAllapot()
        {
            Varos varos;

            varos = new Varos(100);
            Assert.AreEqual(Jo.Instance(), varos.UjAllapot());
            varos = new Varos(67);
            Assert.AreEqual(Jo.Instance(), varos.UjAllapot());
            varos = new Varos(66);
            Assert.AreEqual(Atlagos.Instance(), varos.UjAllapot());
            varos = new Varos(50);
            Assert.AreEqual(Atlagos.Instance(), varos.UjAllapot());
            varos = new Varos(34);
            Assert.AreEqual(Atlagos.Instance(), varos.UjAllapot());
            varos = new Varos(33);
            Assert.AreEqual(Rossz.Instance(), varos.UjAllapot());
            varos = new Varos(1);
            Assert.AreEqual(Rossz.Instance(), varos.UjAllapot());
        }

        [TestMethod]
        public void VarosUjEv()
        {
            Varos varos = new Varos(50);
            Assert.AreEqual(0, varos.ev);
            varos.UjEv();
            Assert.AreEqual(1, varos.ev);
            varos.UjEv();
            Assert.AreEqual(2, varos.ev);
            varos.UjEv();
            Assert.AreEqual(3, varos.ev);
        }

        [TestMethod]
        public void TuristaHullam1()
        {
            Varos varos = new Varos(59); //0. év - 59
            Turista japan; Turista nyugati; Turista egyeb;

            varos.UjEv();                //1. év - 80
            japan = new Japan(220000);
            nyugati = new Nyugati(1000);
            egyeb = new Egyeb(500);
            Assert.AreEqual(220000, japan.TenylegesTurista(varos.statusz));
            Assert.AreEqual(1100, nyugati.TenylegesTurista(varos.statusz));
            Assert.AreEqual(550, egyeb.TenylegesTurista(varos.statusz));
            varos.TuristaHullam(japan, nyugati, egyeb);
            Assert.AreEqual(80, varos.allapot); //1100 / 100 = -11, 550 / 50 = -11 | 221.650 -> 21.650 / 500 = +43 (59+43-11-11=80)
            Assert.AreEqual(Jo.Instance(), varos.statusz);
            Assert.AreEqual((long)(220000 + 1100 + 550) * 100000, varos.bevetel);

            varos.UjEv();               //2. év - 1
            japan = new Japan(8000);
            nyugati = new Nyugati(5000);
            egyeb = new Egyeb(3000);
            Assert.AreEqual(9600, japan.TenylegesTurista(varos.statusz));
            Assert.AreEqual(6500, nyugati.TenylegesTurista(varos.statusz));
            Assert.AreEqual(3000, egyeb.TenylegesTurista(varos.statusz));
            varos.TuristaHullam(japan, nyugati, egyeb);
            Assert.AreEqual(1, varos.allapot); //5000 / 100 = -50, 3000 / 50 = -60
            Assert.AreEqual(Rossz.Instance(), varos.statusz);
            Assert.AreEqual((long)(9600 + 6500 + 3000) * 100000, varos.bevetel);

            varos.UjEv();               //3. év - 11
            japan = new Japan(5000);
            nyugati = new Nyugati(200000);
            egyeb = new Egyeb(5000);
            Assert.AreEqual(0, japan.TenylegesTurista(varos.statusz));
            Assert.AreEqual(200000, nyugati.TenylegesTurista(varos.statusz));
            Assert.AreEqual(5000, egyeb.TenylegesTurista(varos.statusz));
            varos.TuristaHullam(japan, nyugati, egyeb);
            Assert.AreEqual(11, varos.allapot); //minimumon van, tovább nem csökkenhet | 205000 -> 5000 / 500 = 10 
            Assert.AreEqual(Rossz.Instance(), varos.statusz);
            Assert.AreEqual((long)(0 + 200000 + 5000) * 100000, varos.bevetel);

            Assert.AreEqual(1, varos.max_ev);
        }

        [TestMethod]
        public void TuristaHullam2()
        {
            Varos varos = new Varos(70); //0. év - 70
            Turista japan; Turista nyugati; Turista egyeb;

            varos.UjEv();                //1. év - 31
            japan = new Japan(2004);
            nyugati = new Nyugati(1552);
            egyeb = new Egyeb(987);
            Assert.AreEqual(2404, japan.TenylegesTurista(varos.statusz));
            Assert.AreEqual(2017, nyugati.TenylegesTurista(varos.statusz));
            Assert.AreEqual(987, egyeb.TenylegesTurista(varos.statusz));
            varos.TuristaHullam(japan, nyugati, egyeb);
            Console.WriteLine(2017 / 10);
            Assert.AreEqual(31, varos.allapot); //2017 / 100 = -20, 987 / 50 = -19
            Assert.AreEqual(Rossz.Instance(), varos.statusz);
            Assert.AreEqual((long)(2404 + 2017 + 987) * 100000, varos.bevetel);

            varos.UjEv();                //1. év - 61
            japan = new Japan(99999999);
            nyugati = new Nyugati(675);
            egyeb = new Egyeb(345);
            Assert.AreEqual(0, japan.TenylegesTurista(varos.statusz));
            Assert.AreEqual(675, nyugati.TenylegesTurista(varos.statusz));
            Assert.AreEqual(345, egyeb.TenylegesTurista(varos.statusz));
            varos.TuristaHullam(japan, nyugati, egyeb);
            Assert.AreEqual(19, varos.allapot); //675 / 100 = -6, 345 / 50 = -6
            Assert.AreEqual(Rossz.Instance(), varos.statusz);
            Assert.AreEqual((long)(0 + 675 + 345) * 100000, varos.bevetel);

            Assert.AreEqual(0, varos.max_ev);
        }
    }
}