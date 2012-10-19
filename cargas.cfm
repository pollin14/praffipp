<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Cargar documentos al Server</title>
</head>

<body>

<table align="center" border="0" cellspacing="0" cellpadding="0" width="487">
<tr><td>
<img src="img/header.jpg" width="487" height="45" alt="Encabezado" />
</td></tr>
</table>

<!---<cfinclude template="chk_session.cfm">--->


<cfset Id_Prog=#url.Prog#>
<cfset Id_EntFed=#url.EntFed#>
<cfset Trim_Captura=#url.Captura#>
<cfset Tipo=#url.Tipo#>
<cfset Directorio="C:\Docs_prafipp\#Id_Prog#\#Id_EntFed#\#Trim_Captura#\#Tipo#">

<!---<cfoutput><p>Directorio= #Directorio#</cfoutput>--->




<!---  CREAMOS EL DIRECTORIO SI NO EXISTE --->
<cfif #Directorio# is not "">
	<cfif DirectoryExists(Directorio)>
		<!---<cfoutput><p>Si existe el directorio #Directorio#</p></cfoutput>--->
	<cfelse>
    	<!---<p>El directorio no existe</p>--->
    	<cfdirectory action = "create" directory = "#Directorio#" >
		<!---<cfoutput><p>Se ha creado el direcotrio #Directorio#</p></cfoutput>--->
	</cfif>
</cfif>





<cfif isDefined("fileUpload")>
	<!--- Borramos el contenido de la carpeta --->
	<!--- Read Directory --->
    <cfdirectory
        action="list"
        directory="#Directorio#"
        recurse="true"
        listinfo="name"
        name="qFile"/>
    <!--- Loop through file query and delete files --->
    <cfloop query="qFile">
        <cffile action="delete" file="#Directorio#\#qFile.name#">
    </cfloop>   

	<!---  CARGAMOS EL ARCHIVO --->
    <cffile action="upload"
        fileField="fileUpload"
        destination="#Directorio#"
        nameConflict = "behavior"> 
		<!---<p>El archivo se ha cargado al sistema.</p>--->

	<!---  INSERTAMOS REGISTRO EN LA BASE DE DATOS --->

	<!--- CONTADOR --->
    <cfquery name="Conteo" datasource="prafipp">
        SELECT	Num_Arch
        FROM	Cargas
        WHERE	Id_Prog=#Id_Prog#
        AND		Id_EntFed=#Id_EntFed#
        AND		Trim_Captura=#Trim_Captura#
        AND		Tipo='#Tipo#'
    </cfquery>
    <cfif #Conteo.RecordCount# GT 0 >
    	<!---OMITIMOS TEMPORALMENTE EL Q SUBA MAS DE UN ARCHIVO--->
        <!--- si ya existe un archivo, se incrementa el conteo en la bd --->
        <cfset incremento = #Conteo.Num_Arch# + 1>
        <!---<cfoutput><p>Si existe archivo en el directorio, se incrementa a #incremento#</p></cfoutput>--->
        <cfquery name="actualizar" datasource="prafipp">
            UPDATE	Cargas
            SET		Num_Arch=1
            WHERE	Id_Prog=#Id_Prog#
            AND		Id_EntFed=#Id_EntFed#
            AND		Trim_Captura=#Trim_Captura#
            AND		Tipo='#Tipo#'
        </cfquery>
        
    <cfelse>
        <!--- si no, se inserta un nuevo registro --->
        <cfquery name="insertar" datasource="prafipp">
          INSERT INTO Cargas(Id_Prog,Id_EntFed , Trim_Captura, Tipo, Ubicacion, Num_Arch)
                VALUES(#Id_Prog#,#Id_EntFed# , #Trim_Captura#, '#Tipo#', '#Directorio#', 1)
        </cfquery>
        

        

    </cfif>
	
    <!---                      LOG                       --->
	<cfset Rol='#url.Rol#'>
    <cfset Time=#TimeFormat(Now(), "hh:mm:ss")#>
    <cfset Date=#DateFormat(Now(), "mm/dd/yyyy")#>
    <cfset Fecha='#Date# #Time#'>


	<cfif #Tipo# IS 'InformeTecnico'>			<cfset Log_Type=1>
    <cfelseif #Tipo# IS 'EstadoCuenta'> 		<cfset Log_Type=2>       
    <cfelseif #Tipo# IS 'ReintegroTesoreria'>	<cfset Log_Type=3>        
    <cfelseif #Tipo# IS 'ReciboInstitucional'>	<cfset Log_Type=4>       
    <cfelseif #Tipo# IS 'Transferencias1'>		<cfset Log_Type=5>        
    <cfelseif #Tipo# IS 'Transferencias2'>		<cfset Log_Type=6>      
    <cfelseif #Tipo# IS 'Transferencias3'>		<cfset Log_Type=7>
    <cfelseif #Tipo# IS 'Transferencias4'>		<cfset Log_Type=8> 
    <cfelseif #Tipo# IS 'InformeFinanciero'>	<cfset Log_Type=9>
    <cfelse> <cfset Log_Type=0>
    </cfif>
<!---
	<cfoutput>INSERT INTO logs(Ejercicio, Id_EntFed, Id_Prog, Id_User, Log_Type, Descrip, Fecha)
            VALUES(#SESSION.Ejercicio#,#Id_EntFed#,#Id_Prog#, #Rol#, #Log_Type# , '#Tipo#,#Trim_Captura#', '#Fecha#')</cfoutput>
--->	
    <cfquery name="insertar" datasource="prafipp">
            INSERT INTO logs(Ejercicio, Id_EntFed, Id_Prog, Id_User, Log_Type, Descrip, Fecha)
            VALUES(#SESSION.Ejercicio#,#Id_EntFed#,#Id_Prog#, '#Rol#', #Log_Type# , '#Tipo#,#Trim_Captura#', '#Fecha#')
    </cfquery>
    
	<cfoutput>
		<script>
			window.opener.location.reload();
			window.close();
		</script>
	</cfoutput>
<cfelse>
	<cfif #Tipo# IS 'InformeFinanciero'>
		<cfoutput>
            <script>
                alert ("Se le recuerda que el formato PDF del Informe Financiero debe ser a COLOR, \xA1gracias!");
            </script>
        </cfoutput> 	    
    </cfif>
</cfif>

<form enctype="multipart/form-data" method="post">
<br />
<br />
<br />

<cfif #Tipo# IS 'InformeTecnico'>			<cfset TP='Informe T&eacute;cnico'>
<cfelseif #Tipo# IS 'EstadoCuenta'> 		<cfset TP='Estado de Cuenta'>        
<cfelseif #Tipo# IS 'ReintegroTesoreria'>	<cfset TP='Reintegro Tesorer&iacute;a'>         
<cfelseif #Tipo# IS 'ReciboInstitucional'>	<cfset TP='Recibo Institucional'>         
<cfelseif #Tipo# IS 'Transferencias1'>		<cfset TP='Transferencia Primera'>         
<cfelseif #Tipo# IS 'Transferencias2'>		<cfset TP='Transferencia Segunda'>        
<cfelseif #Tipo# IS 'Transferencias3'>		<cfset TP='Transferencia Tercera'>
<cfelseif #Tipo# IS 'Transferencias4'>		<cfset TP='Transferencia Cuarta'>
<cfelseif #Tipo# IS 'InformeFinanciero'>	<cfset TP='Informe Financiero'>   
<cfelse> <cfset TP=''>
</cfif>

<h2 align="center"><cfoutput>#TP#</cfoutput></h2>
<br />
<br />
<table align="center" border="0" cellspacing="0" cellpadding="0" width="400">
<tr><td>
    <input type="file" name="fileUpload" maxlength="50" size="50" width="50"/>
    <input type="submit" value="Cargar" />
</td></tr>
</table>
<br />
</form>




</body>
</html>