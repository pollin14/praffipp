<cfapplication name="prafipp" sessionmanagement="yes">
<title>PRAFIPP Selecci&oacute;n de Unidades Responsables</title>
<link rel="stylesheet" type="text/css" href="css/prafipp.css">
</style>
</head>
<script type="text/javascript" language="javascript" src="js/func.js">
</script>

<body>
<table align="center" border="0" cellspacing="0" cellpadding="0" width="975">
  <tr><td><img src="img/header.jpg" width="975" height="90" alt="Encabezado" /></td></tr>
</table>

<cfinclude template="chk_session.cfm">

<cfif #SESSION.rol# GT 6>
	<cfif #find(",",SESSION.Id_Prog)# GT 0>
    	<cfoutput><cflocation url="programas.cfm?ur=#SESSION.ur#"></cfoutput>
    <cfelse>
    	<cfoutput><cflocation url="itaf_cap.cfm?Id_EntFed=#SESSION.Id_EntFed#"></cfoutput>
	</cfif>
</cfif>

<cfif #SESSION.rol# GT 4>
	<cfoutput>
      <cflocation url="colorama.cfm?Id_Prog=#SESSION.Id_Prog#">
    </cfoutput>
</cfif>
<cfif #SESSION.rol# GT 2>
	<cfoutput>
      <cflocation url="programas_graph.cfm?ur=310">
    </cfoutput>
</cfif>
<table align="center" border="0" cellspacing="0" cellpadding="0" width="968">
<tr><td width="135">
  <td width="968" height="700" valign="top">
<table width="950" border="0" align="center" cellpadding="0" cellspacing="2">
  <col width="198" />
  <col width="80" span="4" />
  <tr>
    <td height="27" colspan="6" align="center">
      <h2 class="colheader"><strong>Unidades Responsables UR&acute;s</strong></h2>
    </td>
  </tr>
  <tr class="colfooter">
    <td width="600" align="center" class="colfooter">Denominaci&oacute;n</td>
    <td width="80" align="center">Clave SEP</td>
    <td width="80" align="center">Siglas</td>
    <td width="80" align="center">Clave SHCP</td>
    <td width="80" align="center">Programas</td>
    <td width="80" align="center">Monto</td>
  </tr>
 <cfquery name="ur" datasource="prafipp">
       select * from ur
 </cfquery>
<cfquery name="programas" datasource="prafipp">
	select * from programas
</cfquery>
 <cfset non=true>
 <cfoutput query="ur" startrow="1" >
  <tr <cfif non><cfoutput> class="custom_tr"</cfoutput></cfif>>
    <cfquery name="Num_Progs"  dbtype="query">
    	select count(distinct(id_mainprog)) as cuenta from programas where Id_Ur like '#trim(Id_SEP)#'
    </cfquery>
    <td> 
    <cfif #Num_Progs.cuenta# GT 0 >
    <a href="programas_graph.cfm?ur=#Id_SEP#" title="Clic aqu&iacute; para ver los Programas y Proyectos asociados"
 >#Denominacion#</a>
 	<cfelse>#Denominacion#
 	</cfif>
    </td>
    <td align="right" >#Id_SEP#</td>
    <td  align="right">#Siglas#</td>
    <td align="right">#Id_SHCP#</td>
    <cfquery name="Num_Progs"  dbtype="query">
    	select count(distinct(id_mainprog)) as cuenta from programas where Id_Ur like '#trim(Id_SEP)#'
    </cfquery>
    <td width="80" align="center">#NumberFormat( Num_Progs.cuenta, "," )#</td>
    <cfquery name="Montos" dbtype="query">
    	select sum(monto) as monto from programas where Id_Ur like '#trim(Id_SEP)#'
    </cfquery>
    <td width="80" align="center">#NumberFormat( Montos.monto, "," )#</td>
  </tr> 
  <cfset non= not(#non#)>
 </cfoutput> 
</table>
</td></tr>
</table>
<table align="center" border="0" cellspacing="0" cellpadding="0" width="975">
<tr><td>
<img src="img/footer.jpg" width="975" height="23" alt="footer" />
</td></tr>
</table>

</body>
</html>