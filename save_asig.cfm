<cfapplication name="prafipp" sessionmanagement="yes">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>save_asig.cfm</title>
</head>

<body>

<table align="center" border="0" cellspacing="0" cellpadding="0" width="975">
<tr><td>
<img src="img/header.jpg" width="975" height="90" alt="Encabezado" />
</td></tr>
</table>

<cfset Ejercicio=#SESSION.Ejercicio#>
<cfset Id_Prog=#SESSION.Id_Prog#>
<cfset Id_EntFed=#SESSION.Id_EntFed#>

<cfset Id_Banco_L=#Form.banco#>
<!---<cfset Fecha_Apertura_L=#Form.fecha#>--->
<cfset Fecha_Apertura_L=#DateFormat(Form.fecha, 'yyyy/mm/dd')#>

<cfset Beneficiario_L=#Form.bene_loc#>
<cfset Cta_Cheques_L=#Form.cheq_loc#>

<!---
<cfset PDF = #find("$",Form.spei_loc)#>
<cfif #PDF# GT 0>
	<cfset SPEI_L=#Form.spei_loc#>
<cfelse>
	<cfset SPEI_L=#LSCurrencyFormat(Form.spei_loc, "local")#>
</cfif>
--->
<cfset SPEI_L=#Form.spei_loc#>

<!---
<cfset qry = "UPDATE Prog_EntFed SET Id_Banco_L=#Id_Banco_L#,
					Fecha_Apertura_L='#Fecha_Apertura_L#',
					Beneficiario_L='#Beneficiario_L#',
					Cta_Cheques_L='#Cta_Cheques_L#',
					SPEI_L='#SPEI_L#'
    WHERE	Ejercicio=#SESSION.Ejercicio#
    AND		Id_Prog=#SESSION.Id_Prog#
    AND		Id_EntFed=#SESSION.Id_EntFed#">

<cfoutput>
query = #qry# </br>

</cfoutput>
--->


<cfquery name="inserta" datasource="prafipp">
	UPDATE Prog_EntFed 
    SET 	Id_Banco_L=#Id_Banco_L#,
            Fecha_Apertura_L='#Fecha_Apertura_L#',
            Beneficiario_L='#Beneficiario_L#',
            Cta_Cheques_L='#Cta_Cheques_L#',
            SPEI_L='#SPEI_L#'
    WHERE	Ejercicio=#SESSION.Ejercicio#
    AND		Id_Prog=#SESSION.Id_Prog#
    AND		Id_EntFed=#SESSION.Id_EntFed#
</cfquery>
<!---
<cflocation url="itaf_cap.cfm">
--->
<cfoutput>
	<script>
		alert ("   Actualizado correctamente   ");
		history.go(-1);
		//window.opener.location.reload();
		//window.close();
	</script>
</cfoutput>


</body>
</html>