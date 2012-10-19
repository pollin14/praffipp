<cfapplication name="prafipp" sessionmanagement="yes">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/prafipp.css" rel="stylesheet" type="text/css" />
<title>Cambiar contrtase&ntilde;a</title>

<script type="text/javascript">	
function Valida( formulario ) {
	if (forma.pw_ant.value == '') {
		alert ("Introducir la contraseña actual");
		return false;
	} else if (forma.pw_new.value == ''){
		alert ("Introducir la nueva contraseña");
		return false;
	} else if (forma.pw_rpt.value == ''){
		alert ("Introducir confirmacion de la nueva contraseña");
		return false;
	} else {
		return true;
	}
}


	
</script> 

</head>

<body>

<cfif IsDefined('Form.Aceptar')>

    <cfset old_password = #Form.pw_ant#>
    <cfset new_password = #Form.pw_new#>
    <cfset rpt_password = #Form.pw_rpt#>
    
<!---    
    <cfset qry="SELECT * FROM usuarios WHERE usuario = '#SESSION.Usuario#' AND Password = '#old_password#'"> 
    <cfoutput>SESSION_Nombre = #SESSION.Nombre#</cfoutput>
    <cfoutput>Query = #qry#</cfoutput>
--->    
	
    <CFQUERY NAME="checar" DATASOURCE="prafipp">
    SELECT      *
    FROM        usuarios         
    WHERE       usuario = '#SESSION.Usuario#'
    AND			Password = '#old_password#'
    </CFQUERY>
<!---<cfoutput>checar_RecordCount = #checar.RecordCount#</cfoutput>--->
<cfif IsDefined('url.mal')>
	<cfoutput>url_mal = #url.mal#</cfoutput>
</cfif>
	<cfif #checar.RecordCount# GT 0 >
    	<cfif #new_password# EQ #rpt_password#>
            <cfquery name="actualizar" datasource="prafipp">
                UPDATE	usuarios
                SET		Password='#new_password#'
                WHERE	usuario='#SESSION.Usuario#'
                AND		Password='#old_password#'
            </cfquery>
            <!---cfoutput><h3 align="center" ><font color="red">¡Contraseña registrada!</font></h3></cfoutput--->
            <cfoutput>
				<script>
					alert ('¡Contraseña registrada!');
					<!--setTimeout("alert('Cerrando ...');",5000);-->
					window.close();
				</script>
			</cfoutput>
		<cfelse>
        	<cfoutput><h3 align="center" ><font color="red">No coincide la nueva contraseña con la confirmación</font></h3></cfoutput>
        </cfif>
	<cfelse>
		<cfoutput><cflocation url="cambio_password.cfm?mal=1"></cfoutput>
    </cfif>
    
</cfif>

<cfif IsDefined('url.mal')>
	<h3 align="center" ><font color="red">No coincide la contraseña actual</font></h3>
</cfif>

<table align="center" border="0" cellspacing="0" cellpadding="0" width="487">
    <tr><td>
    <img src="img/header.jpg" width="487" height="45" alt="Encabezado" />
    </td></tr>
</table>
<br /><br /><br />

<h2 align="center">Cambiar contrase&ntilde;a&nbsp;</h2>
<br />

<br />

<form action="cambio_password.cfm" name="forma" id="forma" method="post" onSubmit="return Valida(this);">
<table align="center" border="0" cellspacing="0" cellpadding="0" width="487">

  <tr>
     <td colspan="2" class="colheader" align="center">Introducir datos para cambio de contrase&ntilde;a</td>
  </tr>
  <tr>
    <td class="custom_tr">Contrase&ntilde;a actual</td>
    <td class="custom_tr"><input id="pw_ant" name="pw_ant" type="password" width="200" class="editpass"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="custom_tr">Nueva contrase&ntilde;a</td>
    <td class="custom_tr"><input id="pw_new" name="pw_new" type="password" width="200" class="editpass"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="custom_tr">Confirmar contrase&ntilde;a</td>
    <td class="custom_tr"><input id="pw_rpt" name="pw_rpt" type="password" width="200" class="editpass"/></td>
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