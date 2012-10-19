<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1" />
<title>PRAFIPP - Plataforma de Registro de Avance Financiero de Programas y Proyectos SEB</title>
<link href="css/prafipp.css" rel="stylesheet" type="text/css" />
<link rel="SHORTCUT ICON" href="img/prafipp.ico">
</head>
<body>
<table width="975" align="center">
  <tr>
    <td><img src="img/header.jpg" width="975" height="90" alt="encabezado" /></td>
  </tr>
  <tr  height="587">
    <td height="305" align="center" background="img/content.jpg">
  <form name="LoginForm" action="#CGI.script_name#?#CGI.query_string#" method="Post">
    <table width="37%" border="0" align="center" cellspacing="0">
        <tr>
        <td colspan="2" class="colheader" align="center">Teclee sus credenciales</td>
        </tr>
      <tr>
        <td width="60%" align="left">Nombre de usuario</td>
        <td width="40%">
          <input type="text" name="j_userName"></td>
      </tr>
      <tr>
        <td align="left">Contase&ntilde;a</td>
        <td><input type="password" name="j_password"></td>
      </tr>
      <tr>
        <td align="center"><input type="submit" name="Submit" value="ingresar"></td>
        <td>&nbsp;</td>
      </tr>
    </table>
  </form>
    </td>
  </tr>
  <tr>
    <td><img src="img/footer.jpg" width="975" height="23" alt="encabezado" /></td>
  </tr>
</table>
</body>
</html>
</cfoutput>
