namespace Turistak
{
    public abstract class Turista
    {
        public int fo;
        protected Turista(int fo)
        {
            this.fo = fo;
        }
        public abstract int TenylegesTurista(Allapot a);
    }
    public class Japan : Turista
    {
        public Japan(int fo) : base(fo) { }
        public override int TenylegesTurista(Allapot a)
        {
            return a.AllapotVonzas(this);
        }
    }
    public class Nyugati : Turista
    {
        public Nyugati(int fo) : base(fo) { }
        public override int TenylegesTurista(Allapot a)
        {
            return a.AllapotVonzas(this);
        }
    }
    public class Egyeb : Turista
    {
        public Egyeb(int fo) : base(fo) { }
        public override int TenylegesTurista(Allapot a)
        {
            return a.AllapotVonzas(this);
        }

    }
}
