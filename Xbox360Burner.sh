#!/bin/sh

echo -n "Il percorso del masterizzatore è /dev/sr0 ?"
echo -n "[S/N] (default S): "
read de


if [ "$de" = "n" ]; then
	echo "inserisci il percorso del masterizzatore"
	read dev
	else
	dev="/dev/sr0"
	fi

echo -n "Vuoi Creare o Masterizzare un file iso? "
echo -n "[c/m] (m): "
read cm


if [ "$cm" = "c" ]; then
	echo "inserisci il percorso della cartella in cui creare il file"
	read p
	if [ "${p:(-1):1}" != "/" ]; then
	
	p="$p/"

	fi
	cd "$p"

	echo "inserisci il nome che vuoi dare al file senza estenzione"
	read name


	echo "Sto creando il file "name.iso" in: $p"
	echo "Attendere..."

	dd if="$dev" of="$name.iso"

	echo "File immagine creato"

	echo -n "Vuoi anche masterizzare il gioco? "
	echo "[S/N] (default S): "
	read mast

if [ "$mast" != "n" ]; then
	
	echo -n "E' un gioco XGD3?"
	echo -n "[S/N] (default N): "
	read xdg

	if [ "$xdg" = "s" ]; then
	


		echo "Quando hai inserito il DVD-DL vuoto premi invio per iniziare la masterizzazione"
		read
		truncate --size=8547991552 "$name.iso"
		growisofs -use-the-force-luke=dao -use-the-force-luke=break:2086912 -dvd-compat -speed=4 -Z "$dev"="$name.iso"
	else
		echo "Quando hai inserito il DVD-DL vuoto premi invio per iniziare la masterizzazione"
		read
		growisofs -use-the-force-luke=dao -use-the-force-luke=break:1913760 -dvd-compat -speed=4 -Z "$dev"="$name.iso"

	fi

	echo "Masterizzazione completata :D"	

	echo -n "Vuoi eliminare il file? "
	echo -n "[S/N] (default S)"
	read elimina

	if 
		[ "$elimina" != "n" ]; then
	rm "$name.iso"
	echo "Ho eliminato il file iso salvato in precedenza"
	fi
fi

else

	echo -n "inserisci il percorso della cartella dove è contenuto il file: "
	read folder

	if [ "${folder:(-1):1}" != "/" ]; then
	
	folder="$folder/"

	fi

	cd "$folder"

	echo "inserisci il nome del file senza estensione: "
	ls
	read img
	echo -n "E' un gioco XGD3?"
	echo -n "[S/N] (default N): "
	read xdg

	if [ "$xdg" = "s" ]; then
		echo "Quando hai inserito il DVD-DL vuoto premi invio per iniziare la masterizzazione"
		read
		echo "Sto copiando il file per effettuare un truncate..."
		cp "$img.iso" "$img.xgd3"
		truncate --size=8547991552 "$img.xgd3"
		growisofs -use-the-force-luke=dao -use-the-force-luke=break:2086912 -dvd-compat -speed=4 -Z /dev/sr0="$img.xgd3"
		rm "$img.xgd3"
	else
		echo "Quando hai inserito il DVD-DL vuoto premi invio per iniziare la masterizzazione"
		read
		growisofs -use-the-force-luke=dao -use-the-force-luke=break:1913760 -dvd-compat -speed=4 -Z /dev/sr0="$img.iso"
	fi

	echo "Masterizzazione completata :D"
fi

echo "Premi un tasto per uscire."
read
exit