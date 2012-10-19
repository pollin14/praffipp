<cfapplication name="prafipp" sessionmanagement="yes">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/prafipp.css" rel="stylesheet" type="text/css" />
<title>Cambiar estatus financiero</title>

<script type="text/javascript">	
function Valida( formulario ) {
	if (forma.trimestre.value == '') {
		alert ("Introducir trimestre");
		return false;
	} else if (forma.estatus.value == ''){
		alert ("Introducir estatus");
		return false;
	} else {
		return true;
	}
}


	
</script> 

</head>

<body>

<cfif IsDefined('Form.Aceptar')>

		<cfset trimestre = #Form.trimestre#>
        <cfset estatus = #Form.estatus#>
        
        <cfset Status_Financiero = #estatus# * 10>
        <cfset Start = 1> 
        <cfset End = 3> 
        
        <CFQUERY NAME="QRY_Prog_EntFed" DATASOURCE="prafipp">
            SELECT	(Status_Trim#trimestre#) as Status_Trim, Id_Prog, Id_EntFed, Ejercicio, Trim_Captura
            FROM	Prog_EntFed        
        </CFQUERY>
    
    	 
        <!---cfloop query = "QRY_Prog_EntFed" startRow = "#Start#" endRow = "#End#"--->
        <cfloop query = "QRY_Prog_EntFed">
			<cfif (#QRY_Prog_EntFed.Trim_Captura# EQ #trimestre#)>
                <cfset Status_Tecnico = #QRY_Prog_EntFed.Status_Trim# mod 10>
                <cfset Status = #Status_Financiero# + #Status_Tecnico#>
                
                <cfset actualizar_estatus="	UPDATE	Prog_EntFed
                                            SET		Status_Trim#trimestre#=#Status# ,Trim_Captura=#QRY_Prog_EntFed.Trim_Captura#*10
                                            WHERE	Id_Prog=#QRY_Prog_EntFed.Id_Prog#
                                            AND		Id_EntFed=#QRY_Prog_EntFed.Id_EntFed#
                                            AND		Ejercicio=#QRY_Prog_EntFed.Ejercicio#">

                <cfquery name="actualizar_estatus" datasource="prafipp">
                    #actualizar_estatus#
                </cfquery>
            </cfif>
        </cfloop>


		<!--- AHORA ENVIAMOS CORREOS --->
    
        <CFQUERY NAME="QRY_usuarios" DATASOURCE="prafipp">
            SELECT	Nombre,email,Role
            FROM	usuarios      
        </CFQUERY>        

        <!---cfloop query = "QRY_usuarios" startRow = "#Start#" endRow = "#End#"--->
        <cfloop query = "QRY_usuarios"> 
            <cfif #Role# GT 2>
                <cfmail 
                    server="pop.sep.gob.mx"
                    to="#email#"
                    from="lord@sep.gob.mx"
                    subject="Cambio de estatus financiero, PRAFFIPP"
                    type="html"
                    charset="utf-8">  
                    Estimad@ <cfoutput>#Nombre#</cfoutput>:<br /><br />
        
                    Por este medio se les informa que ha cambiado el estatus financiero del trimestre <cfoutput>#trimestre#</cfoutput>o.<br /><br />
                    Si requiere informaci&oacute;n adicional, favor de ponerse en contacto con el coordinador del Programa<br /><br />
        
                    Attentamente<br />
                    Coordinaci&oacute;n Administrativa<br />
                    SEB<br />
                    Saludos
                </cfmail>
            </cfif>
        </cfloop>

		<cfoutput>
            <script>
                alert (' ¡Se han enviado los correos electronicos informativos! ');
				window.close();
            </script>
        </cfoutput>  

    
</cfif>


<table align="center" border="0" cellspacing="0" cellpadding="0" width="487">
    <tr><td>
    <img src="img/header.jpg" width="487" height="45" alt="Encabezado" />
    </td></tr>
</table>
<br /><br /><br />

<h2 align="center">Cambiar estatus financiero</h2>
<br />

<br />

<form action="estatus_fin.cfm" name="forma" id="forma" method="post" onSubmit="return Valida(this);">
<table align="center" border="0" cellspacing="0" cellpadding="0" width="487">

  <tr>
     <td colspan="2" class="colheader" align="center">Introducir datos</td>
  </tr>
  <tr>
    <td class="custom_tr">Trimestre a actualizar</td>
    <td class="custom_tr"><input id="trimestre" name="trimestre" width="200" class="editpass"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="custom_tr">Num. del nuevo estatus financiero</td>
    <td class="custom_tr"><input id="estatus" name="estatus" width="200" class="editpass"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <!--<td align="right"><input name="btn_aceptar" type="button" value="Aceptar" class="editable"/></td>-->
    <td align="right"><button id="Aceptar" name="Aceptar" value="Aceptar"/>&nbsp;&nbsp;&nbsp;Aceptar&nbsp;&nbsp;&nbsp;</button>
  </tr>  
</table>
</form>
<br />







</body>
</html>