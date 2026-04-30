param(
    [string]$arg1 = ""
)

if ($args.Count -lt 1) 
{
    exit 1
}

switch ($arg1) 
{
    "-lista" 
    {
        $oktato = $args[1]
        $targyak = Get-Content "teams.dat" | Where-Object { $ -like "$oktato" } | ForEach-Object { ($ -split ",")[0] }

        foreach ($i in $targyak) 
        {
            Write-Output $i
        }
    }
    "-hallgato" 
    {
        $diak = $args[1]
        $diakKodok = Get-Content "hallgato.dat" | Where-Object { $ -match "$diak" } | ForEach-Object { ($ -split ",")[1] }

        foreach ($i in $diakKodok) 
        {
            $oktatok = Get-Content "teams.dat" | Where-Object { $ -match "$i" } | ForEach-Object { ($ -split ",")[2] }
            Write-Output $oktatok
        }
    }
    "-sok" {
        $oktatoMax = 0
        $oktatoNev = ""

        $oktatok = Get-Content "teams.dat" | ForEach-Object { ($ -split ",")[2] -replace ' ', '' } | Get-Unique

        foreach ($oktato in $oktatok) 
        {
            $oktatoMod = $oktato -replace '', ' '
            $oktatoJelenlegi = Get-Content "teams.dat" | Where-Object { $ -like "$oktatoMod" } | Measure-Object | Select-Object -ExpandProperty Count

            if ($oktatoJelenlegi -gt $oktatoMax) 
            {
                $oktatoMax = $oktatoJelenlegi
                $oktatoNev = $oktato
            }
        }

        $oktatoNev = $oktatoNev -replace '_', ' '
        Write-Output $oktatoNev
    }
    default 
    {
        Write-Output "Hibás input!"
    }
}