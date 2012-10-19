<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1" />
<title>PRAFIPP - Plataforma de Registro de Avance Financiero de Programas y Proyectos SEB</title>
<link rel="SHORTCUT ICON" href="img/prafipp.ico">
<link rel="stylesheet" type="text/css" href="css/prafipp.css">
</style>
<script type="text/javascript" language="javascript" src="js/func.js">
</script>
</head>

<body>
<table align="center" border="0" cellspacing="0" cellpadding="0" width="968">
<tr><td width="968">
<cfset Informe = structnew()>
  <cfset Informe.Ejercicio=2012>
  <cfset Informe.Id_Prog=20121>
  <cfset Informe.Id_EntFed=1>
  <cfset Informe.Trimestre=4>
  <cfset Informe.captura=True>

<!---cfdocumentitem type="header">
    <CFQUERY DATASOURCE = "sif" NAME = "sif_ds">
      SELECT * FROM Programas where Id_Prog=#Id_Prog#
    </CFQUERY>
    <CFOUTPUT QUERY = "sif_ds">
      <h2 align="center">#Nom_Prog#</h2>
    </CFOUTPUT>
    
    <h2 align="center">Ejercicio <cfoutput>#ejercicio#</cfoutput></h2>
    <h3 align="center">INFORME TRIMESTRAL DE AVANCE FINANCIERO</h3>
    
    <CFQUERY DATASOURCE = "sif" NAME = "sif_ds">
     SELECT * FROM entidad where Id_EntFed=#Id_EntFed#
    </CFQUERY>
    <CFOUTPUT QUERY = "sif_ds">
      <p>ENTIDAD FEDERATIVA: #UCase(EntFed)#</p>
    </CFOUTPUT>
</cfdocumentitem>
<cfdocumentitem type="footer">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td>
        <div align="left">
          <font face="Arial Narrow">Impreso el <cfoutput>#DateFormat(Now(), "d-m-yyyy")#, a las #TimeFormat(Now(), "h:mm tt")#</cfoutput>
          </font>
        </div>
      </td>
      <td>
        <div align="right">
          <font face="Arial Narrow">
          P&aacute;gina
          <cfoutput>
            #cfdocument.currentpagenumber#
          </cfoutput>/
          <cfoutput>
              #cfdocument.totalpagecount#
          </cfoutput>
          </font>
        </div>
      </td>
    </tr>
  </table>
</cfdocumentitem--->


<CFQUERY DATASOURCE = "prafipp" NAME = "sif_ds">
  SELECT * FROM Programas where Id_Prog=#Informe.Id_Prog#
</CFQUERY>
<CFOUTPUT QUERY = "sif_ds">
  <h2 align="center">#Nom_Prog#</h2>
    <cfset Informe.Num_Egresos=#Num_Egresos#>
    <cfset Informe.Num_Egresos_Pro=#Num_Egresos_Pro#>
</CFOUTPUT>

<h2 align="center">Ejercicio <cfoutput>#Informe.ejercicio#</cfoutput></h2>
<h3 align="center">INFORME TRIMESTRAL DE AVANCE FINANCIERO</h3>
  <CFQUERY DATASOURCE = "prafipp" NAME = "sif_ds">
 SELECT * FROM entidad where Id_EntFed=#Informe.Id_EntFed#
  </CFQUERY>
<CFOUTPUT QUERY = "sif_ds">
  <p align="center">ENTIDAD FEDERATIVA: #UCase(EntFed)#</p>
</CFOUTPUT>

<p align="center">
  <input type="button" name="Btn_Asig" id="Btn_Asig" value="Asignaciones" onClick="HideShow_Asig();">
  <input type="button" name="Btn_Trans" id="Btn_Asig" value="Transferencias" onClick="HideShow_Trans();">
  <input type="button" name="Btn_Movs" id="Btn_Movs" value="Movimientos" onClick="HideShow_Movs();">
  <input type="button" name="Btn_Pror" id="Btn_Pror" value="Prorrogas" onClick="HideShow_Pror();">
</p>

<cfset QStr = "SELECT * FROM Prog_entFed where Ejercicio=#Informe.Ejercicio# and Id_Prog=#Informe.Id_Prog# and Id_EntFed=#Informe.Id_EntFed#">
  <CFQUERY DATASOURCE = "prafipp" NAME = "sif_ds">
	 #QStr#
  </CFQUERY>
  
<CFOUTPUT QUERY = "sif_ds">
	<cfset Recurso_Asignado= #Recurso_Asignado#>
    <cfset Clave_Presup = #Clave_Presup#>
    <cfset Convenio=#Convenio#>
    <cfset Id_Banco=#Id_Banco#>
    <cfset Fecha_Apertura=#Fecha_Apertura#>
    <cfset Beneficiario=#Beneficiario#>
    <cfset Cta_Cheques=#Cta_Cheques#>
    <cfset SPEI=#SPEI#>
    <cfset Informe.Elaboro=#Elaboro#>
    <cfset Informe.Responsable=#Responsable#>
</CFOUTPUT>

<cfquery  datasource="prafipp" name="banco">
	select * from bancos where Id_Banco=#Id_Banco#
</cfquery>
<cfoutput query = "banco">
	<cfset Nom_banco=#Nom_banco#>
</cfoutput>

<div id="Asignaciones" >
  <table width="100%" border="1" cellspacing="0" class="TblInterna">
    <tr>
      <td width="37%">RECURSO FEDERAL ASIGNADO PARA EL A&Ntilde;O <cfoutput>#Informe.ejercicio#</cfoutput></td>
      <td width="12%"><cfoutput >#Recurso_Asignado#</cfoutput></td>
      <td width="33%">CLAVE PRESUPUESTAL</td>
      <td width="18%"><cfoutput >#Clave_Presup#</cfoutput></td>
    </tr>
    <tr>
      <td>CONVENIO DE COLABORACI&Oacute;N</td>
      <td><cfoutput>#Convenio#</cfoutput></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>INSTITUCION BANCARIA</td>
      <td><cfoutput>#Nom_banco#</cfoutput></td>
      <td>FECHA DE APERTURA</td>
      <td><cfoutput>#DateFormat(Fecha_Apertura, "dd-mm-yyyy")#</cfoutput></td>
    </tr>
    <tr>
      <td>BENEFICIARIO</td>
      <td colspan="3"><cfoutput>#Beneficiario#</cfoutput></td>
    </tr>
    <tr>
      <td>CUENTA DE CHEQUES</td>
      <td><cfoutput>#Cta_Cheques#</cfoutput></td>
      <td>NO. DE CUENTA CLABE (SPEI)</td>
      <td><cfoutput>#SPEI#</cfoutput></td>
    </tr>
  </table>
</div>
 
  <br />

<CFOUTPUT QUERY = "sif_ds">
	<cfset Transf1_Monto= #Transf1_Monto#>
    <cfset Transf1_Fecha = #DateFormat(Transf1_Fecha, "dd-mm-yyyy")#>
    <cfset Transf1_Recibo=#Transf1_Recibo#>
    <cfset Transf1_Recibo_Fecha=#Transf1_Recibo_Fecha#>
    <cfset Transf2_Monto= #Transf2_Monto#>
    <cfset Transf2_Fecha =#DateFormat(Transf2_Fecha, "dd-mm-yyyy")#>
    <cfset Transf2_Recibo=#Transf2_Recibo#>
    <cfset Transf2_Recibo_Fecha=#Transf2_Recibo_Fecha#>
</CFOUTPUT>

<div id="Transferencias" >  
  <table width="100%" border="1" cellspacing="0" class="TblInterna">
    <tr align="center">
      <td colspan="4">TRANSFERENCIAS DEL RECURSO FEDERAL A EL ESTADO</td>
    </tr>
    <tr>
      <td width="30%">Primera Transferencia</td>
      <td width="20%"><cfoutput>#Transf1_Monto#</cfoutput></td>
      <td width="30%">Segunda Transferencia</td>
      <td width="20%"><cfoutput>#Transf2_Monto#</cfoutput></td>
    </tr>
    <tr>
      <td>Recibo institucional</td>
      <td><cfoutput>#Transf1_Recibo#</cfoutput></td>
      <td>Recibo institucional</td>
      <td><cfoutput>#Transf2_Recibo#</cfoutput></td>
    </tr>
    <tr>
      <td>Fecha de Entrega del Recibo Institucional</td>
      <td><cfoutput>#Transf1_Fecha#</cfoutput></td>
      <td>Fecha de Entrega del Recibo Institucional</td>
      <td><cfoutput>#Transf2_Fecha#</cfoutput></td>
    </tr>
    <tr>
      <td>Trimestre reportado</td>
      <td><cfoutput >#Informe.Trimestre#</cfoutput></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
 </div>
  <br />
<div id="Movimientos" >
  <cf_movimientos attributecollection=#Informe# Desde=1 Num_Egresos=#Informe.Num_Egresos# Nom_Form="Egresos">
</div>

<div id="Prorroga" >
  <cfset DesdePro=#Informe.Num_Egresos#+5>
  <cf_movimientos attributecollection=#Informe# Desde=#DesdePro# Num_Egresos=#Informe.Num_Egresos_Pro# Nom_Form="Prorroga">
</div>

</td></tr>
</table>
</body>
</html>