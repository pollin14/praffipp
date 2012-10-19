<cfapplication name="prafipp" sessionmanagement="yes">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Alta Avisos</title>
<head>


<link rel="stylesheet" type="text/css" media="all" href="calendario/calendar-blue.css" title="win2k-cold-1" />
<script type="text/javascript" src="calendario/calendar.js" ></script>
<script type="text/javascript" src="calendario/lang/calendar-es.js"></script>
<script type="text/javascript" src="calendario/calendar-setup.js"></script>

<script type="text/javascript">	
function Valida( formulario ) {
	if (forma.aviso.value == '') {
		alert (" Introducir el texto del aviso. ");
		return false;
	} else if (forma.fch_ini.value == ''){
		alert (" Introducir fecha de inicio. ");
		return false;
	} else if (forma.fch_fin.value == ''){
		alert (" Introducir fecha de conclusión. ");
		return false;
	} else {
		return true;
	}
}	
</script> 

<style>
body {
  background-color: #ffffff;
  font-family: Calibri;
  font-size: 11pt;
  color: #6C6C6C;
  margin: 0 0 0 0
}
table{
  border: none;
  margin: 0
}
td{
  padding-left:5px;
  padding-right:5px;
  font-family: calibri;
  font-size: 11pt;
  color: #6C6C6C;
}
input {
  background: #FFFFFF;
  /*border: 1px solid #CCCCCC;*/
  border:none;
  color: #004282;
  font-family: Calibri;
  font-size: 10.5pt
}
.custom_tr{
  background-color: #DAE5F2;
}
.colheader {
  font-family: Calibri;
  font-size: 12pt;
  color: #DDDDDD;
  font-weight: bold;
  padding-bottom: 2;
  padding-top: 2;
  background: url(img/bgcolheader.jpg)
}
.editable{ 
  text-align:right;
  border: 1px solid #CCCCCC;
}
</style>

</head>

<body>

<cfif IsDefined('Form.Aceptar')>

    <cfset Aviso = #Form.aviso#>
    <cfset Fch_ini = #Form.fch_ini#>
    <cfset Fch_fin = #Form.fch_fin#>

    <CFQUERY NAME="registros" DATASOURCE="prafipp">
        SELECT	*
        FROM	news
    </CFQUERY>
    <cfset Id_new = #registros.RecordCount# + 1>
    <cfset Nombre = Trim(#SESSION.Nombre#)>
<!---
	<cfset qry="INSERT INTO news(id_new,new, inicio, fin, owner) VALUES(#Id_new#, '#Aviso#', '#Fch_ini#', '#Fch_fin#', '#Nombre#')">
    <cfoutput>Query = #qry#</cfoutput>

--->
    <cfquery name="insertar" datasource="prafipp">
      INSERT INTO news(id_new,new, inicio, fin, owner)
                VALUES(#Id_new#, '#Aviso#', '#Fch_ini#', '#Fch_fin#', '#Nombre#')
    </cfquery>
    <cfoutput>
        <script>
            alert ('  ¡Aviso registrado!  ');
            <!--setTimeout("alert('Cerrando ...');",5000);-->
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

<h2 align="center">Introducir nuevo aviso</h2>
<br />

<br />

<form action="noticias.cfm" name="forma" id="forma" method="post" onSubmit="return Valida(this);">
<table align="center" border="0" cellspacing="0" cellpadding="0" width="487">

  <tr>
     <td colspan="2" class="colheader" align="center">AVISOS</td>
  </tr>
  <tr>
    <td class="custom_tr">Nuevo Aviso</td>
    <td class="custom_tr"><textarea name="aviso" cols="40" rows="3" class="editpass" id="aviso" width="300"></textarea></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="custom_tr">Fecha Inicial</td>
    <td class="custom_tr">
    	<input id="fch_ini" type="text" name="fch_ini" width="200" readonly class="editable"/>
        <img src="img/calendar.gif" width="19" height="18" border="0" id="inicio" alt="Calendario" /> 
        <script type="text/javascript">
            Calendar.setup({
            inputField : "fch_ini", // id del campo de texto
            ifFormat : "%Y/%m/%d", // formato de la fecha que se escriba en el campo de texto
            button : "inicio" // el id del botón que lanzará el calendario
            });
		</script>        
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="custom_tr">Fecha Final</td>
    <td class="custom_tr">
    	<input id="fch_fin" type="text" name="fch_fin" width="200" readonly class="editable"/>
        <img src="img/calendar.gif" width="19" height="18" border="0" id="fin" alt="Calendario" /> 
        <script type="text/javascript">
            Calendar.setup({
            inputField : "fch_fin", // id del campo de texto
            ifFormat : "%Y/%m/%d", // formato de la fecha que se escriba en el campo de texto
            button : "fin" // el id del botón que lanzará el calendario
            });
		</script>          
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>  

  <tr>
    <td>&nbsp;</td>
    <td align="right"><button id="Aceptar" name="Aceptar" value="Aceptar"/>&nbsp;&nbsp;&nbsp;Aceptar&nbsp;&nbsp;&nbsp;</button>
  </tr>  
</table>
</form>
<br />







</body>
</html>