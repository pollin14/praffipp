<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Borrar archivos de respaldo</title>
</head>

<body>



<!--- Borramos el contenido de la carpeta --->
<!---cfif FileName is not ''--->
	<!--- Leer Directorio --->
	<cfdirectory
		action="list"
		directory="C:\Program Files (x86)\Apache Software Foundation\Apache2.2\htdocs\prafipp\archivo\"
		recurse="true"
		listinfo="name"
		name="qFile"/>
	<!--- Recorremos todos los archivos y los borramos --->
	<cfloop query="qFile">
		<cffile action="delete" file="C:\Program Files (x86)\Apache Software Foundation\Apache2.2\htdocs\prafipp\archivo\#qFile.name#">
	</cfloop>
<!---/cfif--->
<!--- Fin borrar --->


<cfoutput><script>window.close();</script></cfoutput>




</body>
</html>





