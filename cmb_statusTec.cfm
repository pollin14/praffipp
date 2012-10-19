<cfajaximport tags="cfmessagebox,cfform"> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Cambio al estatus técnico, se verifica documentacion, se pone verde y cambia al siguente semestre</title>
<link rel="stylesheet" type="text/css" href="css/prafipp.css">
</head>

<body>

<cfif IsDefined('Form.aceptar')>

    <cfset Id_EntFed=#form.Id_Entfed#>
    <cfset Trim_Captura=#form.Trim_Captura#>
    <cfset Status_Trim_sig=#form.Status_Trim_sig#>
    <cfset Ejercicio=#SESSION.Ejercicio#>
    <cfset Id_Prog=#SESSION.Id_Prog#>
    
    <cfif #Trim_Captura# EQ 1 >
        <cfset Estat="SELECT Status_Trim1 FROM Prog_EntFed WHERE Id_Prog=#Id_Prog# AND Id_EntFed=#Id_EntFed# AND Ejercicio=#Ejercicio#">
        <cfquery name="Estatus" datasource="prafipp">
            #Estat#
        </cfquery>
        <cfset cambio_verde = #Estatus.Status_Trim1# - 3>
        
        
    <cfelseif #Trim_Captura# EQ 2>
        <cfset Estat="SELECT Status_Trim2 FROM Prog_EntFed WHERE Id_Prog=#Id_Prog# AND Id_EntFed=#Id_EntFed# AND Ejercicio=#Ejercicio#">
        <cfquery name="Estatus" datasource="prafipp">
            #Estat#
        </cfquery>
        <cfset cambio_verde = #Estatus.Status_Trim2# - 3>
    <cfelseif #Trim_Captura# EQ 3>
        <cfset Estat="SELECT Status_Trim3 FROM Prog_EntFed WHERE Id_Prog=#Id_Prog# AND Id_EntFed=#Id_EntFed# AND Ejercicio=#Ejercicio#">
        <cfquery name="Estatus" datasource="prafipp">
            #Estat#
        </cfquery>
        <cfset cambio_verde = #Estatus.Status_Trim3# - 3>
    <cfelse>
        <cfset Estat="SELECT Status_Trim4 FROM Prog_EntFed WHERE Id_Prog=#Id_Prog# AND Id_EntFed=#Id_EntFed# AND Ejercicio=#Ejercicio#">
        <cfquery name="Estatus" datasource="prafipp">
            #Estat#
        </cfquery>
        <cfset cambio_verde = #Estatus.Status_Trim4# - 3>
    </cfif>
    
    <cfset num_next_Trim=#Trim_Captura#+1>
    <cfset val_next_Trim=2+#Status_Trim_sig#>
    <cfset next_Trim_Captura=#Trim_Captura#+1>
    
    <cfset actualizar_estatus="	UPDATE	Prog_EntFed
                                SET		Status_Trim#Trim_Captura#=#cambio_verde#,
                                        Status_Trim#num_next_Trim#=#val_next_Trim#,
                                        Trim_CapturaT=#next_Trim_Captura#
                                WHERE	Id_Prog=#Id_Prog#
                                AND		Id_EntFed=#Id_EntFed#
                                AND		Ejercicio=#Ejercicio#">

    <cfquery name="actualizar_estatus" datasource="prafipp">
        #actualizar_estatus#
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

    <cfform name="test" action="cmb_statusTec.cfm"> 
    </br></br></br></br>
    <table width="266" border="0" align="center" class="tabla_mensaje">
      <tr>
        <td height="89" colspan="2" align="center">Esta acci&oacute;n cambiara el estatus a Cumple al 100% y abrir&aacute; el siguiente trimestre</td>
      </tr>
      <tr>
        
        <cfif isDefined("url.Status_Trim2")>
            <cfset Status_Trim_sig=(#url.Status_Trim2# \ 10) * 10>
        </cfif>
        <cfif isDefined("url.Status_Trim3")>
            <cfset Status_Trim_sig=(#url.Status_Trim3# \ 10) * 10>
        </cfif>
        <cfif isDefined("url.Status_Trim4")>
            <cfset Status_Trim_sig=(#url.Status_Trim4# \ 10) * 10>
        </cfif>

        <cfoutput>
            <input type="hidden" name="Id_Entfed" id="Id_Entfed" value="#url.Id_Entfed#">
            <input type="hidden" name="Trim_Captura" id="Trim_Captura" value="#url.Trim_Captura#">
            <input type="hidden" name="Status_Trim_sig" id="Status_Trim_sig" value="#Status_Trim_sig#">
        </cfoutput>
        <td width="125" height="51" align="center"><input type="submit" name="aceptar"  id="aceptar"  value="    Proceder   " class="btn_mensaje"/></td>
        <td width="125" align="center"><input type="submit" name="cancelar" id="cancelar" value="    Cancelar   " class="btn_mensaje"/></td>
      </tr>
    </table>

</cfform>
    
</cfif>







</body>
</html>