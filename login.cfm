<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1" />
<title>PRAFIPP - Plataforma de Registro de Avance Financiero de Programas y Proyectos SEB</title>
<link href="css/prafipp.css" rel="stylesheet" type="text/css" />
<link rel="SHORTCUT ICON" href="img/prafipp.ico">

<script language="JavaScript">
<!-- 
var id,pause=0,position=0;
function scorrevole() {
var i,k,msg="               HTMLpoint, el sitio italiano del web publishing                   ";
k=(200/msg.length)+1;
for(i=0;i<=k;i++) msg+=" "+msg;
document.form2.scorrevole.value=msg.substring(position,position+100);
if(position++==100) position=0;
id=setTimeout("scorrevole()",100); }
//-->
</script>

</head>
<body>
<table width="975" align="center">
  <tr>
    <td><img src="img/header.jpg" width="975" height="90" alt="encabezado" /></td>
  </tr>
  <tr  height="587">
    <td height="305" align="center" background="img/content.jpg">
  <form action="<cfoutput>#FormAction#</cfoutput>" method="post">
    <table width="37%" border="0" align="center" cellspacing="0">
        <tr>
        <td colspan="2" class="colheader" align="center">Teclee sus credenciales</td>
        </tr>
      <tr>
        <td width="60%" align="left">Nombre de usuario</td>
        <td width="40%">
          <input type="text" name="Username" id="Username"></td>
      </tr>
      <tr>
        <td align="left">Contase&ntilde;a</td>
        <td><input type="password" name="password" id="password"></td>
      </tr>
      <tr>
        <td align="center"><input type="submit" name="Ingreso" value="ingresar"></td>
        <td>&nbsp;</td>
      </tr>
    </table>
  </form>
  <p>&nbsp;</p>
  <p><a href="pdf/Catalogos.xlsx">Cat&aacute;logos</a> </p>

  <!p align="center"> <a href="pdf/PRAFFIPP_Guia.pdf">Obtener Gu&iacute;a de uso </a></p>
</cfoutput>
  

<cfset Hoy=#DateFormat(Now(), "yyyy-mm-dd")#>
<CFQUERY DATASOURCE = "prafipp" NAME = "avisos">
  SET DATEFORMAT ymd;
  SELECT * FROM news WHERE inicio <= '#Hoy#' AND '#Hoy#' <= fin order by id_new desc
</CFQUERY>

<p><marquee  behavior="scroll" direction="up" scrolldelay="100" height="200" width="500" scrollamount="1">
<CFOUTPUT QUERY = "avisos">
	#new#</br></br>
</CFOUTPUT>  
</marquee></p>

<!---
    <p><marquee  behavior="scroll" direction="up" scrolldelay="100" height="150" width="500" scrollamount="1">
        Le recordamos a las entidades de Baja California Sur y Puebla que aún no contamos con el catálogo de usuarios para el registro en esta plataforma de los movimientos financieros y desarrollos técnicos de los programas y proyectos coordinados por la DGDGIE.</br></br>
        Se solicita a Aguascalientes, Baja California y Tlaxcala que verifiquen los registros efectuados en el primer trimestre del 2012, ya que los valores capturados no corresponden a las ministraciones realizadas. Favor de realizar las correcciones ya que de lo contrario no se les podrá abrir el segundo trimestre el próximo viernes. </br></br>
        El día 26 de julio será el último en el que estará disponible el primer trimestre para capturar en ceros la información del mismo. A partir del viernes 27 de julio se abrirá el segundo trimestre para que realicen los registros y adjunten la documentación correspondiente a los meses de abril, mayo y junio del 2012. Se les recuerda que deben validar el primer trimestre con las firmas de los dos funcionarios que aparecen al final de la pantalla y cuyo campo estará disponible para registro a partir del 25 de julio.</br></br>
        Es importante que no olviden adjuntar los soportes financieros (recibos institucionales, reintegros, así como estados de cuenta y conciliaciones bancarias y también los informes financieros) y técnicos (formatos de los programas validados por las Coordinaciones Nacionales de los programas y proyectos de esta Dirección General).</br></br>
        Con el fin de estar en posibilidades de completar la validación del primer trimestre, a partir de hoy martes 24 de julio, se encuentra activado el campo que aparece al final del informe financiero en el que se solicita registrar los nombres de los servidores públicos: de quien capturó la información y del responsable de validarla.</br></br>
        Para recibir el dictamen correspondiente es necesario adjuntar informe financiero mismo que debe escanearse en original de manera que puedan apreciarse con nitidez  las características  de papel membretado, sellos, firmas y toda la información registrada. </br></br>
        Solicitamos su amable apoyo para verificar que los registros de información que están realizando en esta Plataforma correspondan efectivamente al trimestre en que se efectuaron las asignaciones por parte de la DGDGIE y por ende el ejercicio de dichos recursos. </br></br>
        Favor de recordar que los remanentes del 2011 deberán ser comprobados de acuerdo al procedimiento que estamos siguiendo para el periodo 2007-2011. Los recursos 2012 de los programas coordinados por la DGDGIE deben reportarse en la PRAFFIPP y enviar en su momento la documentación soporte por escrito.</br></br>
        Se ha añadido la funcionalidad de cambiar password desde el 4 de julio de 2012 </br></br>
    </marquee></p>
--->
  </td>
  </tr>

  
  <tr>
    <td><img src="img/footer.jpg" width="975" height="23" alt="encabezado" /></td>
  </tr>
</table>

</body>
</html>

