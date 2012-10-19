<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/prafipp.css">
<title>Borrar documentos del Server</title>
</head>

<body>

<cfif IsDefined('Form.aceptar')>

	<cfset Id_Prog=#SESSION.Id_Prog#>
    <cfset Id_EntFed=#form.Id_EntFed#>
    <cfset Trim_Captura=#form.Trim_Captura#>
    <cfset Tipo=#form.Tipo#>
    <cfset Rol=#SESSION.Rol#>
    <cfset Directorio="C:\Docs_prafipp\#Id_Prog#\#Id_EntFed#\#Trim_Captura#\#Tipo#">
    
    <cfoutput>Id_Prog=#Id_Prog#</cfoutput></br>
    <cfoutput>Id_EntFed=#Id_EntFed#</cfoutput></br>
    <cfoutput>Trim_Captura=#Trim_Captura#</cfoutput></br>
    <cfoutput>Tipo=#Tipo#</cfoutput></br>
    <cfoutput>Directorio=#Directorio#</cfoutput></br>
    <cfoutput>Rol=#Rol#</cfoutput></br>


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


	<!---  ACTUALIZAMOS EN LA BASE DE DATOS --->
        <cfquery name="actualizar" datasource="prafipp">
            UPDATE	Cargas
            SET		Num_Arch=0
            WHERE	Id_Prog=#Id_Prog#
            AND		Id_EntFed=#Id_EntFed#
            AND		Trim_Captura=#Trim_Captura#
            AND		Tipo='#Tipo#'
        </cfquery>

	
    <!---                      LOG                       --->
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

    <cfelse> <cfset Log_Type=0> <!--- Tipo=BORRADO --->
    </cfif>
	
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


<cfelseif IsDefined('Form.cancelar')>

	<cfoutput>
		<script>
            window.opener.location.reload();
            window.close();
        </script>
    </cfoutput>

<cfelse>

	<cfform name="test" action="borrar.cfm"> 
        </br></br></br></br>
        <cfset Tipo = #url.Tipo#>
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

        <table width="266" border="0" align="center" class="tabla_mensaje">
          <tr>
            <td height="89" colspan="2" align="center">&iquest;Est&aacute; seguro de borrar el <cfoutput>#TP#</cfoutput>?</td>
          </tr>
          <tr>
				<cfoutput>
                    <input type="hidden" name="Id_Entfed" id="Id_Entfed" value="#url.Id_Entfed#">
                    <input type="hidden" name="Trim_Captura" id="Trim_Captura" value="#url.Trim_Captura#">
                    <input type="hidden" name="Tipo" id="Tipo" value="#url.Tipo#">
                </cfoutput>
                <td width="125" height="51" align="center"><input type="submit" name="aceptar"  id="aceptar"  value="    Proceder   " class="btn_mensaje"/></td>
                <td width="125" align="center"><input type="submit" name="cancelar" id="cancelar" value="    Cancelar   " class="btn_mensaje"/></td>
          </tr>
        </table>
        <br />
    </cfform>

</cfif>


</body>
</html>






