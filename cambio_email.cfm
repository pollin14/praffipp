<cfapplication name="prafipp" sessionmanagement="yes">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/prafipp.css" rel="stylesheet" type="text/css" />
<title>Cambiar contrtase&ntilde;a</title>

<script type="text/javascript">	
function Valida( formulario ) {
	if (forma.email_ant.value == '') {
		alert ("Introducir correo electrónico actual");
		return false;
	} else if (forma.email_new.value == ''){
		alert ("Introducir el nuevo correo electrónico");
		return false;
	} else if (forma.email_rpt.value == ''){
		alert ("Introducir confirmacion del nuevo correo electrónico");
		return false;
	} else {
		return true;
	}
}


	
</script> 

</head>

<body>

<cfif IsDefined('Form.Aceptar')>

    <cfset old_email = #Form.email_ant#>
    <cfset new_email = #Form.email_new#>
    <cfset rpt_email = #Form.email_rpt#>
    
<!---    
    <cfset qry="SELECT * FROM usuarios WHERE usuario = '#SESSION.Usuario#' AND Password = '#old_password#'"> 
    <cfoutput>SESSION_Nombre = #SESSION.Nombre#</cfoutput>
    <cfoutput>Query = #qry#</cfoutput>
--->    
	
    <CFQUERY NAME="checar" DATASOURCE="prafipp">
    SELECT      *
    FROM        usuarios         
    WHERE       usuario = '#SESSION.Usuario#'
    AND			email = '#old_email#'
    </CFQUERY>
<!---<cfoutput>checar_RecordCount = #checar.RecordCount#</cfoutput>--->
<cfif IsDefined('url.mal')>
	<cfoutput>url_mal = #url.mal#</cfoutput>
</cfif>
	<cfif #checar.RecordCount# GT 0 >
    	<cfif #new_email# EQ #rpt_email#>
            <cfquery name="actualizar" datasource="prafipp">
                UPDATE	usuarios
                SET		email='#new_email#'
                WHERE	usuario='#SESSION.Usuario#'
                AND		email='#old_email#'
            </cfquery>
            <!---cfoutput><h3 align="center" ><font color="red">¡Contraseña registrada!</font></h3></cfoutput--->
            <cfoutput>
				<script>
					alert (' ¡Correo electrónico registrado! ');
					<!--setTimeout("alert('Cerrando ...');",5000);-->
					window.close();
				</script>
			</cfoutput>
		<cfelse>
        	<cfoutput><h3 align="center" ><font color="red">No coincide nuevo correo elect&oacute;nico con la confirmación</font></h3></cfoutput>
        </cfif>
	<cfelse>
		<cfoutput><cflocation url="cambio_email.cfm?mal=1"></cfoutput>
    </cfif>
    
</cfif>

<cfif IsDefined('url.mal')>
	<h3 align="center" ><font color="red">No coincide el correo elect&oacute;nico actual</font></h3>
</cfif>

<table align="center" border="0" cellspacing="0" cellpadding="0" width="487">
    <tr><td>
    <img src="img/header.jpg" width="487" height="45" alt="Encabezado" />
    </td></tr>
</table>
<br /><br /><br />

<h2 align="center">Cambiar correo elect&oacute;nico</h2>
<br />

<br />

<form action="cambio_email.cfm" name="forma" id="forma" method="post" onSubmit="return Valida(this);">
<table align="center" border="0" cellspacing="0" cellpadding="0" width="487">

  <tr>
     <td colspan="2" class="colheader" align="center">Introducir datos para cambiar correo elect&oacute;nico</td>
  </tr>
  <tr>
    <td class="custom_tr">Correo elect&oacute;nico actual</td>
    <td class="custom_tr"><input id="email_ant" name="email_ant" width="200" class="editpass"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="custom_tr">Nuevo correo elect&oacute;nico</td>
    <td class="custom_tr"><input id="email_new" name="email_new" width="200" class="editpass"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="custom_tr">Confirmar correo elect&oacute;nico</td>
    <td class="custom_tr"><input id="email_rpt" name="email_rpt" width="200" class="editpass"/></td>
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