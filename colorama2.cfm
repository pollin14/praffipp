<cfapplication name="prafipp" sessionmanagement="yes">
<cfset SESSION.Id_Prog=#url.Id_Prog#>
<cfset Id_Prog=#url.Id_Prog#>
<cfif #SESSION.rol# IS 8>
	<cfoutput>
      <cflocation url="itaf_cap.cfm?Id_EntFed=#SESSION.Id_EntFed#">
    </cfoutput>
</cfif>

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
      select Recurso_asignado,Status_Trim1,Status_Trim2,Status_Trim3,Status_Trim4 from Prog_EntFed where id_Prog=#Id_Prog# and Id_EntFed=#Entidad.Id_EntFed#
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

        <td width="93" align="center"><img 
              <cfswitch expression="#Monto_asignado.Status_Trim1\10#">
               <cfcase value="1">
                src="img/azul.png" 
               </cfcase>
               <cfcase value="2">
                src="img/amarillo.png" 
               </cfcase>
               <cfcase value="3">
                src="img/verde.png" 
               </cfcase>
               <cfcase value="4">
                src="img/rojo.png" 
               </cfcase>
               <cfdefaultcase>
                src="img/azul.png" 
               </cfdefaultcase>
              </cfswitch>
            width="14" height="14" />
            
            <img 
              <cfswitch expression="#Monto_asignado.Status_Trim1 MOD 10#">
               <cfcase value="1">
                src="img/azul.png" 
               </cfcase>
               <cfcase value="2">
                src="img/amarillo.png" 
               </cfcase>
               <cfcase value="3">
                src="img/verde.png" 
               </cfcase>
               <cfcase value="4">
                src="img/rojo.png" 
               </cfcase>
               <cfdefaultcase>
                src="img/azul.png" 
               </cfdefaultcase>
              </cfswitch>
            width="14" height="14" />

        </td>
        <td >#NumberFormat( SI1, "," )#</td>
        <td >#NumberFormat( I1, "," )#</td>
        <td >#NumberFormat( E1, "," )#</td>
        <td >#NumberFormat( DF1, "," )#</td>
    
        <td width="93" align="center"><img 
              <cfswitch expression="#Monto_asignado.Status_Trim2\10#">
               <cfcase value="1">
                src="img/azul.png" 
               </cfcase>
               <cfcase value="2">
                src="img/amarillo.png" 
               </cfcase>
               <cfcase value="3">
                src="img/verde.png" 
               </cfcase>
               <cfcase value="4">
                src="img/rojo.png" 
               </cfcase>
               <cfdefaultcase>
                src="img/azul.png" 
               </cfdefaultcase>
              </cfswitch>
            width="14" height="14" />
            <img 
              <cfswitch expression="#Monto_asignado.Status_Trim2 mod 10#">
               <cfcase value="1">
                src="img/azul.png" 
               </cfcase>
               <cfcase value="2">
                src="img/amarillo.png" 
               </cfcase>
               <cfcase value="3">
                src="img/verde.png" 
               </cfcase>
               <cfcase value="4">
                src="img/rojo.png" 
               </cfcase>
               <cfdefaultcase>
                src="img/azul.png" 
               </cfdefaultcase>
              </cfswitch>
            width="14" height="14" />
        </td>
        <td >#NumberFormat( SI2, "," )#</td>
        <td >#NumberFormat( I2, "," )#</td>
        <td >#NumberFormat( E2, "," )#</td>
        <td >#NumberFormat( DF2, "," )#</td>
        
    <cfset QupdateSI = "update montos set monto3=#DF2#  where Id_Prog=#Id_Prog# and Id_EntFed=#Entidad.Id_EntFed# and obsoleto=0 and Id_rubro=1">
<cfquery name="updateSI" datasource="prafipp">
	#QupdateSI#
</cfquery>
<!---cfoutput>
 #QupdateSI#
</cfoutput--->
    
        <td width="93" align="center"><img 
              <cfswitch expression="#Monto_asignado.Status_Trim3\10#">
               <cfcase value="1">
                src="img/azul.png" 
               </cfcase>
               <cfcase value="2">
                src="img/amarillo.png" 
               </cfcase>
               <cfcase value="3">
                src="img/verde.png" 
               </cfcase>
               <cfcase value="4">
                src="img/rojo.png" 
               </cfcase>
               <cfdefaultcase>
                src="img/azul.png" 
               </cfdefaultcase>
              </cfswitch>
            width="14" height="14" />
            
            <img 
              <cfswitch expression="#Monto_asignado.Status_Trim3 mod 10#">
               <cfcase value="1">
                src="img/azul.png" 
               </cfcase>
               <cfcase value="2">
                src="img/amarillo.png" 
               </cfcase>
               <cfcase value="3">
                src="img/verde.png" 
               </cfcase>
               <cfcase value="4">
                src="img/rojo.png" 
               </cfcase>
               <cfdefaultcase>
                src="img/azul.png" 
               </cfdefaultcase>
              </cfswitch>
            width="14" height="14" />
        </td>
        <td >#NumberFormat( SI3, "," )#</td>
        <td >#NumberFormat( I3, "," )#</td>
        <td >#NumberFormat( E3, "," )#</td>
        <td >#NumberFormat( DF3, "," )#</td>
    
        <td width="93" align="center"><img 
              <cfswitch expression="#Monto_asignado.Status_Trim4\10#">
               <cfcase value="1">
                src="img/azul.png" 
               </cfcase>
               <cfcase value="2">
                src="img/amarillo.png" 
               </cfcase>
               <cfcase value="3">
                src="img/verde.png" 
               </cfcase>
               <cfcase value="4">
                src="img/rojo.png" 
               </cfcase>
               <cfdefaultcase>
                src="img/azul.png" 
               </cfdefaultcase>
              </cfswitch>
            width="14" height="14" />
            
            <img 
              <cfswitch expression="#Monto_asignado.Status_Trim4 mod 10#">
               <cfcase value="1">
                src="img/azul.png" 
               </cfcase>
               <cfcase value="2">
                src="img/amarillo.png" 
               </cfcase>
               <cfcase value="3">
                src="img/verde.png" 
               </cfcase>
               <cfcase value="4">
                src="img/rojo.png" 
               </cfcase>
               <cfdefaultcase>
                src="img/azul.png" 
               </cfdefaultcase>
              </cfswitch>
            width="14" height="14" />
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