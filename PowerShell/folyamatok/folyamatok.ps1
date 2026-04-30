$file = "folyamatok.dat"
$file_c = (Get-Content $file)
[int]$i = $file_c.Length
[int]$szamlalo = 0

#Write-Host $file_c[-1].Split(" ")[1]

if ($args.Length -gt 0)
{
    if ($args[0] -eq "-lista")
    {
        ForEach ($sor in $file_c) { Write-Host $sor }
    }
    elseif ($args[0] -eq "-stop" -and $args.Length -gt 1)
    {
        $szam = $args[1]
        ForEach ($sor in $file_c)
        {
            $masodik = $sor.Split(" ")[1]
            if ( $masodik -eq $szam)
            {
                $ezt = $file_c[$szamlalo]
                $ezzel = $sor.Split(" ")[0] + " " + $sor.Split(" ")[1] + " T"
                $uj_file_c = $file_c.Replace($ezt, $ezzel)

                Set-Content $file $uj_file_c
            }
            $szamlalo++
        }
    }
    elseif ($args[0] -eq "-start" -and $args.Length -gt 1)
    {
        $program = $args[1]
        "$program $i S" |Add-Content $file
    }
    elseif ($args[0] -eq "-kill" -and $args.Length -gt 1)
    {

        $szam = $args[1]
        echo $szam
        $uj_file_c = ""
        ForEach ($sor in $file_c)
        {
            $masodik = $sor.Split(" ")[1]
            if ( $masodik -ne $szam)
            {
                if ($uj_file_c -eq "")
                {
                    $uj_file_c = $file_c[$szamlalo]
                }
                else
                {
                    $uj_file_c = $uj_file_c  + "`n" + $file_c[$szamlalo]
                }
            }
            Set-Content $file $uj_file_c
            $szamlalo++
        }
    }
    else
    {
        Write-Host "Lehetséges paraméterek: -start <programnév> | -stop <PID> | -kill <PID> | -lista" -BackgroundColor Blue
    }
}
else
{
    Write-Host "Lehetséges paraméterek: -start <programnév> | -stop <PID> | -kill <PID> | -lista" -BackgroundColor Blue
}

#Write-Host "fájl hossza: $((Get-Content $file).Length)"