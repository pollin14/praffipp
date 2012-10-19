<cfapplication name="prafipp" sessionmanagement="yes">
<cfset SESSION.Id_EntFed=#url.Id_EntFed#>
   
<!---
<cfif IsDefined('url.imp')>
	<cfdocument format="pdf" pagetype="letter" orientation="landscape">
</cfif> 
--->
<head>
<title>ITAF (Informe Trimestral de Avance Financiero)</title>
<link rel="stylesheet" type="text/css" href="css/prafipp2.css">

<script type="text/javascript" language="javascript" src="js/func.js"></script>

<!-- Hoja de estilos del calendario -->
<link rel="stylesheet" type="text/css" media="all" href="calendario/calendar-win2k-cold-1.css" title="win2k-cold-1" />
<script type="text/javascript" src="calendario/calendar.js"></script>
<script type="text/javascript" src="calendario/lang/calendar-es.js"></script>
<script type="text/javascript" src="calendario/calendar-setup.js"></script>
<script>
function checarcombo(comb, fech, img_fech){
	//alert("combo=" + comb.name);
	//alert("fecha=" + fech.name);
	if(comb.value==1){
		img_fech.style.visibility="visible";
	}else{
		fech.value="";
		img_fech.style.visibility="hidden"; 
	}
}
function abrir(pagina) {
     //window.open('','window','width=400,height=200,scrollbars=yes');
	 window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259');
}
</script>

</head>


<body>





<div id="wrapper" class="center">
	<div id="header"></div>
	<div id="container">

<cfinclude template="chk_session_imp.cfm">

<table align="center" border="0" cellspacing="0" cellpadding="0" width="968">
<tr><td width="135">
  <td width="968" height="700" valign="top">
  <h2 align="center">INFORME TRIMESTRAL DE AVANCE FINANCIERO Y FISICO</h2>
  <cfset Informe = structnew()>
  <cfset Informe.Ejercicio=#SESSION.Ejercicio#>
  <cfset SESSION.Ejercicio=#SESSION.Ejercicio#>
  
  <!---cfif (#find(",",SESSION.Id_Prog)# GT 0) AND (#find("6",SESSION.Rol)# GT 0)--->
  <cfif (#find(",",SESSION.Id_Prog)# GT 0) AND ( (#find("7",SESSION.Rol)# GT 0) OR (#find("8",SESSION.Rol)# GT 0) OR (#find("9",SESSION.Rol)# GT 0) OR (#find("10",SESSION.Rol)# GT 0) OR (#find("18",SESSION.Rol)# GT 0) )>
		<!---cfset SESSION.Id_Prog=#url.Id_Prog#--->
        <cfset Informe.Id_Prog=#url.Id_Prog#>
        <cfset SESSION.Id_Prog=#Informe.Id_Prog#>
  <cfelse>
  		<cfset Informe.Id_Prog=#SESSION.Id_Prog#>
  </cfif>
  
  
  <cfset Informe.Id_EntFed=#url.Id_EntFed#>
  
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

<cfif IsDefined('url.imp')>
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
</cfif>
--->
<!--- TERMINANA ELEMENTOS DE PDF --->


<table width="975" border="0" cellspacing="2">
<CFQUERY DATASOURCE = "prafipp" NAME = "sif_dsa">
  SELECT * FROM Programas where Id_Prog=#Informe.Id_Prog#
</CFQUERY>
<CFOUTPUT QUERY = "sif_dsa">
  <tr>
    <td width="167" class="colheader"><strong>PROGRAMA :</strong></td>
    <td width="791" class="colfooter">#Nom_Prog#</td>
  </tr>   
  <cfset Informe.Num_Egresos=#Num_Egresos#>
  <cfset Informe.Num_Egresos_Pro=#Num_Egresos_Pro#>
  <cfset Nom_Formato=#Nom_Formato#>   

</CFOUTPUT>
 <tr>
    <td class="colheader"><strong>EJERCICIO: </strong></td>
    <td class="colfooter"><cfoutput>#Informe.ejercicio#</cfoutput></td>
  </tr>
<CFQUERY DATASOURCE = "prafipp" NAME = "sif_dsb">
	SELECT * FROM entidad where Id_EntFed=#Informe.Id_EntFed#
</CFQUERY>
<CFOUTPUT QUERY = "sif_dsb">
  <tr>
    <td class="colheader"><strong>ENTIDAD FEDERATIVA: </strong></td>
    <td class="colfooter">#UCase(EntFed)#</td>
  </tr>
</CFOUTPUT>
</table>
<cfif #Nom_Formato# NEQ "">
<p align="center"> <a href="pdf/<CFOUTPUT>#Nom_Formato#</CFOUTPUT>">Obtener formato de Seguimiento F&iacute;sico </a></p>
</cfif>
<p align="center"> <a href="pdf/PRAFFIPP_Guia.pdf">Obtener Gu&iacute;a de uso </a></p>


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
	<cfset Informe.TrimestreT=#Trim_CapturaT#>
    <cfif  (#find("6",SESSION.Rol)# GT 0) and #Trim_CapturaT# GT 9>
		<cfset Informe.Trimestre=#Trim_CapturaT#>    
    <cfelseif (#find("4",SESSION.Rol)# GT 0) and  #Trim_Captura# GT 9>
		<cfset Informe.Trimestre=#Trim_Captura#>    
    </cfif>

    <cfset SESSION.Trimestre=#Informe.Trimestre#>
    <cfset Informe.Status_Trim1=#Status_Trim1# >
    <cfset Informe.Status_Trim2=#Status_Trim2# >
    <cfset Informe.Status_Trim3=#Status_Trim3# >
    <cfset Informe.Status_Trim4=#Status_Trim4# >

</CFOUTPUT>

<table width="100%" border="0" align="right">
  <tr>
    	
    <td width="100%" align="center">  
     	<cfform action="http://168.255.101.69/praffipp/chat/interfaz_chat.php" name="Foro" id="Foro" method="post" target="_blank">
          <input type="button" name="Btn_Asig" id="Btn_Asig" value="Asignaciones" onClick="HideShow_Asig();">
          <input type="button" name="Btn_Trans" id="Btn_Trans" value="Transferencias" onClick="HideShow_Trans();">
          <input type="button" name="Btn_Movs" id="Btn_Movs" value="Movimientos" onClick="HideShow_Movs();">
        
          <!---cfif  (#SESSION.Rol# eq 8 and #sif_ds.Trim_CapturaT# LT 9) or (#SESSION.Rol# eq 10 and  #sif_ds.Trim_Captura# LT 9) or (#SESSION.Rol# eq 4 and  #sif_ds.Trim_Captura# LT 9)--->
		  <cfset Status_Trim=0>
          <cfif #Informe.Trimestre# EQ 1>
          		<cfset Status_Trim=#Informe.Status_Trim1#>
          <cfelseif #Informe.Trimestre# EQ 2>
          		<cfset Status_Trim=#Informe.Status_Trim2#>
          <cfelseif #Informe.Trimestre# EQ 3>
          		<cfset Status_Trim=#Informe.Status_Trim3#>
          <cfelseif #Informe.Trimestre# EQ 4>
          		<cfset Status_Trim=#Informe.Status_Trim4#>                                
          </cfif>
		  <cfset Status_TrimT=0>
          <cfif #Informe.TrimestreT# EQ 1>
          		<cfset Status_TrimT=#Informe.Status_Trim1#>
          <cfelseif #Informe.TrimestreT# EQ 2>
          		<cfset Status_TrimT=#Informe.Status_Trim2#>
          <cfelseif #Informe.TrimestreT# EQ 3>
          		<cfset Status_TrimT=#Informe.Status_Trim3#>
          <cfelseif #Informe.TrimestreT# EQ 4>
          		<cfset Status_TrimT=#Informe.Status_Trim4#>                                
          </cfif>          

		  <cfset tecnico=#Status_TrimT# mod 10>
          <cfif ( ((#find("4",SESSION.Rol)# GT 0) OR (#find("8",SESSION.Rol)# GT 0)) AND (#Status_Trim# LT 50) )>
			  <cfif  ( (#find("8",SESSION.Rol)# GT 0) and (#sif_ds.Trim_Captura# LT 9) ) or ( (#find("10",SESSION.Rol)# GT 0) and  (#sif_ds.Trim_CapturaT# LT 9) ) or ( (#find("6",SESSION.Rol)# GT 0) and  (#sif_ds.Trim_CapturaT# LT 9) ) or ( (#find("4",SESSION.Rol)# GT 0) and  (#sif_ds.Trim_Captura# LT 9) ) or ( (#find("18",SESSION.Rol)# GT 0) and  ( (#sif_ds.Trim_Captura# GT 9) or (#sif_ds.Trim_CapturaT# GT 9) ) )>
                <input type="button" name="Btn_Cargar" id="Btn_Cargar" value="Adjuntar Documentación" onClick="HideShow_Cargar();">
              </cfif>
          <cfelseif ((#find("6",SESSION.Rol)# GT 0) OR (#find("10",SESSION.Rol)# GT 0)) AND (#tecnico# NEQ 6) AND (#tecnico# NEQ 5)>
			  <cfif  ( (#find("8",SESSION.Rol)# GT 0) and (#sif_ds.Trim_Captura# LT 9) ) or ( (#find("10",SESSION.Rol)# GT 0) and  (#sif_ds.Trim_CapturaT# LT 9) ) or ( (#find("6",SESSION.Rol)# GT 0) and  (#sif_ds.Trim_CapturaT# LT 9) ) or ( (#find("4",SESSION.Rol)# GT 0) and  (#sif_ds.Trim_Captura# LT 9) ) or ( (#find("18",SESSION.Rol)# GT 0) and  ( (#sif_ds.Trim_Captura# GT 9) or (#sif_ds.Trim_CapturaT# GT 9) ) )>
                <input type="button" name="Btn_Cargar" id="Btn_Cargar" value="Adjuntar Documentación" onClick="HideShow_Cargar();">
              </cfif>
          </cfif>   
              
          <cfif  ((#find("4",SESSION.Rol)# GT 0) and (#sif_ds.Trim_Captura# GT 9)) or ((#find("6",SESSION.Rol)# GT 0)  and (#sif_ds.Trim_CapturaT# GT 9) )> <!--- trimestre >10 indica que se encuentra en revisiÃ³n --->
            <input type="button" name="Btn_Calif" id="Btn_Calif" value="Dictaminar" onClick="HideShow_Calif();">
          </cfif>
          <cfif  (#find("4",SESSION.Rol)# GT 0)>
            <input type="button" name="Btn_Administracion" id="Btn_Administracion" value="Administracion" onClick="HideShow_Administracion();">
          </cfif>
          <!---input type="button" name="Btn_Pror" id="Btn_Pror" value="Prorrogas" onClick="HideShow_Pror();"--->
          <!---input type="button" name="Btn_UpLoad" id="Btn_UpLoad" value="UpLoad" onClick="HideShow_UpLoad();"--->  

          	<cfoutput>
                <input type="hidden" name="idUsuario" id="idUsuario" value="#SESSION.Id_User#">
                <input type="hidden" name="programa" id="programa" value="#Trim(sif_dsa.Nom_Prog)#">
                <input type="hidden" name="idPrograma" id="idPrograma" value="#Informe.Id_Prog#">
                <input type="hidden" name="entidad" id="entidad" value="#Trim(sif_dsb.EntFed)#">
                <input type="hidden" name="idEntidad" id="idEntidad" value="#SESSION.Id_EntFed#">
                
                <input type="submit" name="Btn_Foro" id="Btn_Foro" value="Base de Conocimiento">
            </cfoutput>
          </cfform>    
     
    </td>
  </tr>
</table>

<p align="center"></br>&nbsp;
</p>

<cfquery  datasource="prafipp" name="banco">
	select * from Bancos where Id_Banco=#Id_Banco#
</cfquery>
<cfoutput query = "banco">
	<cfset Nom_banco=#Nom_banco#>
</cfoutput>


<cfset Informe.captura=(#SESSION.Rol# eq 8 or #SESSION.Rol# eq 18 and #Informe.Trimestre# LT 10)>

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

<div id="Asignaciones" style="display:none;" >
  <!---<form action="mostrarH.cfm" method="post" name="form1" id="form1" width="980" onSubmit="return Valida(this);">--->
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
    
    
	<cfif (#find("8",SESSION.Rol)# GT 0) OR (#find("18",SESSION.Rol)# GT 0)>
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
		
            <CFQUERY DATASOURCE = "prafipp" NAME = "nom_bancos">
                SELECT * FROM bancos
            </CFQUERY>
            <cfset idBancoLocal = 1>
            <cfif (#find("8",SESSION.Rol)# GT 0) OR (#find("18",SESSION.Rol)# GT 0)> 
                <select id="banco" name="banco">
            <cfelse>
                <select id="banco" name="banco" disabled>
            </cfif>                    
            <CFOUTPUT QUERY = "nom_bancos">
                <cfif #Id_Banco_L# IS idBancoLocal>
                    <option value = '#Id_Banco#' selected="selected">#Nom_Banco#</option>
                <cfelse>
                    <option value = '#Id_Banco#'>#Nom_Banco#</option>
                </cfif>
                <cfset idBancoLocal = idBancoLocal+1>
            </CFOUTPUT> 
            </select>

      </td>
    </tr>
    <tr>
      <td>Fecha de apertura</td>
      <td><cfoutput>#DateFormat(Fecha_Apertura, "yyyy-mm-dd")#</cfoutput></td>
      <td>Fecha de apertura local</td>
      <td>
      		<!---<iframe name="calendario" src="calendario.html"></iframe>--->
            
		<cfif (#find("8",SESSION.Rol)# GT 0) OR (#find("18",SESSION.Rol)# GT 0)>           
            <cfinput type="text" name="Fecha" class="editable"  id="Fecha" value="#DateFormat(Fecha_Apertura_L, 'yyyy-mm-dd')#" size="10" readonly /> 
            <img src="img/calendar.gif" width="19" height="18" border="0" id="inicio" alt="Calendario" /> 
            <script type="text/javascript">
                Calendar.setup({
                inputField : "fecha", // id del campo de texto
                ifFormat : "%Y-%m-%d", // formato de la fecha que se escriba en el campo de texto
                button : "inicio" // el id del botón que lanzará el calendario
                });
            </script>
        <cfelse>
        	<cfinput type="text" name="Fecha" class="editable"  id="Fecha" value="#DateFormat(Fecha_Apertura_L, 'yyyy-mm-dd')#" size="10" readonly /> 
		</cfif>            
            <!--<a href="calendario.html" target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=450,height=410,left = 387,top = 259'); return false;"> 
            <img src="img/calendar.gif" width="19" height="18" border="0" id="idFecha" alt="Calendario" /> </a>-->(aaaa-mm-dd)
            
            
          
            
	  <!---<cfoutput>#DateFormat(Fecha_Apertura_L, "dd-mm-yyyy")#</cfoutput>--->
      </td>
    </tr>    
    <tr class="custom_tr">
      <td>Beneficiario</td>
      <td><cfoutput>#Beneficiario#</cfoutput></td>
      <td>Beneficiario local</td>
      <td>
      		<cfif (#find("8",SESSION.Rol)# GT 0) OR (#find("18",SESSION.Rol)# GT 0)> 
	  			<cfoutput><cfinput type="text" name="bene_loc" readonly="#sololee#" class="editable" id="bene_loc" value='#Beneficiario_L#'/></cfoutput></td>
            <cfelse>
            	<cfoutput><cfinput type="text" name="bene_loc" disabled class="editable" id="bene_loc" value='#Beneficiario_L#'/></cfoutput></td>
            </cfif>
    </tr>
    <tr>
      <td>Cuenta de cheques</td>
      <td><cfoutput>#Cta_Cheques#</cfoutput></td>
      <td>Cuenta de cheques Local</td>
      <!---<td><cfoutput><cfinput type="text" name="cheq_loc" readonly="#sololee#" class="editable" id="cheq_loc" value="#Cta_Cheques_L#" onkeypress="return valnum(event)"/></cfoutput></td>--->
      <td>
      		<cfif (#find("8",SESSION.Rol)# GT 0) OR (#find("18",SESSION.Rol)# GT 0)> 
	  			<cfoutput><cfinput type="text" name="cheq_loc" readonly="#sololee#" class="editable" id="cheq_loc" value="#Cta_Cheques_L#"/></cfoutput></td>
            <cfelse>
            	<cfoutput><cfinput type="text" name="cheq_loc" disabled class="editable" id="cheq_loc" value="#Cta_Cheques_L#"/></cfoutput></td>
            </cfif>
    </tr>
    <tr class="custom_tr">
      <td>No de cuenta  CLABE (SPEI)</td>
      <td><cfoutput>#SPEI#</cfoutput></td>
      <td>(SPEI - Local)</td>
      <td>
	  		<cfif (#find("8",SESSION.Rol)# GT 0) OR (#find("18",SESSION.Rol)# GT 0)> 
				<cfoutput><cfinput type="text" name="spei_loc" readonly="#sololee#" class="editable" id="spei_loc" value="#SPEI_L#"/></cfoutput></td>
            <cfelse>
            	<cfoutput><cfinput type="text" name="spei_loc" disabled class="editable" id="spei_loc" value="#SPEI_L#"/></cfoutput></td>
            </cfif>
    </tr>    
  </table>  
  <cfif (#find("8",SESSION.Rol)# GT 0) OR (#find("18",SESSION.Rol)# GT 0)><p align="center"><input type="submit" name="button" id="button" value="Guardar valores"></cfif>
  
  <!--- </form> --->
  </cfform>
</div>
  <CFOUTPUT QUERY = "sif_ds">
    <cfset Transf1_Monto= #Transf1_Monto#>
    <cfset Transf1_Fecha = #DateFormat(Transf1_Fecha, "yyyy-mm-dd")#>
    <cfset Transf1_Recibo=#Transf1_Recibo#>
    <cfset Transf1_Recibo_Fecha=#DateFormat(Transf1_Recibo_Fecha, "yyyy-mm-dd")#>
    <cfset Transf2_Monto= #Transf2_Monto#>
    <cfset Transf2_Fecha =#DateFormat(Transf2_Fecha, "yyyy-mm-dd")#>
    <cfset Transf2_Recibo=#Transf2_Recibo#>
    <cfset Transf2_Recibo_Fecha=#DateFormat(Transf2_Recibo_Fecha, "yyyy-mm-dd")#>
    <cfset Transf3_Monto= #Transf3_Monto#>
    <cfset Transf3_Fecha = #DateFormat(Transf3_Fecha, "yyyy-mm-dd")#>
    <cfset Transf3_Recibo=#Transf3_Recibo#>
    <cfset Transf3_Recibo_Fecha=#DateFormat(Transf3_Recibo_Fecha, "yyyy-mm-dd")#>
    <cfset Transf4_Monto= #Transf4_Monto#>
    <cfset Transf4_Fecha =#DateFormat(Transf4_Fecha, "yyyy-mm-dd")#>
    <cfset Transf4_Recibo=#Transf2_Recibo#>
    <cfset Transf4_Recibo_Fecha=#DateFormat(Transf4_Recibo_Fecha, "yyyy-mm-dd")#>
  </CFOUTPUT>
  </p>
  
 
<!---
  <div id="Transferencias" style="display:none;">
  <cfform name="Transferencias" id="Transferencias" method="post" action="save_trans.cfm">
    <table width="903" class="TblInterna">
    <tr align="center">
      <td  colspan="6"class="colheader">TRANSFERENCIAS DEL RECURSO FEDERAL AL ESTADO</td>
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

<cffunction name="calendario" access="remote" returntype="string" description="Calendario">  
 <cfargument name="Fecha_Transferencia" type="string" required="yes">
 <cfargument name="Num_Transferencia" type="string" required="yes"> 
 	<cfoutput >
	<cfset cal="<input id='fecha_#arguments.Num_Transferencia#' type='text' name='fecha_#arguments.Num_Transferencia#' width='100' readonly value='#arguments.Fecha_Transferencia#' size='10'/>
                <img src='img/calendar.gif' width='19' height='18' border='0' id='img_fecha_#arguments.Num_Transferencia#' alt='Calendario'/>
                <script type='text/javascript'>
                    Calendar.setup({
                    inputField : 'fecha_#arguments.Num_Transferencia#', // id del campo de texto
                    ifFormat : '%Y-%m-%d', // formato de la fecha que se escriba en el campo de texto
                    button : 'img_fecha_#arguments.Num_Transferencia#' // el id del botón que lanzará el calendario
                    });
                </script>">
	</cfoutput>
    <cfreturn cal>  
</cffunction>

<cffunction name="recibo" access="remote" returntype="string" description="Recibo">  
 <cfargument name="Recibo_Transferencia" type="string" required="yes"> 
 <cfargument name="Num_Recibo" type="string" required="yes"> 
 	<cfoutput >
    	<cfset combo = 'selRecibo_#arguments.Num_Recibo#'>
        <cfset fecha = 'fecha_#arguments.Num_Recibo#'>
        <cfset img_fecha = 'img_fecha_#arguments.Num_Recibo#'>
		<cfif #arguments.Recibo_Transferencia# eq 1>
            <cfset sel="<select id='selRecibo_#arguments.Num_Recibo#' name='selRecibo_#arguments.Num_Recibo#' onchange='checarcombo(#combo#,#fecha#,#img_fecha#);'><option value=1 selected>S&iacute;</option><option value=0>No</option></select>">
        <cfelseif #arguments.Recibo_Transferencia# eq 0>
            <cfset sel="<select id='selRecibo_#arguments.Num_Recibo#' name='selRecibo_#arguments.Num_Recibo#' onchange='checarcombo(#combo#,#fecha#,#img_fecha#);'><option value=1>S&iacute;</option><option value=0 selected>No</option></select>">
        <cfelse>
            <cfset sel="<select id='selRecibo_#arguments.Num_Recibo#' name='selRecibo_#arguments.Num_Recibo#' onchange='checarcombo(#combo#,#fecha#,#img_fecha#);'><option value='null'> </option><option value=1>S&iacute;</option><option value=0>No</option></select>">
        </cfif>

	</cfoutput>
    <cfreturn sel>  
</cffunction>

    <cfif #Transf1_Monto# GT 0>
	  <cf_transferencias Numero="Primera" Monto=#Transf1_Monto# Fecha="#Transf1_Fecha#" Tiene_Recibo="#recibo(Transf1_Recibo,'Primera')#" F2="#calendario(Transf1_Recibo_Fecha,'Primera')#" clase="custom_tr" carga="#iconoCarga('Transferencias1')# &nbsp; #iconoDescarga('Transferencias1')# ">
	  <cfif #Transf2_Monto# GT 0>
        <cf_transferencias Numero="Segunda" Monto=#Transf2_Monto# Fecha="#Transf2_Fecha#" Tiene_Recibo="#recibo(Transf2_Recibo,'Segunda')#" F2="#calendario(Transf3_Recibo_Fecha,'Segunda')#" clase="" carga="#iconoCarga('Transferencias2')# &nbsp; #iconoDescarga('Transferencias2')#">
		<cfif #Transf3_Monto# GT 0>
          <cf_transferencias Numero="Tercera" Monto=#Transf3_Monto# Fecha="#Transf3_Fecha#" Tiene_Recibo="#recibo(Transf3_Recibo,'Tercera')#" F2="#calendario(Transf3_Recibo_Fecha,'Tercera')#" clase="custom_tr" carga="#iconoCarga('Transferencias3')# &nbsp; #iconoDescarga('Transferencias3')#">
		  <cfif #Transf4_Monto# GT 0>
            <cf_transferencias Numero="Cuarta" Monto=#Transf4_Monto# Fecha="#Transf4_Fecha#" Tiene_Recibo="#recibo(Transf4_Recibo,'Cuarta')#" F2="#calendario(Transf4_Recibo_Fecha,'Cuarta')#" clase="" carga="#iconoCarga('Transferencias4')# &nbsp; #iconoDescarga('Transferencias4')#">
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
      
      <td colspan="4">
      
      </td>
    </tr>
  </table>
  <cfif #SESSION.Rol# eq 8><p align="center"><input type="submit" name="btnTrans" id="btnTrans" value="Guardar valores"></cfif>
  </cfform>
 </div>
 <br />
 --->
 
   <div id="Transferencias" style="display:none;">
  <cfform name="Transferencias" id="Transferencias" method="post" action="save_trans.cfm">
    <table width="903" class="TblInterna">
    <tr align="center">
      <td  colspan="6"class="colheader">TRANSFERENCIAS DEL RECURSO FEDERAL AL ESTADO</td>
    </tr>
    <tr align="center" class="colfooter">
      <td width="12%">N&uacute;mero de transferencia</td>
      <td width="20%">Fecha de transferencia</td>
      <td width="20%">Monto de transferencia</td>
      <td width="16%">Cuenta con recibo institucional</td>
      <cfif ( (#find("4",SESSION.Rol)# GT 0) OR (#find("18",SESSION.Rol)# GT 0) )>
          <td width="20%">Fecha de Entrega del Recibo Institucional</td>
          <td width="12%">Adjuntar/Descargar</td>
      <cfelse>
          <td width="32%" colspan="2">Fecha de Entrega del Recibo Institucional</td>
      </cfif>
      
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

<cffunction name="calendario" access="remote" returntype="string" description="Calendario">  
 <cfargument name="Fecha_Transferencia" type="string" required="yes">
 <cfargument name="Num_Transferencia" type="string" required="yes"> 
 	<cfoutput >
	<cfset cal="<input id='fecha_#arguments.Num_Transferencia#' type='text' name='fecha_#arguments.Num_Transferencia#' width='100' readonly value='#arguments.Fecha_Transferencia#' size='10'/>
                <img src='img/calendar.gif' width='19' height='18' border='0' id='img_fecha_#arguments.Num_Transferencia#' alt='Calendario'/>
                <script type='text/javascript'>
                    Calendar.setup({
                    inputField : 'fecha_#arguments.Num_Transferencia#', // id del campo de texto
                    ifFormat : '%Y-%m-%d', // formato de la fecha que se escriba en el campo de texto
                    button : 'img_fecha_#arguments.Num_Transferencia#' // el id del botón que lanzará el calendario
                    });
                </script>">
	</cfoutput>
    <cfreturn cal>  
</cffunction>

<cffunction name="recibo" access="remote" returntype="string" description="Recibo">  
 <cfargument name="Recibo_Transferencia" type="string" required="yes"> 
 <cfargument name="Num_Recibo" type="string" required="yes"> 
 	<cfoutput >
    	<cfset combo = 'selRecibo_#arguments.Num_Recibo#'>
        <cfset fecha = 'fecha_#arguments.Num_Recibo#'>
        <cfset img_fecha = 'img_fecha_#arguments.Num_Recibo#'>
		<cfif #arguments.Recibo_Transferencia# eq 1>
            <cfset sel="<select id='selRecibo_#arguments.Num_Recibo#' name='selRecibo_#arguments.Num_Recibo#' onchange='checarcombo(#combo#,#fecha#,#img_fecha#);'><option value=1 selected>S&iacute;</option><option value=0>No</option></select>">
        <cfelseif #arguments.Recibo_Transferencia# eq 0>
            <cfset sel="<select id='selRecibo_#arguments.Num_Recibo#' name='selRecibo_#arguments.Num_Recibo#' onchange='checarcombo(#combo#,#fecha#,#img_fecha#);'><option value=1>S&iacute;</option><option value=0 selected>No</option></select>">
        <cfelse>
            <cfset sel="<select id='selRecibo_#arguments.Num_Recibo#' name='selRecibo_#arguments.Num_Recibo#' onchange='checarcombo(#combo#,#fecha#,#img_fecha#);'><option value='null'> </option><option value=1>S&iacute;</option><option value=0>No</option></select>">
        </cfif>

	</cfoutput>
    <cfreturn sel>  
</cffunction>

	<cfif ( (#find("4",SESSION.Rol)# GT 0) OR (#find("12",SESSION.Rol)# GT 0) )>
		<cfif #Transf1_Monto# GT 0>
          <cf_transferencias Numero="Primera" Monto=#Transf1_Monto# Fecha="#Transf1_Fecha#" Tiene_Recibo="#recibo(Transf1_Recibo,'Primera')#" F2="#calendario(Transf1_Recibo_Fecha,'Primera')#" clase="custom_tr" carga="#iconoCarga('Transferencias1')# &nbsp; #iconoDescarga('Transferencias1')# ">
          <cfif #Transf2_Monto# GT 0>
            <cf_transferencias Numero="Segunda" Monto=#Transf2_Monto# Fecha="#Transf2_Fecha#" Tiene_Recibo="#recibo(Transf2_Recibo,'Segunda')#" F2="#calendario(Transf3_Recibo_Fecha,'Segunda')#" clase="" carga="#iconoCarga('Transferencias2')# &nbsp; #iconoDescarga('Transferencias2')#">
            <cfif #Transf3_Monto# GT 0>
              <cf_transferencias Numero="Tercera" Monto=#Transf3_Monto# Fecha="#Transf3_Fecha#" Tiene_Recibo="#recibo(Transf3_Recibo,'Tercera')#" F2="#calendario(Transf3_Recibo_Fecha,'Tercera')#" clase="custom_tr" carga="#iconoCarga('Transferencias3')# &nbsp; #iconoDescarga('Transferencias3')#">
              <cfif #Transf4_Monto# GT 0>
                <cf_transferencias Numero="Cuarta" Monto=#Transf4_Monto# Fecha="#Transf4_Fecha#" Tiene_Recibo="#recibo(Transf4_Recibo,'Cuarta')#" F2="#calendario(Transf4_Recibo_Fecha,'Cuarta')#" clase="" carga="#iconoCarga('Transferencias4')# &nbsp; #iconoDescarga('Transferencias4')#">
              </cfif> 
            </cfif> 
         </cfif> 
         <cfelse>
            <cf_transferencias Numero="Ninguna" Monto="" Tiene_Recibo="" Fecha="" F2="" clase="" carga="">
         </cfif> 
    <cfelse>
		<cfif #Transf1_Monto# GT 0>
          <cf_transferencias Numero="Primera" Monto=#Transf1_Monto# Fecha="#Transf1_Fecha#" Tiene_Recibo="#recibo(Transf1_Recibo,'Primera')#" F2="#calendario(Transf1_Recibo_Fecha,'Primera')#" clase="custom_tr" carga="">
          <cfif #Transf2_Monto# GT 0>
            <cf_transferencias Numero="Segunda" Monto=#Transf2_Monto# Fecha="#Transf2_Fecha#" Tiene_Recibo="#recibo(Transf2_Recibo,'Segunda')#" F2="#calendario(Transf2_Recibo_Fecha,'Segunda')#" clase="" carga="">
            <cfif #Transf3_Monto# GT 0>
              <cf_transferencias Numero="Tercera" Monto=#Transf3_Monto# Fecha="#Transf3_Fecha#" Tiene_Recibo="#recibo(Transf3_Recibo,'Tercera')#" F2="#calendario(Transf3_Recibo_Fecha,'Tercera')#" clase="custom_tr" carga="">
              <cfif #Transf4_Monto# GT 0>
                <cf_transferencias Numero="Cuarta" Monto=#Transf4_Monto# Fecha="#Transf4_Fecha#" Tiene_Recibo="#recibo(Transf4_Recibo,'Cuarta')#" F2="#calendario(Transf4_Recibo_Fecha,'Cuarta')#" clase="" carga="">
              </cfif> 
            </cfif> 
         </cfif> 
         <cfelse>
            <cf_transferencias Numero="Ninguna" Monto="" Tiene_Recibo="" Fecha="" F2="" clase="" carga="">
         </cfif> 
	</cfif>
  
	<!---cfif #Transf1_Recibo# IS NOT 1><script type="text/javascript">disable1();</script></cfif--->
	
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
      
      <td colspan="4">
      
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
             
             <p>Archivo cargado con Ã©xito.</p>
        </cfif>
        <form enctype="multipart/form-data" method="post">
            <input type="file" name="fileUpload" />
            <input type="submit" value="Subir archivo" />
        </form>
      </div--->
      
      </td>
    </tr>
  </table>
  <cfif (#find("8",SESSION.Rol)# GT 0) OR (#find("4",SESSION.Rol)# GT 0) OR (#find("18",SESSION.Rol)# GT 0)><p align="center"><input type="submit" name="btnTrans" id="btnTrans" value="Guardar valores"></cfif>
  </cfform>
 </div>
 <br />
 
 
 
 
<cfform name="Egresos" id="Egresos" method="post" action="save_trim.cfm">
    <div id="Movimientos" style="display:none;">
      <cf_movimientos attributecollection=#Informe# Desde=1 Num_Egresos=#Informe.Num_Egresos# Nom_Form="Egresos" grupo="E" Status_Trim1=#Informe.Status_Trim1# Status_Trim2=#Informe.Status_Trim2# Status_Trim3=#Informe.Status_Trim3# Status_Trim4=#Informe.Status_Trim4#>
    </div>


<cfset upload_It="cargas.cfm?Prog=#Informe.Id_Prog#&EntFed=#Informe.Id_EntFed#&Captura=#Informe.TrimestreT#&Tipo=InformeTecnico&Rol=#SESSION.Rol#">
<cfset upload_Ec="cargas.cfm?Prog=#Informe.Id_Prog#&EntFed=#Informe.Id_EntFed#&Captura=#Informe.Trimestre#&Tipo=EstadoCuenta&Rol=#SESSION.Rol#">
<cfset upload_Re="cargas.cfm?Prog=#Informe.Id_Prog#&EntFed=#Informe.Id_EntFed#&Captura=#Informe.Trimestre#&Tipo=ReintegroTesoreria&Rol=#SESSION.Rol#">
<cfset upload_Ri="cargas.cfm?Prog=#Informe.Id_Prog#&EntFed=#Informe.Id_EntFed#&Captura=#Informe.Trimestre#&Tipo=ReciboInstitucional&Rol=#SESSION.Rol#">
<cfset upload_If="cargas.cfm?Prog=#Informe.Id_Prog#&EntFed=#Informe.Id_EntFed#&Captura=#Informe.Trimestre#&Tipo=InformeFinanciero&Rol=#SESSION.Rol#">

<cfset erase_It="borrar.cfm?Id_EntFed=#Informe.Id_EntFed#&Trim_Captura=#Informe.TrimestreT#&Tipo=InformeTecnico">
<cfset erase_Ec="borrar.cfm?Id_EntFed=#Informe.Id_EntFed#&Trim_Captura=#Informe.Trimestre#&Tipo=EstadoCuenta">
<cfset erase_Re="borrar.cfm?Id_EntFed=#Informe.Id_EntFed#&Trim_Captura=#Informe.Trimestre#&Tipo=ReintegroTesoreria">
<cfset erase_Ri="borrar.cfm?Id_EntFed=#Informe.Id_EntFed#&Trim_Captura=#Informe.Trimestre#&Tipo=ReciboInstitucional">
<cfset erase_If="borrar.cfm?Id_EntFed=#Informe.Id_EntFed#&Trim_Captura=#Informe.Trimestre#&Tipo=InformeFinanciero">

<div id="Cargar" style="display:none;">
<cfif (#find("18",SESSION.Rol)# GT 0)>
    <table width="903" class="TblInterna">
    <tr align="center">
      <td  colspan="6"class="colheader">ADJUNTAR DOCUMENTACIÓN (TRIMESTRE <cfoutput>#Informe.Trimestre#)</cfoutput></td>
    </tr>
    <tr align="center" class="colfooter">
      <td width="15%">&nbsp;</td>
      <td width="17%">Estado de cuenta</td>
      <td width="17%">Reintegro tesorer&iacute;a</td>
      <td width="17%">Recibo institucional</td>
      <td width="17%">Informe financiero a color</td>
      <td width="17%">Informe t&eacute;cnico</td>
    </tr>

    <tr>
      <cfset InformesFinancieros = #numArchivos('InformeFinanciero')# + #numArchivos('Transferencias1')# + #numArchivos('Transferencias2')# + #numArchivos('Transferencias3')# + #numArchivos('Transferencias4')#>
      <td>Documentos cargados</td>
      <td align="center"><cfoutput>#numArchivos('EstadoCuenta')#</cfoutput></td>
      <td align="center"><cfoutput>#numArchivos('ReintegroTesoreria')#</cfoutput></td>
      <td align="center"><cfoutput>#numArchivos('ReciboInstitucional')#</cfoutput></td>
      <td align="center"><cfoutput>#InformesFinancieros#</cfoutput></td>
      <td align="center"><cfoutput>#numArchivos('InformeTecnico')#</cfoutput></td>
    </tr>
  
    <tr class="custom_tr">
      <td>Adjuntar</td>
      <td align="center"><cfoutput ><a href=#upload_Ec# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Subir estado de cuenta </a></cfoutput></td>
      <td align="center"><cfoutput ><a href=#upload_Re# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Subir reintegro tesorer&iacute;a </a></cfoutput></td>
      <td align="center"><cfoutput ><a href=#upload_Ri# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Subir recibo institucional </a></cfoutput></td>
      <td align="center"><cfoutput ><a href=#upload_If# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Subir informe financiero</a></cfoutput></td>
      <td align="center"><cfoutput ><a href=#upload_It# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Subir informe t&eacute;cnico </a></cfoutput></td>
    </tr>

    <tr class="custom_tr">
      <td>Borrar</td>
      <td align="center">
			<cfif #numArchivos('EstadoCuenta')# EQ 0><font color="#666666"> Borrar estado de cuenta </font></td>
            <cfelse><cfoutput><a href=#erase_Ec# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Borrar estado de cuenta </a></cfoutput></td>
            </cfif>            
      <td align="center">
			<cfif #numArchivos('ReintegroTesoreria')# EQ 0><font color="#666666"> Borrar reintegro tesorer&iacute;a </font></td>
            <cfelse><cfoutput ><a href=#erase_Re# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Borrar reintegro tesorer&iacute;a </a></cfoutput></td>
            </cfif>  	  
      <td align="center">
			<cfif #numArchivos('ReciboInstitucional')# EQ 0><font color="#666666"> Borrar recibo institucional </font></td>
            <cfelse><cfoutput ><a href=#erase_Ri# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Borrar recibo institucional </a></cfoutput></td>
            </cfif>
      <td align="center">
			<cfif #numArchivos('InformesFinancieros')# EQ 0><font color="#666666"> Borrar informe financiero </font></td>
            <cfelse><cfoutput ><a href=#erase_If# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Borrar informe financiero </a></cfoutput></td>  
            </cfif>
      <td align="center">
			<cfif #numArchivos('InformeTecnico')# EQ 0><font color="#666666"> Borrar informe t&eacute;cnico </font></td>
            <cfelse><cfoutput><a href=#erase_It# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Borrar informe t&eacute;cnico </a></cfoutput></td>
            </cfif>
    </tr>  




  </table>
<!---cfelseif #SESSION.Rol# eq 10--->
<cfelseif (#find("10",SESSION.Rol)# GT 0) OR (#find("6",SESSION.Rol)# GT 0)>
    <table width="903" class="TblInterna">
    <tr align="center">
      <td  colspan="2"class="colheader">ADJUNTAR DOCUMENTACIÓN (TRIMESTRE <cfoutput>#sif_ds.Trim_CapturaT#)</cfoutput></td>
    </tr>
    <tr align="center" class="colfooter">
      <td width="20%">&nbsp;</td>
      <td width="80%">Informe t&eacute;cnico</td>
    </tr>
    <tr>
      <td>Documentos cargados</td>
      <td align="center"><cfoutput>#numArchivos('InformeTecnico')#</cfoutput></td>
    </tr>
    <tr class="custom_tr">
      <td>Adjuntar</td>
      <td align="center"><cfoutput ><a href=#upload_It# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Subir informe t&eacute;cnico </a></cfoutput></td>
    </tr>
    <tr class="custom_tr">
      <td>Borrar</td>
      <td align="center">
			<cfif #numArchivos('InformeTecnico')# EQ 0><font color="#666666"> Borrar informe t&eacute;cnico </font></td>
            <cfelse><cfoutput><a href=#erase_It# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Borrar informe t&eacute;cnico </a></cfoutput></td>
            </cfif>
    </tr>     
    
    
  </table>
<!---cfoutput>SESSION.Rol=#find("8",SESSION.Rol)# _ #find("4",SESSION.Rol)#</cfoutput--->  
<cfelseif ( (#find("8",SESSION.Rol)# GT 0) OR (#find("4",SESSION.Rol)# GT 0) )>
    <table width="903" class="TblInterna">
    <tr align="center">
      <td  colspan="5"class="colheader">ADJUNTAR DOCUMENTACIÓN (TRIMESTRE <cfoutput>#Informe.Trimestre#)</cfoutput></td>
    </tr>
    <tr align="center" class="colfooter">
      <td width="16%">&nbsp;</td>
      <td width="21%">Estado de cuenta</td>
      <td width="21%">Reintegro tesorer&iacute;a</td>
      <td width="21%">Recibo institucional</td>
      <td width="21%">Informe financiero a color</td>
    </tr>

    <tr>
      <cfset InformesFinancieros = #numArchivos('InformeFinanciero')# + #numArchivos('Transferencias1')# + #numArchivos('Transferencias2')# + #numArchivos('Transferencias3')# + #numArchivos('Transferencias4')#>
      <td>Documentos cargados</td>
      <td align="center"><cfoutput>#numArchivos('EstadoCuenta')#</cfoutput></td>
      <td align="center"><cfoutput>#numArchivos('ReintegroTesoreria')#</cfoutput></td>
      <td align="center"><cfoutput>#numArchivos('ReciboInstitucional')#</cfoutput></td>
      <td align="center"><cfoutput>#InformesFinancieros#</cfoutput></td>
    </tr>
  
    <tr class="custom_tr">
      <td>Adjuntar</td>
      <td align="center"><cfoutput ><a href=#upload_Ec# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Subir estado de cuenta </a></cfoutput></td>
      <td align="center"><cfoutput ><a href=#upload_Re# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Subir reintegro tesorer&iacute;a </a></cfoutput></td>
      <td align="center"><cfoutput ><a href=#upload_Ri# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Subir recibo institucional </a></cfoutput></td>
      <td align="center"><cfoutput ><a href=#upload_If# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Subir informe financiero</a></cfoutput></td>      
    </tr>
    
    <tr class="custom_tr">
      <td>Borrar</td>
      <td align="center">
			<cfif #numArchivos('EstadoCuenta')# EQ 0><font color="#666666"> Borrar estado de cuenta </font></td>
            <cfelse><cfoutput><a href=#erase_Ec# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Borrar estado de cuenta </a></cfoutput></td>
            </cfif>            
      <td align="center">
			<cfif #numArchivos('ReintegroTesoreria')# EQ 0><font color="#666666"> Borrar reintegro tesorer&iacute;a </font></td>
            <cfelse><cfoutput ><a href=#erase_Re# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Borrar reintegro tesorer&iacute;a </a></cfoutput></td>
            </cfif>  	  
      <td align="center">
			<cfif #numArchivos('ReciboInstitucional')# EQ 0><font color="#666666"> Borrar recibo institucional </font></td>
            <cfelse><cfoutput ><a href=#erase_Ri# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Borrar recibo institucional </a></cfoutput></td>
            </cfif>
      <td align="center">
			<cfif #numArchivos('InformesFinancieros')# EQ 0><font color="#666666"> Borrar informe financiero </font></td>
            <cfelse><cfoutput ><a href=#erase_If# target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Borrar informe financiero </a></cfoutput></td>  
            </cfif>
    </tr>    
  </table>
<cfelse>
</cfif>
</div>


<div id="Prorroga" style="display:none;">
  <cfset DesdePro=#Informe.Num_Egresos#+5>
  <cf_movimientos attributecollection=#Informe# Desde=#DesdePro# Num_Egresos=#Informe.Num_Egresos_Pro# Nom_Form="Egresos" grupo="P">
</div>

<div id="Administracion" style="display:none;">
<cfif  #find("4",SESSION.Rol)# GT 0 >	
    <table width="903" class="TblInterna">
    <tr align="center">
      <td  colspan="2"class="colheader">ADMINISTRACION DEL SISTEMA</td>
    </tr>
    <tr align="center" class="colfooter">
      <td width="20%">&nbsp;</td>
      <td width="80%">&nbsp;</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr class="custom_tr">
      <td>Comando</td>
      <td align="center"><a href=limpiar_folder.cfm target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;"> Limpiar folder </a></td>
    </tr>
  </table>
</cfif>
</div>



  <cfquery datasource="prafipp" name="Total_Rubros">
      select Num_Egresos+Num_Egresos_Pro+8 as rubros from Programas where Id_Prog='#Informe.Id_Prog#' 
  </cfquery>
  <input name="Id_Prog" id="Id_Prog" type="hidden" value="<cfoutput>#informe.Id_Prog#</cfoutput>" />
  <input name="Ejercicio" id="Ejercicio" type="hidden" value="<cfoutput>#informe.Ejercicio#</cfoutput>" />
  <input name="Id_EntFed" id="Id_EntFed" type="hidden" value="<cfoutput>#informe.Id_EntFed#</cfoutput>" />
  <input name="Total_Rubros" id="Total_Rubros" type="hidden" value="<cfoutput>#Total_Rubros.Rubros#</cfoutput>" />
</cfform>


<!--- <cfif   #Informe.Trimestre# GT 9 and (#SESSION.Rol# EQ 4 or #SESSION.Rol# EQ 10)> --->
<cfform name="Dictaminen" id="Dictaminen" method="post" action="dictamen.cfm">
	<cfif ((#find("4",SESSION.Rol)# GT 0) and (#sif_ds.Trim_Captura# GT 9)) or ((#find("6",SESSION.Rol)# GT 0)  and (#sif_ds.Trim_CapturaT# GT 9))>
      <div id="Dictaminar" style="display:none;">
        <table width="903" class="TblInterna">
        <tr align="center">
          <td  colspan="5"class="colheader">VALIDACI&Oacute;N DE TRIMESTRE</td>
        </tr>
        <tr align="center" class="custom_tr">
          <td width="12%">Nota:</td>
          <!---td  colspan="4" width="88%"><cfinput type="text" name="nota_dictamen" class="editable" id="nota_dictamen" size="40" maxlength="50"/></td--->
          <td  colspan="4" width="88%"><cftextarea name="nota_dictamen" height="20" Width="500" rows="2" cols="100"/></td>
        </tr>
        <tr align="center" class="colfooter">
          <td width="12%">Dict&aacute;men</td>
          <td width="44%">
            <p align="center">
            <!---a href="dictamen.cfm?c=1">Cumple al 100%</a> <img src="img/verde.png" width="14" height="14" title="Cumple al 100%" /> --->
            <cfinput type="Radio" name="RadioDictamen" value="1"> Cumple al 100% <img src="img/verde.png" width="14" height="14" title="Cumple al 100%" />
            </p>
          </td>
          <td width="44%">
            <p align="center">
            <!---a href="dictamen.cfm?c=0">No cumple </a> <img src="img/rojo.png" width="14" height="14" title="Tiene Conceptos pendientes" /> --->
            <cfinput type="Radio" name="RadioDictamen" value="0" checked="yes"> No cumple <img src="img/rojo.png" width="14" height="14" title="Tiene Conceptos pendientes" />
            </p>
          </td>
        </tr>
      </table>
      <p align="center"><input type="submit" name="button" id="button" value="Aplicar dictámen">
     </div>
    </cfif>
</cfform>

</td></tr>
</table>


<!---
<cfif IsDefined('url.imp')>
	</cfdocument>
</cfif>
--->
</div><!-- container -->
<div id="footer"></div>
</div><!-- wrapper -->


<!---a href=itaf_imp.cfm target='_blank'> Imprimir en PDF </a--->
<!---
<script type="text/javascript">
	HideShow_Asig();
	HideShow_Trans();
	HideShow_Movs();
</script>
--->
</body>
</html>
