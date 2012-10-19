<cfapplication name="prafipp" sessionmanagement="yes">
<cfset SESSION.Id_Prog=#url.Id_Prog#>
<cfset Id_Prog=#url.Id_Prog#>

<!---cfif #SESSION.rol# IS 8>
	<cfoutput>
      <cflocation url="itaf_cap.cfm?Id_EntFed=#SESSION.Id_EntFed#">
    </cfoutput>
</cfif--->


<CFQUERY DATASOURCE = "prafipp" NAME = "sif_ds">
  SELECT Nom_Prog, Num_Egresos FROM Programas where Id_Prog=#Id_Prog#
</CFQUERY>
<cfset  Nom_Prog=#sif_ds.Nom_Prog#>
<cfset  Num_Egresos=#sif_ds.Num_Egresos#+#SESSION.num_Ingresos#>
<cfquery name="Montos" datasource="prafipp">
	select * from montos where obsoleto=0 and Id_Prog=#Id_Prog#
</cfquery>
<cfquery name="Entidad" datasource="prafipp">
	select * from entidad
</cfquery>
<cfquery name="Prog_EntFed" datasource="prafipp">
    select * from Prog_EntFed
</cfquery>
<title>PRAFIPP, Desglose nacional por proyecto o programa</title>
<link rel="stylesheet" type="text/css" href="css/prafipp.css">
</style>

<script language="javascript">
function confirmar ( mensaje ) {
	return confirm( mensaje );
}
/*
function linker(){
	var isConfirmed=confirm('Esta acci\u00F3n cambiar\u00E1 el estatus a \nCumple al 100% y abrir\u00E1 el siguiente trimestre')
	if(isConfirmed){
		return false;
	}
	else{
		window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=310,left = 387,top = 259');
		return false;
	}
}
*/
</script>

</head>
<script type="text/javascript" language="javascript" src="js/func.js">
</script>
<body>
<table align="center" border="0" cellspacing="0" cellpadding="0" width="100%">
<tr ><td><img src="img/header.jpg" width="975" height="90" alt="Encabezado" /></td></tr>
</table>

<cfinclude template="chk_session.cfm">

<table align="center" border="0" cellspacing="0" cellpadding="0" width="968" >
<tr><td width="135">
  <td width="968" height="700" valign="top">
<table width="575" border="0" align="center" cellpadding="0" cellspacing="2">
  <col width="198" />
  <col width="80" span="4" />
  <tr>
    <td height="27" colspan="22" align="center">
        <h2 class="colheader"><strong>PROGRAMA <cfoutput>#Nom_Prog#</cfoutput></strong></h2>
    </td>
  </tr>
  <tr class="colfooter">
    <td width="190" rowspan="3" align="center" >2012</td>
    <td rowspan="3" align="center"> Monto asignado</td>
    <td colspan="20" align="center" >Trimestre</td>
  </tr>
  <tr class="colfooter">
    <td width="93" align="center" colspan="5"> 1 </td>
    <td width="97" align="center" colspan="5">2 </td>
    <td width="89" align="center" colspan="5">3 </td>
    <td width="94" align="center" colspan="5">4 </td>
  </tr>
  <tr class="colfooter">
    <td width="93" align="center">ST</td>
    <td width="93" align="center">Saldo Inicial</td>
    <td width="97" align="center">Total de Ingresos</td>
    <td width="89" align="center">Total de Egresos</td>
    <td width="89" align="center">Disponibilidad Financiera</td>
    <td width="93" align="center">ST</td>
    <td width="93" align="center">Saldo Inicial</td>
    <td width="97" align="center">Total de Ingresos</td>
    <td width="89" align="center">Total de Egresos</td>
    <td width="89" align="center">Disponibilidad Financiera</td>
    <td width="93" align="center">ST</td>
    <td width="93" align="center">Saldo Inicial</td>
    <td width="97" align="center">Total de Ingresos</td>
    <td width="89" align="center">Total de Egresos</td>
    <td width="89" align="center">Disponibilidad Financiera</td>
    <td width="93" align="center">ST</td>
    <td width="93" align="center">Saldo Inicial</td>
    <td width="97" align="center">Total de Ingresos</td>
    <td width="89" align="center">Total de Egresos</td>
    <td width="89" align="center">Disponibilidad Financiera</td>
  </tr>
  <cfoutput>
  <cfset non=true>
  <cfloop query="Entidad" startrow="1">
    <cfquery name="Monto_asignado" dbtype="query">
      select Trim_Captura,Trim_CapturaT,Recurso_asignado,Status_Trim1,Status_Trim2,Status_Trim3,Status_Trim4 from Prog_EntFed where id_Prog=#Id_Prog# and Id_EntFed=#Entidad.Id_EntFed#
    </cfquery>
        
    <cfquery name="Saldo_Inicial" dbtype="query">
    	select monto1,monto2,monto3,monto4 from montos where Id_Rubro=1 and Id_Entfed=#Entidad.Id_Entfed#
    </cfquery>
    <cfquery name="Ingresos" dbtype="query">
    	select sum (monto1) as Monto1, sum (monto2) as Monto2, sum (monto3) as Monto3, sum (monto4) as Monto4  from montos where Id_Rubro > 1 and Id_Rubro < 5 and Id_Entfed = #Entidad.Id_Entfed#
    </cfquery>
    <cfquery name="Egresos" dbtype="query">
    	select sum (monto1) as Monto1, sum (monto2) as Monto2, sum (monto3) as Monto3, sum (monto4) as Monto4 from montos where Id_Rubro > 4 and Id_Rubro <= #Num_Egresos# and Id_Entfed = #Entidad.Id_Entfed#
    </cfquery>
    <!--- Se omiten las entidades con recursos cero --->
	<cfif #Monto_asignado.Recurso_asignado# GT 0>
    	<cfset non= not(#non#)>    
        <tr align="right" <cfif non><cfoutput> class="custom_tr"</cfoutput></cfif>>
        <td align="left">
            <a href="itaf_cap.cfm?Id_EntFed=#Entidad.Id_EntFed#">#Entidad.EntFed#</a>
        </td>
        <td>#NumberFormat( Monto_asignado.Recurso_asignado, "," )#</td>
        
          <cfset SI1= #Saldo_Inicial.Monto1#>
          <cfset I1=#Ingresos.Monto1#>
          <cfset E1=#Egresos.Monto1#>
          <cfset DF1= #val(SI1)# + #val(I1)# - #val(E1)#>
          <cfset SI2= #Saldo_Inicial.Monto2#>
          <cfset I2=#Ingresos.Monto2#>
          <cfset E2=#Egresos.Monto2#>
          <cfset DF2= #val(SI2)# + #val(I2)# - #val(E2)#>
          <cfset SI3= #Saldo_Inicial.Monto3#>
          <cfset I3=#Ingresos.Monto3#>
          <cfset E3=#Egresos.Monto3#>
          <cfset DF3= #val(SI3)# + #val(I3)# - #val(E3)#>
          <cfset SI4= #Saldo_Inicial.Monto4#>
          <cfset I4=#Ingresos.Monto4#>
          <cfset E4=#Egresos.Monto4#>
          <cfset DF4= #val(SI4)# + #val(I4)# - #val(E4)#>

		<!---                        1ER TRIMESTRE   FINANCIERO                        --->
        <td width="93" align="center">
        	<cfset azul = "azul">
        	<cfset amarillo = "amarillo">
            <cfset verde = "verde">
            <cfset rojo = "rojo">
            <cfset validando = "validando">
            <cfset enviar = "enviar">
            
            <cfquery name="qry_financiero" datasource="prafipp">
                SELECT	*
                FROM	Cargas
                WHERE	Id_Prog=#SESSION.Id_Prog#
                AND Num_Arch>0
                AND		Id_EntFed=#Entidad.Id_Entfed#
                AND		Trim_Captura=1
                AND		Tipo in ('InformeFinanciero','EstadoCuenta','ReintegroTesoreria','ReciboInstitucional')
            </cfquery>
            <cfif #qry_financiero.RecordCount# GT 0 >
            	<cfset azul = #azul# & "F">
            	<cfset amarillo = #amarillo# & "F">
                <cfset verde = #verde# & "F">
                <cfset rojo = #rojo# & "F">
                <cfset validando = #validando# & "F">
                <cfset enviar = #enviar# & "F">
            </cfif>
            <cfset azul = #azul# & ".png">
            <cfset amarillo = #amarillo# & ".png">
            <cfset verde = #verde# & ".png">
            <cfset rojo = #rojo# & ".png">
            <cfset validando = #validando# & ".png">
            <cfset enviar = #enviar# & ".png">

            <cfset estatus=#Monto_asignado.Status_Trim1#\10>
            <!---cfoutput>estatus=#estatus#</cfoutput></br>
			<cfoutput>Monto_asignado.Trim_Captura=#Monto_asignado.Trim_Captura#</cfoutput></br>
			<cfoutput>SESSION.Rol=#SESSION.Rol#</cfoutput></br--->
            <cfif (#estatus# EQ 6) AND (#Monto_asignado.Trim_Captura# EQ 1) AND (#find("4",SESSION.Rol)# GT 0)>
				<cfset enlace = "cmb_statusFin.cfm?Id_Entfed=#Entidad.Id_Entfed#&Trim_Captura=1&DF=#DF1#&Status_Trim2=#Monto_asignado.Status_Trim2#"/>
                <!---a href='#enlace#' title='Cambiar estatus' target='_blank' class='enlace_imagen' onclick="return confirmar('Esta acci\u00F3n cambiar\u00E1 el estatus a \nCumple al 100% y abrir\u00E1 el siguiente trimestre')"--->
                <a href='#enlace#' title='Cambiar estatus' target='_blank' class='enlace_imagen' onclick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;">
            </cfif>
            <cfoutput>
            <img
              <cfswitch expression="#estatus#">
               <cfcase value="1">
                src="img/#azul#"
               </cfcase>
               <cfcase value="2">
                src="img/#amarillo#" 
               </cfcase>
               <cfcase value="3">
                src="img/#verde#" 
               </cfcase>
               <cfcase value="4">
                src="img/#rojo#" 
               </cfcase>
               <cfcase value="5">
                src="img/#validando#" 
               </cfcase>
               <cfcase value="6">
                src="img/#enviar#" 
               </cfcase>
               <cfdefaultcase>
                src="img/#azul#"
               </cfdefaultcase>
              </cfswitch>
            width="14" height="14" border="0"/></cfoutput><cfif (#estatus# EQ 6) AND (#Monto_asignado.Trim_Captura# EQ 1) AND (#find("4",SESSION.Rol)# GT 0)></a></cfif>
            
            <!---                        1ER TRIMESTRE   TECNICO                           --->
            <cfset azul = "azul">
        	<cfset amarillo = "amarillo">
            <cfset verde = "verde">
            <cfset rojo = "rojo">
            <cfset validando = "validando">
            <cfset enviar = "enviar">            
            <cfquery name="qry_tecnico" datasource="prafipp">
                SELECT	Num_Arch
                FROM	Cargas
                WHERE	Id_Prog=#SESSION.Id_Prog#
                AND		Id_EntFed=#Entidad.Id_Entfed#
                AND		Trim_Captura=1
                AND		Tipo='InformeTecnico'
            </cfquery>
            <cfif #qry_tecnico.RecordCount# GT 0 >
            	<cfset azul = #azul# & "T">
            	<cfset amarillo = #amarillo# & "T">
                <cfset verde = #verde# & "T">
                <cfset rojo = #rojo# & "T">
                <cfset validando = #validando# & "T">
                <cfset enviar = #enviar# & "T">
            </cfif>            
            <cfset azul = #azul# & ".png">
            <cfset amarillo = #amarillo# & ".png">
            <cfset verde = #verde# & ".png">
            <cfset rojo = #rojo# & ".png">
            <cfset validando = #validando# & ".png">
            <cfset enviar = #enviar# & ".png">            

			<cfset estatus=#Monto_asignado.Status_Trim1# mod 10>			
            <cfif (#estatus# EQ 6) AND (#Monto_asignado.Trim_CapturaT# EQ 1) AND (#find("6",SESSION.Rol)# GT 0)>
              <cfset enlace = "cmb_statusTec.cfm?Id_Entfed=#Entidad.Id_Entfed#&Trim_Captura=1&Status_Trim2=#Monto_asignado.Status_Trim2#"/>
                <!---a href='#enlace#' title='Cambiar estatus' target='_blank' class='enlace_imagen' onclick="return confirmar('Esta acci\u00F3n cambiar\u00E1 el estatus t\u00E9cnico a \nCumple al 100% y abrir\u00E1 el siguiente trimestre')"--->
                <a href='#enlace#' title='Cambiar estatus' target='_blank' class='enlace_imagen' onclick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;">
            </cfif>
            <cfoutput>
            <img 
              <cfswitch expression="#Monto_asignado.Status_Trim1 MOD 10#">
               <cfcase value="1">
                src="img/#azul#"
               </cfcase>
               <cfcase value="2">
                src="img/#amarillo#" 
               </cfcase>
               <cfcase value="3">
                src="img/#verde#" 
               </cfcase>
               <cfcase value="4">
                src="img/#rojo#" 
               </cfcase>
               <cfcase value="5">
                src="img/#validando#" 
               </cfcase>
               <cfcase value="6">
                src="img/#enviar#" 
               </cfcase>  
               <cfdefaultcase>
                src="img/#azul#" 
               </cfdefaultcase>
              </cfswitch>
            width="14" height="14" border="0"/></cfoutput><cfif (#estatus# EQ 6) AND (#Monto_asignado.Trim_CapturaT# EQ 1) AND (#find("4",SESSION.Rol)# GT 0)></a></cfif>
			

        </td>
        <td >#NumberFormat( SI1, "," )#</td>
        <td >#NumberFormat( I1, "," )#</td>
        <td >#NumberFormat( E1, "," )#</td>
        <td >#NumberFormat( DF1, "," )#</td>
        
        
        <!---                        2O  TRIMESTRE   FINANCIERO                        --->
        <td width="93" align="center">
        	<cfset azul = "azul">
        	<cfset amarillo = "amarillo">
            <cfset verde = "verde">
            <cfset rojo = "rojo">
            <cfset validando = "validando">
            <cfset enviar = "enviar">
            
            <cfquery name="qry_financiero" datasource="prafipp">
                SELECT	*
                FROM	Cargas
                WHERE	Id_Prog=#SESSION.Id_Prog#
                AND Num_Arch>0
                AND		Id_EntFed=#Entidad.Id_Entfed#
                AND		Trim_Captura=2
                AND		Tipo in ('InformeFinanciero','EstadoCuenta','ReintegroTesoreria','ReciboInstitucional')
            </cfquery>
            <cfif #qry_financiero.RecordCount# GT 0 >
            	<cfset azul = #azul# & "F">
            	<cfset amarillo = #amarillo# & "F">
                <cfset verde = #verde# & "F">
                <cfset rojo = #rojo# & "F">
                <cfset validando = #validando# & "F">
                <cfset enviar = #enviar# & "F">
            </cfif>
            <cfset azul = #azul# & ".png">
            <cfset amarillo = #amarillo# & ".png">
            <cfset verde = #verde# & ".png">
            <cfset rojo = #rojo# & ".png">
            <cfset validando = #validando# & ".png">
            <cfset enviar = #enviar# & ".png">        
            <cfset estatus=#Monto_asignado.Status_Trim2#\10>
            <cfif (#estatus# EQ 6) AND (#Monto_asignado.Trim_Captura# EQ 2) AND (#find("4",SESSION.Rol)# GT 0)>
				<cfset enlace = "cmb_statusFin.cfm?Id_Entfed=#Entidad.Id_Entfed#&Trim_Captura=2&DF=#DF2#&Status_Trim3=#Monto_asignado.Status_Trim3#"/>
                <a href='#enlace#' title='Cambiar estatus' target='_blank' class='enlace_imagen' onclick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;">
            </cfif>
            <cfoutput>
        	<img 
              <cfswitch expression="#estatus#">
               <cfcase value="1">
                src="img/#azul#" 
               </cfcase>
               <cfcase value="2">
                src="img/#amarillo#" 
               </cfcase>
               <cfcase value="3">
                src="img/#verde#"  
               </cfcase>
               <cfcase value="4">
                src="img/#rojo#" 
               </cfcase>
               <cfcase value="5">
                src="img/#validando#" 
               </cfcase>
               <cfcase value="6">
                src="img/#enviar#" 
               </cfcase>                                  
               <cfdefaultcase>
                src="img/#azul#" 
               </cfdefaultcase>
              </cfswitch>
            width="14" height="14" border="0"/></cfoutput><cfif (#estatus# EQ 6) AND (#Monto_asignado.Trim_Captura# EQ 2) AND (#find("4",SESSION.Rol)# GT 0)> </a> </cfif>

            
            <!---                        2O  TRIMESTRE   TECNICO                           --->
            <cfset azul = "azul">
        	<cfset amarillo = "amarillo">
            <cfset verde = "verde">
            <cfset rojo = "rojo">
            <cfset validando = "validando">
            <cfset enviar = "enviar">            
            <cfquery name="qry_tecnico" datasource="prafipp">
                SELECT	Num_Arch
                FROM	Cargas
                WHERE	Id_Prog=#SESSION.Id_Prog#
                AND		Id_EntFed=#Entidad.Id_Entfed#
                AND		Trim_Captura=2
                AND		Tipo='InformeTecnico'
            </cfquery>
            <cfif #qry_tecnico.RecordCount# GT 0 >
            	<cfset azul = #azul# & "T">
            	<cfset amarillo = #amarillo# & "T">
                <cfset verde = #verde# & "T">
                <cfset rojo = #rojo# & "T">
                <cfset validando = #validando# & "T">
                <cfset enviar = #enviar# & "T">
            </cfif>
            <cfset azul = #azul# & ".png">
            <cfset amarillo = #amarillo# & ".png">
            <cfset verde = #verde# & ".png">
            <cfset rojo = #rojo# & ".png">
            <cfset validando = #validando# & ".png">
            <cfset enviar = #enviar# & ".png"> 
			<cfset estatus=#Monto_asignado.Status_Trim2# mod 10>
            <cfif (#estatus# EQ 6) AND (#Monto_asignado.Trim_CapturaT# EQ 2) AND (#find("6",SESSION.Rol)# GT 0)>
				<cfset enlace = "cmb_statusTec.cfm?Id_Entfed=#Entidad.Id_Entfed#&Trim_Captura=2&Status_Trim3=#Monto_asignado.Status_Trim3#"/>
                <a href='#enlace#' title='Cambiar estatus' target='_blank' class='enlace_imagen' onclick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;">
            </cfif> 
            <cfoutput>           
            <img 
              <cfswitch expression="#Monto_asignado.Status_Trim2 mod 10#">
               <cfcase value="1">
                src="img/#azul#" 
               </cfcase>
               <cfcase value="2">
                src="img/#amarillo#" 
               </cfcase>
               <cfcase value="3">
                src="img/#verde#" 
               </cfcase>
               <cfcase value="4">
                src="img/#rojo#" 
               </cfcase>
               <cfcase value="5">
                src="img/#validando#" 
               </cfcase>
               <cfcase value="6">
                src="img/#enviar#" 
               </cfcase>                                  
               <cfdefaultcase>
                src="img/#azul#"
               </cfdefaultcase>
              </cfswitch>
            width="14" height="14" border="0"/></cfoutput><cfif (#estatus# EQ 6) AND (#Monto_asignado.Trim_CapturaT# EQ 2) AND (#find("4",SESSION.Rol)# GT 0)> </a> </cfif>
        </td>
        <td >#NumberFormat( SI2, "," )#</td>
        <td >#NumberFormat( I2, "," )#</td>
        <td >#NumberFormat( E2, "," )#</td>
        <td >#NumberFormat( DF2, "," )#</td>
        
        
        <!---                        3R  TRIMESTRE   FINANCIERO                        --->
		<td width="93" align="center">
        	<cfset azul = "azul">
        	<cfset amarillo = "amarillo">
            <cfset verde = "verde">
            <cfset rojo = "rojo">
            <cfset validando = "validando">
            <cfset enviar = "enviar">
            
            <cfquery name="qry_financiero" datasource="prafipp">
                SELECT	*
                FROM	Cargas
                WHERE	Id_Prog=#SESSION.Id_Prog#
                AND Num_Arch>0
                AND		Id_EntFed=#Entidad.Id_Entfed#
                AND		Trim_Captura=3
                AND		Tipo in ('InformeFinanciero','EstadoCuenta','ReintegroTesoreria','ReciboInstitucional')
            </cfquery>
            <cfif #qry_financiero.RecordCount# GT 0 >
            	<cfset azul = #azul# & "F">
            	<cfset amarillo = #amarillo# & "F">
                <cfset verde = #verde# & "F">
                <cfset rojo = #rojo# & "F">
                <cfset validando = #validando# & "F">
                <cfset enviar = #enviar# & "F">
            </cfif>
            <cfset azul = #azul# & ".png">
            <cfset amarillo = #amarillo# & ".png">
            <cfset verde = #verde# & ".png">
            <cfset rojo = #rojo# & ".png">
            <cfset validando = #validando# & ".png">
            <cfset enviar = #enviar# & ".png">     
        
            <cfset estatus=#Monto_asignado.Status_Trim3#\10>
            <cfif (#estatus# EQ 6) AND (#Monto_asignado.Trim_Captura# EQ 3) AND (#find("4",SESSION.Rol)# GT 0)>
				<cfset enlace = "cmb_statusFin.cfm?Id_Entfed=#Entidad.Id_Entfed#&Trim_Captura=3&DF=#DF3#&Status_Trim4=#Monto_asignado.Status_Trim4#"/>
                <a href='#enlace#' title='Cambiar estatus' target='_blank' class='enlace_imagen' onclick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;">
            </cfif>    
            <cfoutput>    
        	<img 
              <cfswitch expression="#estatus#">
               <cfcase value="1">
                src="img/#azul#"
               </cfcase>
               <cfcase value="2">
                src="img/#amarillo#"
               </cfcase>
               <cfcase value="3">
                src="img/#verde#" 
               </cfcase>
               <cfcase value="4">
                src="img/#rojo#" 
               </cfcase>
               <cfcase value="5">
                src="img/#validando#" 
               </cfcase>
               <cfcase value="6">
                src="img/#enviar#"
               </cfcase>                                  
               <cfdefaultcase>
                src="img/#azul#"
               </cfdefaultcase>
              </cfswitch>
            width="14" height="14" border="0"/></cfoutput><cfif (#estatus# EQ 6) AND (#Monto_asignado.Trim_Captura# EQ 3) AND (#find("4",SESSION.Rol)# GT 0)> </a> </cfif>

            
            <!---                        3R  TRIMESTRE   TECNICO                           --->
            <cfset azul = "azul">
        	<cfset amarillo = "amarillo">
            <cfset verde = "verde">
            <cfset rojo = "rojo">
            <cfset validando = "validando">
            <cfset enviar = "enviar">            
            <cfquery name="qry_tecnico" datasource="prafipp">
                SELECT	Num_Arch
                FROM	Cargas
                WHERE	Id_Prog=#SESSION.Id_Prog#
                AND		Id_EntFed=#Entidad.Id_Entfed#
                AND		Trim_Captura=3
                AND		Tipo='InformeTecnico'
            </cfquery>
            <cfif #qry_tecnico.RecordCount# GT 0 >
            	<cfset azul = #azul# & "T">
            	<cfset amarillo = #amarillo# & "T">
                <cfset verde = #verde# & "T">
                <cfset rojo = #rojo# & "T">
                <cfset validando = #validando# & "T">
                <cfset enviar = #enviar# & "T">
            </cfif>
            <cfset azul = #azul# & ".png">
            <cfset amarillo = #amarillo# & ".png">
            <cfset verde = #verde# & ".png">
            <cfset rojo = #rojo# & ".png">
            <cfset validando = #validando# & ".png">
            <cfset enviar = #enviar# & ".png"> 
            
			<cfset estatus=#Monto_asignado.Status_Trim3# mod 10>
            <cfif (#estatus# EQ 6) AND (#Monto_asignado.Trim_CapturaT# EQ 3) AND (#find("6",SESSION.Rol)# GT 0)>
				<cfset enlace = "cmb_statusTec.cfm?Id_Entfed=#Entidad.Id_Entfed#&Trim_Captura=3&Status_Trim4=#Monto_asignado.Status_Trim4#"/>
                <a href='#enlace#' title='Cambiar estatus' target='_blank' class='enlace_imagen' onclick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;">
            </cfif>
            <cfoutput>
            <img 
              <cfswitch expression="#Monto_asignado.Status_Trim3 mod 10#">
               <cfcase value="1">
                src="img/#azul#"
               </cfcase>
               <cfcase value="2">
                src="img/#amarillo#" 
               </cfcase>
               <cfcase value="3">
                src="img/#verde#" 
               </cfcase>
               <cfcase value="4">
                src="img/#rojo#" 
               </cfcase>
               <cfcase value="5">
                src="img/#validando#" 
               </cfcase>
               <cfcase value="6">
                src="img/#enviar#" 
               </cfcase>                                  
               <cfdefaultcase>
                src="img/#azul#"
               </cfdefaultcase>
              </cfswitch>
            width="14" height="14" border="0"/></cfoutput><cfif (#estatus# EQ 6) AND (#Monto_asignado.Trim_CapturaT# EQ 3) AND (#find("4",SESSION.Rol)# GT 0)> </a> </cfif>
        </td>
        <td >#NumberFormat( SI3, "," )#</td>
        <td >#NumberFormat( I3, "," )#</td>
        <td >#NumberFormat( E3, "," )#</td>
        <td >#NumberFormat( DF3, "," )#</td>
        
        
        <!---                        4O  TRIMESTRE   FINANCIERO                        --->
        <td width="93" align="center">
        	<cfset azul = "azul">
        	<cfset amarillo = "amarillo">
            <cfset verde = "verde">
            <cfset rojo = "rojo">
            <cfset validando = "validando">
            <cfset enviar = "enviar">
            
            <cfquery name="qry_financiero" datasource="prafipp">
                SELECT	*
                FROM	Cargas
                WHERE	Id_Prog=#SESSION.Id_Prog#
                AND Num_Arch>0
                AND		Id_EntFed=#Entidad.Id_Entfed#
                AND		Trim_Captura=4
                AND		Tipo in ('InformeFinanciero','EstadoCuenta','ReintegroTesoreria','ReciboInstitucional')
            </cfquery>
            <cfif #qry_financiero.RecordCount# GT 0 >
            	<cfset azul = #azul# & "F">
            	<cfset amarillo = #amarillo# & "F">
                <cfset verde = #verde# & "F">
                <cfset rojo = #rojo# & "F">
                <cfset validando = #validando# & "F">
                <cfset enviar = #enviar# & "F">
            </cfif>
            <cfset azul = #azul# & ".png">
            <cfset amarillo = #amarillo# & ".png">
            <cfset verde = #verde# & ".png">
            <cfset rojo = #rojo# & ".png">
            <cfset validando = #validando# & ".png">
            <cfset enviar = #enviar# & ".png">
      
            <cfset estatus=#Monto_asignado.Status_Trim4#\10>
            <cfif (#estatus# EQ 6) AND (#Monto_asignado.Trim_Captura# EQ 4) AND (#find("4",SESSION.Rol)# GT 0)>
				<cfset enlace = "cmb_statusFin.cfm?Id_Entfed=#Entidad.Id_Entfed#&Trim_Captura=4&DF=#DF4#"/>
                <a href='#enlace#' title='Cambiar estatus' target='_blank' class='enlace_imagen' onclick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;')">
            </cfif>
            <cfoutput>
        	<img 
              <cfswitch expression="#estatus#">
               <cfcase value="1">
                src="img/#azul#" 
               </cfcase>
               <cfcase value="2">
                src="img/#amarillo#"
               </cfcase>
               <cfcase value="3">
                src="img/#verde#" 
               </cfcase>
               <cfcase value="4">
                src="img/#rojo#" 
               </cfcase>
               <cfcase value="5">
                src="img/#validando#"  
               </cfcase>
               <cfcase value="6">
                src="img/#enviar#" 
               </cfcase>                                  
               <cfdefaultcase>
                src="img/#azul#"
               </cfdefaultcase>
              </cfswitch>
            width="14" height="14" border="0"/></cfoutput><cfif (#estatus# EQ 6) AND (#Monto_asignado.Trim_Captura# EQ 4) AND (#find("4",SESSION.Rol)# GT 0)> </a> </cfif>



			<!---                        4O  TRIMESTRE   TECNICO                           --->
            <cfset azul = "azul">
        	<cfset amarillo = "amarillo">
            <cfset verde = "verde">
            <cfset rojo = "rojo">
            <cfset validando = "validando">
            <cfset enviar = "enviar">            
            <cfquery name="qry_tecnico" datasource="prafipp">
                SELECT	Num_Arch
                FROM	Cargas
                WHERE	Id_Prog=#SESSION.Id_Prog#
                AND		Id_EntFed=#Entidad.Id_Entfed#
                AND		Trim_Captura=4
                AND		Tipo='InformeTecnico'
            </cfquery>
            <cfif #qry_tecnico.RecordCount# GT 0 >
            	<cfset azul = #azul# & "T">
            	<cfset amarillo = #amarillo# & "T">
                <cfset verde = #verde# & "T">
                <cfset rojo = #rojo# & "T">
                <cfset validando = #validando# & "T">
                <cfset enviar = #enviar# & "T">
            </cfif>
            <cfset azul = #azul# & ".png">
            <cfset amarillo = #amarillo# & ".png">
            <cfset verde = #verde# & ".png">
            <cfset rojo = #rojo# & ".png">
            <cfset validando = #validando# & ".png">
            <cfset enviar = #enviar# & ".png"> 
            
			<cfset estatus=#Monto_asignado.Status_Trim4# mod 10>
            <cfif (#estatus# EQ 6) AND (#Monto_asignado.Trim_CapturaT# EQ 4) AND (#find("6",SESSION.Rol)# GT 0)>
				<cfset enlace = "cmb_statusTec.cfm?Id_Entfed=#Entidad.Id_Entfed#&Trim_Captura=4"/>
                <a href='#enlace#' title='Cambiar estatus' target='_blank' class='enlace_imagen' onclick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=550,height=310,left = 387,top = 259'); return false;')">
            </cfif>
            <cfoutput>
            <img 
              <cfswitch expression="#Monto_asignado.Status_Trim4 mod 10#">
               <cfcase value="1">
                src="img/#azul#"
               </cfcase>
               <cfcase value="2">
                src="img/#amarillo#" 
               </cfcase>
               <cfcase value="3">
                src="img/#verde#" 
               </cfcase>
               <cfcase value="4">
                src="img/#rojo#" 
               </cfcase>
               <cfcase value="5">
                src="img/#validando#" 
               </cfcase>
               <cfcase value="6">
                src="img/#enviar#" 
               </cfcase>                                  
               <cfdefaultcase>
                src="img/#azul#"
               </cfdefaultcase>
              </cfswitch>
            width="14" height="14" border="0"/></cfoutput><cfif (#estatus# EQ 6) AND (#Monto_asignado.Trim_CapturaT# EQ 4) AND (#find("4",SESSION.Rol)# GT 0)> </a> </cfif>
        </td>
        <td >#NumberFormat( SI4, "," )#</td>
        <td >#NumberFormat( I4, "," )#</td>
        <td >#NumberFormat( E4, "," )#</td>
        <td >#NumberFormat( DF4, "," )#</td>
      </tr>
  </cfif>
  <!--- Se omiten las entidades con recursos cero --->
  </cfloop>
  </cfoutput>
</table>
</td></tr>
</table>
<br />
<table width="1100 px">
  <tr class="colfooter">
    <td align="center"><p>Nomenclatura</p></td>
    <td align="center">entregado <img src="img/verde.png" width="14" height="14" alt="entregado" /></td>
    <td align="center">en proceso <img src="img/amarillo.png" width="14" height="14" alt="en proceso" /></td>
    <td align="center">vencido <img src="img/rojo.png" width="14" height="14" alt="vencido" /></td>
    <td align="center">programado <img src="img/azul.gif" width="14" height="14" alt="programado" /></td>
  </tr>
</table> 
<table align="center" border="0" cellspacing="0" cellpadding="0" width="975">
<tr><td>
<img src="img/footer.jpg" width="975" height="23" alt="footer" />
</td></tr>
</table>

</body>
</html>