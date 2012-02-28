#!/bin/sh

echo -n "Vuoi copiare un cd o solo masterizzare un file iso? "
echo -n "[cd/iso] (default iso): "
read i


if [ "$i" = "cd" ]; then
	echo "Sto creando il file iso nella tua home"
	echo "Attendere..."
	cd ~
	dd if=/dev/sr0 of=img.iso
	echo -n "File immagine creato"
	echo -n "E' un disco XGD3?"
	echo -n "[S/N] (default N): "
	read xdg

	if [ "$xdg" = "s" ]; then
		echo "Quando hai inserito il DVD-DL vuoto premi invio per iniziare la masterizzazione"
		read
		truncate --size=8547991552 $img$e
		growisofs -use-the-force-luke=dao -use-the-force-luke=break:2086912 -dvd-compat -speed=4 -Z /dev/sr0=img.iso
	else
		echo "Quando hai inserito il DVD-DL vuoto premi invio per iniziare la masterizzazione"
		read
		growisofs -use-the-force-luke=dao -use-the-force-luke=break:1913760 -dvd-compat -speed=4 -Z /dev/sr0=img.iso
	
	fi

	echo "Masterizzazione completata :D"	
	rm img.iso
	echo "Ho eliminato il file iso salvato in precedenza"

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
	echo -n "E' un disco XGD3?"
	echo -n "[S/N] (default N): "
	read xdg

	if [ "$xdg" = "s" ]; then
		echo "Quando hai inserito il DVD-DL vuoto premi invio per iniziare la masterizzazione"
		read
		truncate --size=8547991552 "$img.iso"
		growisofs -use-the-force-luke=dao -use-the-force-luke=break:2086912 -dvd-compat -speed=4 -Z /dev/sr0="$img.iso"
	else
		echo "Quando hai inserito il DVD-DL vuoto premi invio per iniziare la masterizzazione"
		read
		growisofs -use-the-force-luke=dao -use-the-force-luke=break:1913760 -dvd-compat -speed=4 -Z /dev/sr0="$img.iso"
	fi

	echo "Masterizzazione completata :D"
fi

read
exit

