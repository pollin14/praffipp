<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />




<title>Descarga</title>
</head>

<body>



<cfset Id_Prog=#url.Id_Prog#>
<cfset Id_EntFed=#url.Id_EntFed#>
<cfset Trim_Captura=#url.Trim_Captura#>
<cfset Tipo=#url.Tipo#>

<!---
<cfoutput >Id_Prog=M#Id_Prog#M</cfoutput><br />
<cfoutput >Id_EntFed=M#Id_EntFed#M</cfoutput><br />
<cfoutput >Trim_Captura=M#Trim_Captura#M</cfoutput><br />
<cfoutput >Tipo=M#Tipo#M</cfoutput><br />
--->

<!--- OBTENEMOS LA UBICACION --->
<cfquery name="Transfer" datasource="prafipp">
    SELECT	Ubicacion
    FROM	Cargas
    WHERE	Id_Prog=#Id_Prog#
    AND		Id_EntFed=#Id_EntFed#
    AND		Trim_Captura=#Trim_Captura#
    AND		Tipo='#Tipo#'
</cfquery>
<cfoutput query="Transfer">
	<cfset ruta=Trim(#Ubicacion#)>
</cfoutput>

<!--- OBTENEMOS EL NOMBRE --->
<cfset FileName=''>
<cfdirectory action="list" directory="#ruta#" name="qGetDirectory" />
<cfoutput>
<cfloop query="qGetDirectory">
	<cfset FileName=#qGetDirectory.name#>
</cfloop>
</cfoutput>


<cfset slash="\">
<cfset Frase=Trim(#ruta#) & #slash# & #FileName#>


<cfoutput>
Ruta=#Frase#
PDF = #find(".pdf",FileName)#<br>
WORD = #find(".doc",FileName)#<br>
EXCEL = #find(".xls",FileName)#<br>
nombre=#FileName#<br>
Frase=#Frase#<br>
</cfoutput>



<!--- Borramos el contenido de la carpeta --->
<cfif FileName is not ''>
	<!--- Leer Directorio --->
	<cfdirectory
		action="list"
		directory="D:\Apache\htdocs\praffipp\archivo\"
		recurse="true"
		listinfo="name"
		name="qFile"/>
	<!--- Recorremos todos los archivos y los borramos --->
	<cfloop query="qFile">
		<cffile action="delete" file="D:\Apache\htdocs\praffipp\archivo\#qFile.name#">
	</cfloop>
</cfif>    
<!--- Fin borrar --->


<!---
<cfif (#find(".xls",FileName)#) GT 0>
    <cfif (#find(".xlsx",FileName)#) GT 0>
        <cffile action="copy"
            source="#Frase#"
            destination="C:\Program Files (x86)\Apache Software Foundation\Apache2.2\htdocs\prafipp\archivo\#FileName#">
        <cflocation url="archivo/#FileName#">
	<cfelse>
        <cffile action="copy"
            source="#Frase#"
            destination="C:\Program Files (x86)\Apache Software Foundation\Apache2.2\htdocs\prafipp\archivo\#FileName#">
        <cflocation url="archivo/#FileName#">    
    </cfif>

<cfelseif (#find(".doc",FileName)#) GT 0>

	<cfif (#find(".docx",FileName)#) GT 0>
        <cffile action="copy"
            source="#Frase#"
            destination="C:\Program Files (x86)\Apache Software Foundation\Apache2.2\htdocs\prafipp\archivo\#FileName#">
        <cflocation url="archivo/#FileName#">
	<cfelse>
        <cffile action="copy"
            source="#Frase#"
            destination="C:\Program Files (x86)\Apache Software Foundation\Apache2.2\htdocs\prafipp\archivo\#FileName#">
        <cflocation url="archivo/#FileName#">
    </cfif>
<cfelse>
    <cffile action="copy"
        source="#Frase#"
        destination="C:\Program Files (x86)\Apache Software Foundation\Apache2.2\htdocs\prafipp\archivo\#FileName#">
    <cflocation url="archivo/#FileName#">
</cfif>
--->

<cffile action="copy"
    source="#Frase#"
    destination="D:\Apache\htdocs\praffipp\archivo\#FileName#">
<cflocation url="archivo/#FileName#">



<!--- Descarga por medio de instrucciones COLDFUSION
<cfoutput>
<cfheader name="Content-Disposition" value="attachment; filename=#nombre#">
    <cfcontent type="application/pdf" file="#Frase#">
</cfoutput>
--->




</body>
</html>






