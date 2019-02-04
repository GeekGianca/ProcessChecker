    echo "Nombre y edades"
    echo "---------------"
     
    for LINEA in `cat datos.txt ` #LINEA guarda el resultado del fichero datos.txt
    do
        NOMBRE=`echo $LINEA | cut -d ":" -f1` #Extrae nombre
        EDAD=`echo $LINEA | cut -d ":" -f2` #Extrae edad
        PID=`echo $LINEA | cut -d ":" -f3` #Extrae pid
     	echo $NOMBRE
     	echo $EDAD
     	echo $PID
        #echo "$NOMBRE tiene $EDAD años." #Muestra resultado.
    done