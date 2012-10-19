<cfapplication name="prafipp" sessionmanagement="yes">
<!---cfset SESSION.Id_EntFed=#url.Id_EntFed#--->

	<cfdocument format="pdf" pagetype="letter" orientation="landscape">
  
<!---

--->
<head>
<title>ITAF (Informe Trimestral de Avance Financiero)</title>
<link rel="stylesheet" type="text/css" href="css/prafipp.css">
</style>
<script type="text/javascript" language="javascript" src="js/func.js"></script>


<!-- Hoja de estilos del calendario -->
<link rel="stylesheet" type="text/css" media="all" href="calendario/calendar-win2k-cold-1.css" title="win2k-cold-1" />
<script type="text/javascript" src="calendario/calendar.js"></script>
<script type="text/javascript" src="calendario/lang/calendar-es.js"></script>
<script type="text/javascript" src="calendario/calendar-setup.js"></script>


<script type="text/javascript">
function valnum(e) { // 1
    tecla = (document.all) ? e.keyCode : e.which; // 2
    if (tecla==8) return true; // 3
		patron = /\d/; // Solo acepta números
		//patron = /\w/; // Acepta números y letras
		//patron = /\D/; // No acepta números
		//patron =/[A-Za-zñÑ\s]/; // igual que el ejemplo, pero acepta también las letras ñ y Ñ
    	te = String.fromCharCode(tecla); // 5
    return patron.test(te); // 6
} 

function esFechaValida(fecha){
    if (fecha != undefined && fecha.value != "" ){
        if (!/^\d{2}\/\d{2}\/\d{4}$/.test(fecha.value)){
            alert("Formato de fecha no válido (dd/mm/aaaa)");
            return false;
        }
        var dia  =  parseInt(fecha.value.substring(0,2),10);
        var mes  =  parseInt(fecha.value.substring(3,5),10);
        var anio =  parseInt(fecha.value.substring(6),10);
 
    switch(mes){
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            numDias=31;
            break;
        case 4: case 6: case 9: case 11:
            numDias=30;
            break;
        case 2:
            if (comprobarSiBisisesto(anio)){ numDias=29 }else{ numDias=28};
            break;
        default:
            alert("Fecha introducida erronea");
            return false;
    }
 
        if (dia>numDias || dia==0){
            alert("Fecha introducida erronea");
            return false;
        }
        return true;
    }
}
 
function comprobarSiBisisesto(anio){
if ( ( anio % 100 != 0) && ((anio % 4 == 0) || (anio % 400 == 0))) {
    return true;
    }
else {
    return false;
    }
}

</script>
</head>


<body>





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
  <cfset Informe.Id_EntFed=#SESSION.Id_EntFed#>
  
<!---                       CABECERA PDF                             
<cfdocumentitem type="header">
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
--->

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

<!--- TERMINANA ELEMENTOS DE PDF --->


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
    <cfset Id_Banco_L=#Id_Banco_L#>
    <cfset Fecha_Apertura=#Fecha_Apertura#>
    <cfset Fecha_Apertura_L=#Fecha_Apertura_L#>
    <cfset Beneficiario=#Beneficiario#>
    <cfset Beneficiario_L=#Beneficiario_L#>
    <cfset Cta_Cheques=#Cta_Cheques#>
    <cfset Cta_Cheques_L=#Cta_Cheques_L#>
    <cfset SPEI=#SPEI#>
    <cfset SPEI_L=#SPEI_L#>
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
  <cfif  (#SESSION.rol# eq 8 and #sif_ds.Trim_CapturaT# LT 9) or (#SESSION.rol# eq 10 and  #sif_ds.Trim_Captura# LT 9)>
  	<input type="button" name="Btn_Cargar" id="Btn_Cargar" value="Cargar" onClick="HideShow_Cargar();">
  </cfif>
  <cfif  (#SESSION.rol# eq 6 and #sif_ds.Trim_CapturaT# GT 9) or (#SESSION.rol# eq 4 and  #sif_ds.Trim_Captura# GT 9)> <!--- trimestre >10 indica que se encuentra en revisiÃ³n --->
    <input type="button" name="Btn_Calif" id="Btn_Calif" value="Dictaminar" onClick="HideShow_Calif();">
  </cfif>
  <cfif  #SESSION.rol# eq 4>
  	<input type="button" name="Btn_Administracion" id="Btn_Administracion" value="Administracion" onClick="HideShow_Administracion();">
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

<!---div id="UpLoad">
	<cfif isDefined("fileUpload")>
    	<cfdump #fileUpload#>
      <cffile action="UpLoad"
         fileField="fileUpload"
         destination="C:\docs\prafipp">
         <p>su archivo ha sido cargado con Ã©xito.</p>
    </cfif>
    <form enctype="multipart/form-data" method="post">
    <input type="file" name="fileUpload" /><br />
    <input type="submit" value="Subir archivo seleccionado" />
    </form>
</div--->

<!---  FUNCION PARA CONSULTAR EL NUMERO DE ARCHIVOS CARGADOS  --->

<cffunction name="numArchivos" access="remote" returntype="string" description="Numero de archivos">
 <cfargument name="Tipo" type="string" required="yes">
 
     <cfquery name="QueryNum" datasource="prafipp">
        SELECT	Num_Arch
        FROM	Cargas
        WHERE	Id_Prog=#Informe.Id_Prog#
        AND		Id_EntFed=#Informe.Id_EntFed#
        AND		Trim_Captura=#Informe.Trimestre#
        AND		Tipo='#arguments.Tipo#'
    </cfquery>
 
	<cfset num = 0 >
    <cfoutput query="QueryNum"><cfset num = #Num_Arch# ></cfoutput>
    <cfreturn num>  
</cffunction>

<!---                FIN DE FUNCION                   --->


  <!---<div id="Asignaciones" >--->
  <cfform name="Asignaciones" id="Asignaciones" method="post" action="save_asig.cfm">
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
    
    
	<cfif #SESSION.rol# eq 8>
    	<cfset sololee = ''>
        <cfset sololee_sel = ''>
    <cfelse>
    	<cfset sololee = 'readonly'>
        <cfset sololee_sel = 'disabled'>
    </cfif>       
    
    <tr class="custom_tr">
      <td class="custom_tr">Instituci&oacute;n bancaria</td>
      <td><cfoutput>#Nom_banco#</cfoutput></td>
      <td class="custom_tr">Instituci&oacute;n bancaria local</td>
      <!---<td><cfoutput>#Nom_banco_L#</cfoutput></td>--->
      <td>
		<cfset sel_1=''> <cfset sel_2=''> <cfset sel_3=''> <cfset sel_4=''> <cfset sel_5=''> <cfset sel_6=''> <cfset sel_7=''> <cfset sel_8=''> <cfset sel_9=''> <cfset sel_10=''> <cfset sel_11=''> <cfset sel_12=''>

      	<cfif #Id_Banco_L# eq 1> <cfset sel_1='selected="selected"'>
        <cfelseif #Id_Banco_L# eq 2> <cfset sel_2='selected="selected"'>
        <cfelseif #Id_Banco_L# eq 3> <cfset sel_3='selected="selected"'>
        <cfelseif #Id_Banco_L# eq 4> <cfset sel_4='selected="selected"'>
        <cfelseif #Id_Banco_L# eq 5> <cfset sel_5='selected="selected"'>
        <cfelseif #Id_Banco_L# eq 6> <cfset sel_6='selected="selected"'>
        <cfelseif #Id_Banco_L# eq 7> <cfset sel_7='selected="selected"'>
        <cfelseif #Id_Banco_L# eq 8> <cfset sel_8='selected="selected"'>
        <cfelseif #Id_Banco_L# eq 9> <cfset sel_9='selected="selected"'>
        <cfelseif #Id_Banco_L# eq 10> <cfset sel_10='selected="selected"'>
        <cfelseif #Id_Banco_L# eq 11> <cfset sel_11='selected="selected"'>
        <cfelseif #Id_Banco_L# eq 12> <cfset sel_12='selected="selected"'>
        </cfif>

      	<cfoutput>
        <select id="banco" name="banco" #sololee_sel#>
            <option value = "1" #sel_1#>Banco Nacional de México, S.A.</option>
            <option value = "2" #sel_2#>BBVA Bancomer, S.A.</option>
            <option value = "3" #sel_3#>Banco Santander Mexicano, S.A.</option>
            <option value = "4" #sel_4#>HSBC, México, S.A.</option>
            <option value = "5" #sel_5#>Banco del Bajío, S.A.</option>
            <option value = "6" #sel_6#>Ixe Banco, S.A.</option>
            <option value = "7" #sel_7#>Banco Inbursa, S.A.</option>
            <option value = "8" #sel_8#>Scotiabank Inverlat, S.A.</option>
            <option value = "9" #sel_9#>Banca Afirme, S.A. </option>
            <option value = "10" #sel_10#>Banco Mercantil del Norte, S.A.</option>
            <option value = "11" #sel_11#>Banco Azteca</option>
            <option value = "12" #sel_12#>Sin definir</option>                                    
        </select>
        </cfoutput>
      </td>
    </tr>
    <tr>
      <td>Fecha de apertura</td>
      <td><cfoutput>#DateFormat(Fecha_Apertura, "dd-mm-yyyy")#</cfoutput></td>
      <td>Fecha de apertura local</td>
      <td>

            <cfinput type="text" name="Fecha" class="editable" id="Fecha" value="#DateFormat(Fecha_Apertura_L, 'dd/mm/yyyy')#" size="10" onBlur="esFechaValida(this);" /> 

            <!--<a href="calendario.html" target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=450,height=410,left = 387,top = 259'); return false;"> 
            <img src="img/calendar.gif" width="19" height="18" border="0" id="idFecha" alt="Calendario" /> </a>-->(dd/mm/aaaa)

      </td>
    </tr>    
    <tr class="custom_tr">
      <td>Beneficiario</td>
      <td><cfoutput>#Beneficiario#</cfoutput></td>
      <td>Beneficiario local</td>
      <td><cfoutput><cfinput type="text" name="bene_loc" readonly="#sololee#" class="editable" id="bene_loc" value='#Beneficiario_L#' onkeypress="return valnum(event)"/></cfoutput></td>
    </tr>
    <tr>
      <td>Cuenta de cheques</td>
      <td><cfoutput>#Cta_Cheques#</cfoutput></td>
      <td>Cuenta de cheques Local</td>
      <td><cfoutput><cfinput type="text" name="cheq_loc" readonly="#sololee#" class="editable" id="cheq_loc" value="#Cta_Cheques_L#" onkeypress="return valnum(event)"/></cfoutput></td>
    </tr>
    <tr class="custom_tr">
      <td>No de cuenta  CLABE (SPEI)</td>
      <td><cfoutput>#SPEI#</cfoutput></td>
      <td>(SPEI - Local)</td>
      <td><cfoutput><cfinput type="text" name="spei_loc" readonly="#sololee#" class="editable" id="spei_loc" value="#SPEI_L#" onkeypress="return valnum(event)"/></cfoutput></td>
    </tr>    
  </table>
  <cfif #SESSION.rol# eq 8><p align="center"><input type="submit" name="button" id="button" value="Guardar valores"></cfif>   
  
  <!--- </form> --->
  </cfform>
<!---</div>--->
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
  
 

  <!---div id="Transferencias" --->  
    <table width="903" class="TblInterna">
    <tr align="center">
      <td  colspan="6"class="colheader">TRANSFERENCIAS DEL RECURSO FEDERAL A EL ESTADO</td>
    </tr>
    <tr align="center" class="colfooter">
      <td width="12%">N&uacute;mero de transferencia</td>
      <td width="20%">Fecha de transferencia</td>
      <td width="20%">Monto de transferencia</td>
      <td width="16%">Cuenta con recibo institucional</td>
      <td width="20%">Fecha de Entrega del Recibo Institucional</td>
      <td width="12%">Adjuntar/Descargar</td>
    </tr>
    
<cffunction name="iconoCarga" access="remote" returntype="string" description="Ubicacion del archivo">  
 <cfargument name="Transferencia" type="string" required="yes">  
 	<cfoutput >
	<cfset upload_Tr="cargas.cfm?Prog=#Informe.Id_Prog#&EntFed=#Informe.Id_EntFed#&Captura=#Informe.Trimestre#&Tipo=#arguments.Transferencia#&Rol=#SESSION.Rol#">
    <cfset a_tag = "<a href=#upload_Tr# target='_blank' onClick="&'"'&"window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"&'"'&" class='enlace_imagen'><img src='img/icono_carga.jpg'  border=0/></a>" />
	</cfoutput>
    <cfreturn a_tag>  
</cffunction>

<cffunction name="iconoDescarga" access="remote" returntype="string" description="Ubicacion del archivo">  
 <cfargument name="Transferencia" type="string" required="yes">  
    <cfquery name="qTableData" datasource="prafipp" result="tmpResult">  
     		SELECT	Ubicacion, Tipo
			FROM	Cargas
			WHERE	Id_Prog=#Informe.Id_Prog#
			AND		Id_EntFed=#Informe.Id_EntFed#
			AND		Trim_Captura=#Informe.Trimestre#
			AND		Tipo='#arguments.Transferencia#'
    </cfquery>
    <cfif #tmpResult.RecordCount# EQ 0 >
    	<cfset a_tag = "" >
    <cfelse>
		<cfoutput query="qTableData"><cfset path = #Ubicacion# /></cfoutput>
        <cfdirectory action="list" directory="#path#" name="qGetDirectory" />
        <cfoutput>
        <cfloop query="qGetDirectory">
            <cfset enlace = "descarga.cfm?Id_Prog=#Informe.Id_Prog#&Id_EntFed=#Informe.Id_EntFed#&Trim_Captura=#Informe.Trimestre#&Tipo=#arguments.Transferencia#" />
            <cfset a_tag = "<a href='#enlace#' title='#qGetDirectory.name#' target='_blank' class='enlace_imagen'><img src='img/icono_descarga.jpg' alt='#qGetDirectory.name#'  border=0/></a>" />
        </cfloop>
        </cfoutput>
	</cfif>
    
	<cfreturn a_tag>  
</cffunction>

    <cfif #Transf1_Monto# GT 0>
      <cf_transferencias Numero="Primera" Monto=#Transf1_Monto# Tiene_Recibo=#Transf1_Recibo# Fecha="#Transf1_Fecha#" F2="#Transf1_Recibo_Fecha#" clase="custom_tr" carga="#iconoCarga('Transferencias1')# &nbsp; #iconoDescarga('Transferencias1')# ">
	  <cfif #Transf2_Monto# GT 0>
        <cf_transferencias Numero="Segunda" Monto=#Transf2_Monto# Tiene_Recibo=#Transf2_Recibo# Fecha="#Transf2_Fecha#" F2="#Transf3_Recibo_Fecha#" clase="" carga="#iconoCarga('Transferencias2')# &nbsp; #iconoDescarga('Transferencias2')#">
		<cfif #Transf3_Monto# GT 0>
          <cf_transferencias Numero="Tercera" Monto=#Transf3_Monto# Tiene_Recibo=#Transf3_Recibo# Fecha="#Transf3_Fecha#" F2="#Transf3_Recibo_Fecha#" clase="custom_tr" carga="#iconoCarga('Transferencias3')# &nbsp; #iconoDescarga('Transferencias3')#">
		  <cfif #Transf4_Monto# GT 0>
            <cf_transferencias Numero="Cuarta" Monto=#Transf4_Monto# Tiene_Recibo=#Transf4_Recibo# Fecha="#Transf4_Fecha#" F2="#Transf4_Recibo_Fecha#" clase="" carga="#iconoCarga('Transferencias4')# &nbsp; #iconoDescarga('Transferencias4')#">
           </cfif> 
         </cfif> 
       </cfif> 
       <cfelse>
        <cf_transferencias Numero="Ninguna" Monto="" Tiene_Recibo="" Fecha="" F2="" clase="" carga="">
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
      <td colspan="4">&nbsp;</td>
    </tr>
  </table>
 <!---/div--->
 <br />
 
 

<!---div id="Movimientos"--->
<cfform name="Egresos" id="Egresos" method="post" action="save_trim.cfm">
  <cf_movimientos attributecollection=#Informe# Desde=1 Num_Egresos=#Informe.Num_Egresos# Nom_Form="Egresos" grupo="E" Status_Trim1=#Informe.Status_Trim1# Status_Trim2=#Informe.Status_Trim2# Status_Trim3=#Informe.Status_Trim3# Status_Trim4=#Informe.Status_Trim4#>
<!---/div--->

<!---div id="Cargar" --->
<!---/div--->


<!---div id="Prorroga" style="display:none;"--->
<!---/div--->


<!---div id="Dictaminar" --->
<!---/div--->


<!---div id="Administracion" --->
<!---/div--->



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

</cfdocument>
<!---
<script type="text/javascript">
	HideShow_Asig();
	HideShow_Trans();
	HideShow_Movs();
</script>
--->
</body>
</html>
