<cfapplication name="prafipp" sessionmanagement="yes">
<cfset SESSION.Id_EntFed=#url.Id_EntFed#>
<!--- Print --->
<cfdocument format="pdf" pagetype="letter" orientation="landscape">
<!--- Print --->
<title>ITAF (Informe Trimestral de Avance Financiero)</title>
<link rel="stylesheet" type="text/css" href="css/prafipp.css">
</style>
</head>
<script type="text/javascript" language="javascript" src="js/func.js">
</script>
<body onload="HideShow('Asignaciones','Btn_Asig');">

<table align="center" border="0" cellspacing="0" cellpadding="0" width="975">
<tr><td>
<img src="img/header.jpg" width="975" height="90" alt="Encabezado" />
</td></tr>
</table>

<cfinclude template="chk_session.cfm">

<table align="center" border="0" cellspacing="0" cellpadding="0" width="968">
<tr><td width="135">
  <td width="968" height="700" valign="top">
  <h2 align="center">INFORME TRIMESTRAL DE AVANCE FINANCIERO Y FISICO</h2>
  <cfset Informe = structnew()>
  <cfset Informe.Ejercicio=#SESSION.Ejercicio#>
  <cfset SESSION.Ejercicio=#SESSION.Ejercicio#>
  <cfset Informe.Id_Prog=#SESSION.Id_Prog#>
  <cfset Informe.Id_EntFed=#url.Id_EntFed#>
<!--- Print --->  
<cfdocumentitem type="header">
    <CFQUERY DATASOURCE = "prafipp" NAME = "sif_ds">
      SELECT * FROM Programas where Id_Prog=#Informe.Id_Prog#
    </CFQUERY>
    <CFOUTPUT QUERY = "sif_ds">
      <h2 align="center">#Nom_Prog#</h2>
    </CFOUTPUT>
    
    <h2 align="center">Ejercicio <cfoutput>#Informe.ejercicio#</cfoutput></h2>
    <h3 align="center">INFORME TRIMESTRAL DE AVANCE FINANCIERO</h3>
    
    <CFQUERY DATASOURCE = "prafipp" NAME = "sif_ds">
     SELECT * FROM entidad where Id_EntFed=#Informe.Id_EntFed#
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
</cfdocumentitem>

<!--- Print --->
<table width="975" border="0" cellspacing="2">
<CFQUERY DATASOURCE = "prafipp" NAME = "sif_ds">
  SELECT * FROM Programas where Id_Prog=#Informe.Id_Prog#
</CFQUERY>
<CFOUTPUT QUERY = "sif_ds">
  <tr>
    <td width="167" class="colheader"><strong>PROGRAMA :</strong></td>
    <td width="791" class="colfooter">#Nom_Prog#</td>
  </tr>   
  <cfset Informe.Num_Egresos=#Num_Egresos#>
  <cfset Informe.Num_Egresos_Pro=#Num_Egresos_Pro#>
</CFOUTPUT>
 <tr>
    <td class="colheader"><strong>EJERCICIO: </strong></td>
    <td class="colfooter"><cfoutput>#Informe.ejercicio#</cfoutput></td>
  </tr>
<CFQUERY DATASOURCE = "prafipp" NAME = "sif_ds">
	SELECT * FROM entidad where Id_EntFed=#Informe.Id_EntFed#
</CFQUERY>
<CFOUTPUT QUERY = "sif_ds">
  <tr>
    <td class="colheader"><strong>ENTIDAD FEDERATIVA: </strong></td>
    <td class="colfooter">#UCase(EntFed)#</td>
  </tr>
</CFOUTPUT>
</table>
<p align="center"> <a href="pdf/PNES2012_e00T0.pdf">Obtener formato de Seguimiento F&iacute;sico </a></p>
<p align="center"> <a href="pdf/PRAFIPP_Piloto.pdf">Obtener Gu&iacute;a de uso </a></p>
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
	<cfset Nom_banco="No capturado">
	<cfset Informe.Trimestre=#Trim_Captura#>
    <cfif  #SESSION.rol# eq 6 and #Trim_CapturaT# GT 9>
		<cfset Informe.Trimestre=#Trim_CapturaT#>    
    <cfelseif #SESSION.rol# eq 4 and  #Trim_Captura# GT 9>
		<cfset Informe.Trimestre=#Trim_Captura#>    
    </cfif>

    <cfset SESSION.Trimestre=#Informe.Trimestre#>
    <cfset Informe.Status_Trim1=#Status_Trim1# >
    <cfset Informe.Status_Trim2=#Status_Trim2# >
    <cfset Informe.Status_Trim3=#Status_Trim3# >
    <cfset Informe.Status_Trim4=#Status_Trim4# >

</CFOUTPUT>
<p align="center">Seleccione una opci&oacute;n: 
  <input type="button" name="Btn_Asig" id="Btn_Asig" value="Asignaciones" onClick="HideShow_Asig();">
  <input type="button" name="Btn_Trans" id="Btn_Trans" value="Transferencias" onClick="HideShow_Trans();">
  <input type="button" name="Btn_Movs" id="Btn_Movs" value="Movimientos" onClick="HideShow_Movs();">
  <cfif  (#SESSION.rol# eq 6 and #sif_ds.Trim_CapturaT# GT 9) or (#SESSION.rol# eq 4 and  #sif_ds.Trim_Captura# GT 9)> <!--- trimestre >10 indica que se encuentra en revisión --->
    <input type="button" name="Btn_Calif" id="Btn_Calif" value="Dictaminar" onClick="HideShow_Calif();">
  </cfif>
  <!---input type="button" name="Btn_Pror" id="Btn_Pror" value="Prorrogas" onClick="HideShow_Pror();"--->
  <!---input type="button" name="Btn_UpLoad" id="Btn_UpLoad" value="UpLoad" onClick="HideShow_UpLoad();"--->
</p>
<cfquery  datasource="prafipp" name="banco">
	select * from Bancos where Id_Banco=#Id_Banco#
</cfquery>
<cfoutput query = "banco">
	<cfset Nom_banco=#Nom_banco#>
</cfoutput>
<cfset Informe.captura=#SESSION.rol# eq 8 and #Informe.Trimestre# LT 10> 

<!--- >
<div id="UpLoad">
	<cfif isDefined("fileUpload")>
    	<cfdump #fileUpload#>
      <cffile action="UpLoad"
         fileField="fileUpload"
         destination="C:\docs\prafipp">
         <p>su archivo ha sido cargado con éxito.</p>
    </cfif>
    <form enctype="multipart/form-data" method="post">
    <input type="file" name="fileUpload" /><br />
    <input type="submit" value="Subir archivo seleccionado" />
    </form>
</div>
< --->

<div id="Asignaciones" >
  <table width="100%" class="TblInterna">
    <tr align="center">
      <td colspan="4" class="colheader">ASIGNACIONES</td>
    </tr>
    <tr class="custom_tr">
      <td width="29%">Recurso federal asignado para el a&ntilde;o <cfoutput>#Informe.ejercicio#</cfoutput></td>
      <td width="29%"><cfoutput>#NumberFormat( Recurso_Asignado, "," )#</cfoutput></td>
      <td width="20%">Clave presupuestal</td>
      <td width="22%"><cfoutput>#Clave_Presup#</cfoutput></td>
    </tr>
    <tr>
      <td><p>Convenio de colaboraci&oacute;n</p></td>
      <td>
	  <cfif #Convenio# eq 1>
		<cfoutput>Si</cfoutput>
      <cfelse>
		<cfoutput>En proceso</cfoutput>
      </cfif>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr class="custom_tr">
      <td class="custom_tr">Instituci&oacute;n bancaria</td>
      <td><cfoutput>#Nom_banco#</cfoutput></td>
      <td>Fecha de apertura</td>
      <td><cfoutput>#DateFormat(Fecha_Apertura, "dd-mm-yyyy")#</cfoutput></td>
    </tr>
    <tr>
      <td>Beneficiario</td>
      <td colspan="3"><cfoutput>#Beneficiario#</cfoutput></td>
    </tr>
    <tr class="custom_tr">
      <td>Cuenta de cheques</td>
      <td><cfoutput>#Cta_Cheques#</cfoutput></td>
      <td>No de cuenta  CLABE (SPEI)</td>
      <td><cfoutput>#SPEI#</cfoutput></td>
    </tr>
  </table>
</div>
  <CFOUTPUT QUERY = "sif_ds">
    <cfset Transf1_Monto= #Transf1_Monto#>
    <cfset Transf1_Fecha = #DateFormat(Transf1_Fecha, "dd-mm-yyyy")#>
    <cfset Transf1_Recibo=#Transf1_Recibo#>
    <cfset Transf1_Recibo_Fecha=#Transf1_Recibo_Fecha#>
    <cfset Transf2_Monto= #Transf2_Monto#>
    <cfset Transf2_Fecha =#DateFormat(Transf2_Fecha, "dd-mm-yyyy")#>
    <cfset Transf2_Recibo=#Transf2_Recibo#>
    <cfset Transf2_Recibo_Fecha=#Transf2_Recibo_Fecha#>
    <cfset Transf3_Monto= #Transf3_Monto#>
    <cfset Transf3_Fecha = #DateFormat(Transf3_Fecha, "dd-mm-yyyy")#>
    <cfset Transf3_Recibo=#Transf3_Recibo#>
    <cfset Transf3_Recibo_Fecha=#Transf3_Recibo_Fecha#>
    <cfset Transf4_Monto= #Transf4_Monto#>
    <cfset Transf4_Fecha =#DateFormat(Transf4_Fecha, "dd-mm-yyyy")#>
    <cfset Transf4_Recibo=#Transf2_Recibo#>
    <cfset Transf4_Recibo_Fecha=#Transf4_Recibo_Fecha#>
  </CFOUTPUT>
  </p>
  <div id="Transferencias" >  
    <table width="903" class="TblInterna">
    <tr align="center">
      <td  colspan="5"class="colheader">TRANSFERENCIAS DEL RECURSO FEDERAL A EL ESTADO</td>
    </tr>
    <tr align="center" class="colfooter">
      <td width="12%">N&uacute;mero de transferencia</td>
      <td width="24%">Fecha de transferencia</td>
      <td width="24%">Monto de transferencia</td>
      <td width="16%">Cuenta con recibo institucional</td>
      <td width="24%">Fecha de Entrega del Recibo Institucional</td>
    </tr>
    <cfif #Transf1_Monto# GT 0>
      <cf_transferencias Numero="Primera" Monto=#Transf1_Monto# Tiene_Recibo=#Transf1_Recibo# Fecha="#Transf1_Fecha#" F2="#Transf1_Recibo_Fecha#" clase="custom_tr">
	  <cfif #Transf2_Monto# GT 0>
        <cf_transferencias Numero="Segunda" Monto=#Transf2_Monto# Tiene_Recibo=#Transf2_Recibo# Fecha="#Transf2_Fecha#" F2="#Transf3_Recibo_Fecha#" clase="">
		<cfif #Transf3_Monto# GT 0>
          <cf_transferencias Numero="Tercera" Monto=#Transf3_Monto# Tiene_Recibo=#Transf3_Recibo# Fecha="#Transf3_Fecha#" F2="#Transf3_Recibo_Fecha#" clase="custom_tr">
		  <cfif #Transf4_Monto# GT 0>
            <cf_transferencias Numero="Cuarta" Monto=#Transf4_Monto# Tiene_Recibo=#Transf4_Recibo# Fecha="#Transf4_Fecha#" F2="#Transf4_Recibo_Fecha#" clase="">
           </cfif> 
         </cfif> 
       </cfif> 
       <cfelse>
        <cf_transferencias Numero="Ninguna" Monto="" Tiene_Recibo="" Fecha="" F2="" clase="">
     </cfif> 
  
    <tr class="custom_tr">
      <td>Trimestre reportado</td>
      <td align="center">
		  <cfif #Informe.Trimestre# GT 9 >      
              <cfset trim_temp = #Informe.Trimestre#/10>
              <cfoutput >#trim_temp#</cfoutput>
          <cfelse>
              <cfoutput >#Informe.Trimestre#</cfoutput>
          </cfif>
      </td>
      <td colspan="3">
      
      <!---div id="UpLoad" style="display:block">
		<cfif isDefined("fileUpload")>
          <cffile action="upload"
             fileField="fileUpload"
             nameConflict = "Overwrite"
             destination="C:\Program Files (x86)\Apache Software Foundation\Apache2.2\htdocs\prafipp_dev\descargas">
             <cfquery datasource="prafipp">
             <cfset qinsert= 'update Prog_EntFed set Transf1_File='+
			 '"'+#file.serverfile#+'.'+#file.serverfileext#+
			 '" where Id_Prog="'+#Informe.Id_Prog#+
			 '" and Id_EntFed="'+
			 #Informe.Id_EntFed#+
			 '"'
			 <cfdump #qinsert#>
			 #qinsert#
             </cfquery>
             
             <p>Archivo cargado con éxito.</p>
        </cfif>
        <form enctype="multipart/form-data" method="post">
            <input type="file" name="fileUpload" />
            <input type="submit" value="Subir archivo" />
        </form>
      </div--->
      
      </td>
    </tr>
  </table>
 </div>
 <br />
<cfform name="Egresos" id="Egresos" method="post" action="save_trim.cfm">  
<div id="Movimientos" >
  <cf_movimientos attributecollection=#Informe# Desde=1 Num_Egresos=#Informe.Num_Egresos# Nom_Form="Egresos" grupo="E" Status_Trim1=#Informe.Status_Trim1# Status_Trim2=#Informe.Status_Trim2# Status_Trim3=#Informe.Status_Trim3# Status_Trim4=#Informe.Status_Trim4#>
</div>

<div id="Prorroga" style="display:none;">
  <cfset DesdePro=#Informe.Num_Egresos#+5>
  <cf_movimientos attributecollection=#Informe# Desde=#DesdePro# Num_Egresos=#Informe.Num_Egresos_Pro# Nom_Form="Egresos" grupo="P">
</div>

<!--- <cfif   #Informe.Trimestre# GT 9 and (#SESSION.Rol# EQ 4 or #SESSION.Rol# EQ 10)> --->
<cfif (#SESSION.Rol# EQ 4  and #sif_ds.Trim_Captura# GT 9) or ( #SESSION.Rol# EQ 6  and #sif_ds.Trim_CapturaT# GT 9)>
  <div id="Dictaminar" >
    <table width="903" class="TblInterna">
    <tr align="center">
      <td  colspan="5"class="colheader">VALIDACI&Oacute;N DE TRIMESTRE</td>
    </tr>
    <tr align="center" class="colfooter">
      <td width="12%">Dict&aacute;men</td>
      <td width="20%">
        <p align="center">
        <a href="dictamen.cfm?c=1">Cumple al 100%</a> <img src="img/verde.png" width="14" height="14" title="Cumple al 100%" />
        </p>
      </td>
      <td width="20%">
        <p align="center">
        <a href="dictamen.cfm?c=0">No cumple </a> <img src="img/rojo.png" width="14" height="14" title="Tiene Conceptos pendientes" />
        </p>
      </td>
    </tr>
  </table>
 </div>
</cfif>

  <cfquery datasource="prafipp" name="Total_Rubros">
      select Num_Egresos+Num_Egresos_Pro+8 as rubros from Programas where Id_Prog='#Informe.Id_Prog#' 
  </cfquery>
  <input name="Id_Prog" id="Id_Prog" type="hidden" value="<cfoutput>#informe.Id_Prog#</cfoutput>" />
  <input name="Ejercicio" id="Ejercicio" type="hidden" value="<cfoutput>#informe.Ejercicio#</cfoutput>" />
  <input name="Id_EntFed" id="Id_EntFed" type="hidden" value="<cfoutput>#informe.Id_EntFed#</cfoutput>" />
  <input name="Total_Rubros" id="Total_Rubros" type="hidden" value="<cfoutput>#Total_Rubros.Rubros#</cfoutput>" />
</cfform>
</td></tr>
</table>
<table align="center" border="0" cellspacing="0" cellpadding="0" width="975">
<tr><td>
<img src="img/footer.jpg" width="975" height="23" alt="footer" />
</td></tr>
</table>
</body>
</html>
<!--- Print --->
</cfdocument>
<!--- Print --->