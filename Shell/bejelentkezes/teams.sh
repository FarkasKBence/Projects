#!/bin/sh

if [ $# -gt 0 ] #ha van legalább 1 argumentum
then
	#csak akkor működik, ha a fájlok ugyanabban a mappában van
	TEAMS="teams.dat"
	HALLGATOK="hallgato.dat"
	case "$1" in
	"-lista")
		if [ $# -gt 1 ] #ha van legalább 2 argumentuma
		then
			oktato=$2
			kurzusok=$(grep -i -w "$oktato" "$TEAMS" |cut -d',' -f1 |sort -u)
			#keresse ki minden azon sort a teams.dat-ban, amelyben szerepel az oktató neve,
			#majd onnan vágja ki a kurzusok neveit
			if [ "$kurzusok" = "" ] #ha a megadott oktatónak nincs kurzusa
			then
				echo "Nincs ilyen oktató: $oktato"
			else
				echo "$oktato kurzusai:"
				for kurzus in $kurzusok
					do echo "$kurzus"
				done
			fi
		else
			echo "Használat: -lista \"[oktatónév]\""
		fi
	;;
	"-hallgato")
		if [ $# -gt 1 ] #ha van legalább 2 argumentuma
		then
			hallgato=$2
			kodok=$(grep -i -w "$hallgato" "$HALLGATOK" |cut -d',' -f2- |tr ',' ' ')
			#kiválogatja azt a sort, amibe a neptnkód van, majd onnan "listázza" a teams kódokat
			if [ "$kodok" = "" ] #ha üres a lista
			then
				echo "Nincs ilyen hallgato: $hallgato"
			else
				echo "$hallgato oktatói:"
				for kod in $kodok
				do
					oktatok=$(grep -w "$kod" "$TEAMS" |cut -d',' -f3)
					echo "$oktatok"
				done |sort -u
			fi
		else
			echo "Használat: -hallgato [neptunkód]"
		fi
	;;
	"-sok")
		oldIFS="$IFS"

		oktato_max_neve=""
		oktato_max=0
		oktatoi_db=0

		IFS="
"

		for oktato in `cat $TEAMS|cut -d"," -f3|sort -u`
		do
			#echo "$oktato oktató kurzusszámait vizsgáljuk."
			oktatoi_db=$(cut -d',' -f3 $TEAMS|grep $oktato -c -w)
			if [ $oktatoi_db -gt $oktato_max ]
			then
				oktato_max=$oktatoi_db
				oktato_max_neve=$oktato
			fi
			#echo "eddig a legtobbet tanito: $oktato_max_neve : $oktato_max"
		done
		echo "$oktato_max_neve"

		IFS="$oldIFS"
	;;
	*)
		echo "Érvénytelen kapcsoló: $1"
	esac
else
		echo "Argumentumok:  -sok  |  -hallgato [neptunkod]  |  -lista \"[oktatonev]\"" #használati útmutató
fi