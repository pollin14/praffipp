<cfapplication name="prafipp" sessionmanagement="yes">
<cfif #SESSION.rol# IS 8>
	<cfoutput>
      <cflocation url="itaf_cap.cfm?Id_EntFed=#SESSION.Id_EntFed#">
    </cfoutput>
</cfif>

<title>PRAFIPP, listado de Programas y Proyectos</title>
<link rel="stylesheet" type="text/css" href="css/prafipp.css">
</style>
</head>
<script type="text/javascript" language="javascript" src="js/func.js">
</script>

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
  <br />

<cfquery name="Mgraph" datasource="prafipp">
    <!--- select id_mainprog,nom_prog, sum(monto) as monto from programas where jerarquia <> 'p' group by id_mainProg,nom_prog  --->
SELECT Programas.Id_MainProg, Programas.Nom_Prog, Sum(Prog_EntFed.Recurso_Asignado) AS monto, Prog_EntFed.Ejercicio
FROM Prog_EntFed INNER JOIN Programas ON Prog_EntFed.Id_Prog = Programas.Id_Prog
GROUP BY Programas.Id_MainProg, Programas.Nom_Prog, Prog_EntFed.Ejercicio, Programas.Jerarquia
HAVING (((Prog_EntFed.Ejercicio)=#SESSION.Ejercicio#) AND ((Programas.Jerarquia)<>'p'))
</cfquery >


<cfchart url="programas.cfm?ur=#url.ur#" show3d="yes" title="Programas y Proyectos SEB" foregroundcolor="666666" gridlines="5" xaxistitle="Proyecto" yaxistitle="Monto" chartwidth="900" chartheight="700" showlegend="yes" sortxaxis="no">
<cfchartseries type="bar" query="Mgraph" itemcolumn="nom_Prog" valuecolumn="monto" seriescolor="F55F16">
</cfchart>

</td></tr>
</table>

<table align="center" border="0" cellspacing="0" cellpadding="0" width="975">
<tr><td>
<img src="img/footer.jpg" width="975" height="23" alt="footer" />
</td></tr>
</table>
</body>
</html>