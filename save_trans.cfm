<cfapplication name="prafipp" sessionmanagement="yes">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>save_trans.cfm</title>
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

<cfif IsDefined('Form.fecha_Primera')>
	<cfif #Form.selRecibo_Primera# EQ 1>
        <CFQUERY DATASOURCE = "prafipp" NAME = "inserta">
            UPDATE	Prog_EntFed
            SET		Transf1_Recibo_Fecha='#Form.fecha_Primera#', Transf1_Recibo=#Form.selRecibo_Primera#
            WHERE	Ejercicio=#Ejercicio#
            AND		Id_Prog=#Id_Prog#
            AND		Id_EntFed=#Id_EntFed#
        </CFQUERY>  
    </cfif>  
</cfif>

<cfif IsDefined('Form.fecha_Segunda')>
	<cfif #Form.selRecibo_Segunda# EQ 1>
        <CFQUERY DATASOURCE = "prafipp" NAME = "inserta">
            UPDATE	Prog_EntFed
            SET		Transf2_Recibo_Fecha='#Form.fecha_Segunda#', Transf2_Recibo=#Form.selRecibo_Segunda#
            WHERE	Ejercicio=#Ejercicio#
            AND		Id_Prog=#Id_Prog#
            AND		Id_EntFed=#Id_EntFed#
        </CFQUERY>  
    </cfif>
</cfif>

<cfif IsDefined('Form.fecha_Tercera')>
	<cfif #Form.selRecibo_Tercera# EQ 1>
        <CFQUERY DATASOURCE = "prafipp" NAME = "inserta">
            UPDATE	Prog_EntFed
            SET		Transf3_Recibo_Fecha='#Form.fecha_Tercera#', Transf3_Recibo=#Form.selRecibo_Tercera#
            WHERE	Ejercicio=#Ejercicio#
            AND		Id_Prog=#Id_Prog#
            AND		Id_EntFed=#Id_EntFed#
        </CFQUERY>  
    </cfif>
</cfif>

<cfif IsDefined('Form.fecha_Cuarta')>
	<cfif #Form.selRecibo_Cuarta# EQ 1>
        <CFQUERY DATASOURCE = "prafipp" NAME = "inserta">
            UPDATE	Prog_EntFed
            SET		Transf4_Recibo_Fecha='#Form.fecha_Cuarta#', Transf4_Recibo=#Form.selRecibo_Cuarta#
            WHERE	Ejercicio=#Ejercicio#
            AND		Id_Prog=#Id_Prog#
            AND		Id_EntFed=#Id_EntFed#
        </CFQUERY>  
    </cfif>
</cfif>




<!---
<CFQUERY DATASOURCE = "prafipp" NAME = "inserta">
	UPDATE	Prog_EntFed
    SET		Transf1_Fecha='#Fecha1#', Transf1_Recibo=#Recibo1#,
			Transf2_Fecha='#Fecha2#', Transf2_Recibo=#Recibo2#,
            Transf3_Fecha='#Fecha3#', Transf3_Recibo=#Recibo3#,
            Transf4_Fecha='#Fecha4#', Transf4_Recibo=#Recibo4#
    WHERE	Ejercicio=#Ejercicio#
    AND		Id_Prog=#Id_Prog#
    AND		Id_EntFed=#Id_EntFed#
</CFQUERY>
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