


for content in `ls -1 dump/ | sort -r -n -k1.7`
do
fich="dump/$content"
echo "***** Parsing $fich  ****"

for ind in `seq 1 2 20`;
do

		indice=$ind
		comando="cat $fich | xidel --extract-kind='css' -e '#contenido > div.detalleInfo > table > tbody > tr:nth-child($indice)' --data=- 2>/dev/null | column -t"
		# echo $comando
		res=$(eval $comando)

		j=0
		old_IFS=$IFS
		while IFS= read -r line ; do 
			case "$j" in
				"0")
					echo -n "Pos global: "; 
					echo $line; 
					;;
				"1")
					echo -n "Pos categ: "; 
					echo $line; 
					;;
				"2")
					echo -n "Tiempo: "; 
					echo $line; 
					;;
				"3")
					echo -n "Nombre: "; 
					echo $line; 
					;;
				"4")
					echo -n "Apellidos: "; 
					echo $line; 
					;;

				"5")
					echo -n "Categ: "; 
					echo $line; 
					;;
				"6")
					echo -n "Dorsal: "; 
					echo $line;
					;;
			esac
			let "j++"
		done <<< "$res"
	
		IFS=${old_IFS}
		indice=$((indice+1))
		comando="cat $fich | xidel --extract-kind='css' -e \"#contenido > div.detalleInfo > table > tbody > tr:nth-child($indice)\" --data=- 2>/dev/null | column -t"
		extra=$(eval $comando)
		# echo $comando
		j=0
		while IFS= read -r line ; do 
			case "$j" in
				"1")
					echo -n "Sexo: "; 
					echo $line; 
					;;
				"4")
					echo -n "Tiempo real: "; 
					echo $line; 
					;;

				"6")
					echo -n "Ritmo: "; 
					echo $line;
					;;
				"9")
					echo -n "Tiempo oficial 1: "; 
					echo $line;
					;;
				"11")
					echo -n "Pos. 1: "; 
					echo $line;
					;;

				esac
				j=$((j+1))
			done <<< "$extra"
		IFS=${old_IFS}
		done
	done # bucle for indice
