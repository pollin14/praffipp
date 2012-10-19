<cfapplication name="prafipp" sessionmanagement="yes">
<cfset SESSION.ur=#url.ur#>

<!---
<cfif #SESSION.rol# IS 8>
	<cfoutput>
      <cflocation url="itaf_cap.cfm?Id_EntFed=#SESSION.Id_EntFed#">
    </cfoutput>
</cfif>
--->

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
<table width="950" border="0" align="center" cellpadding="0" cellspacing="2">
  <col width="198" />
  <col width="80" span="4" />
  <tr>
    <td height="27" colspan="6" align="center">
      <h2 class="colheader"><strong>Programas y Proyectos SEB</strong></h2>
    </td>
  </tr>
  <tr>
    <td width="50%" rowspan="2" align="center" class="colfooter">2012</td>
    <td colspan="5" align="center" class="colfooter">Recursos</td>
  </tr>
  <tr class="colfooter">
    <td width="10%" align="center">Recurso federal asignado para el a&ntilde;o 2012</td>
    <td width="10%" align="center">Total  de Egresos</td>
    <td width="10%" align="center">%</td>
    <td width="10%" align="center">Disponibilidad Financiera</td>
    <td width="10%" align="center">%</td>
  </tr>
  
  
  
<cfquery name="programas" datasource="prafipp"> <!--- Programas y/o proyectos de la UR seleccionada ---->
    SELECT Programas.CP, Programas.Jerarquia, Programas.Id_MainProg, Programas.Id_Prog, Programas.Id_Ur, Programas.Nom_Prog, Programas.Num_Egresos, Programas.Num_Egresos_Pro, Sum(Prog_EntFed.Recurso_Asignado) AS monto
    FROM Programas INNER JOIN Prog_EntFed ON Programas.Id_Prog = Prog_EntFed.Id_Prog
    GROUP BY Programas.CP, Programas.Jerarquia, Programas.Id_MainProg, Programas.Id_Prog, Programas.Id_Ur, Programas.Nom_Prog, Programas.Num_Egresos, Programas.Num_Egresos_Pro, Prog_EntFed.Ejercicio, Programas.Id_Ur
    HAVING (((Prog_EntFed.Ejercicio)=#SESSION.ejercicio#) AND ((Programas.Id_Ur)=#SESSION.ur#))
</cfquery>


<cfif '#SESSION.Id_Prog2#' IS NOT ''>
	<cfset qry = "SELECT Id_MainProg,Id_Prog,Nom_Prog FROM programas WHERE Id_Prog in (#SESSION.Id_Prog#,#SESSION.Id_Prog2#) GROUP BY Id_MainProg,Id_Prog,Nom_Prog">
<cfelse>
	<cfset qry = "SELECT Id_MainProg,Id_Prog,Nom_Prog FROM programas WHERE Id_Prog = #SESSION.Id_Prog# GROUP BY Id_MainProg,Id_Prog,Nom_Prog">	
</cfif>
  
<cfquery name="Nom_Prog" dbtype="query"><!--- Solo los principales y únicos (descartamos secundarios)--->
    #qry#
</cfquery>



<!---cfoutput>
<cfset non=true> <!--- formato de renglones --->
<cfloop query="Nom_Prog">  
	<tr <cfif non><cfoutput> class="custom_tr"</cfoutput></cfif>>
		<td>#Nom_Prog.Nom_Prog#</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
    <cfset non= not(#non#)>
</cfloop>
</cfoutput--->
  
  
  
  
  
  

 <cfquery name="montos" datasource="prafipp"> <!--- eliminamos los respaldos --->
 	select * from montos where obsoleto=0
 </cfquery>
 
 <cfset non=true> <!--- formato de renglones ---> 
 
 <cfset total=0> 
 <cfset Sum_Egresos=0>
 <cfset Total_DF=0> <!--- Disponibilidad Financiera --->
 
<cfoutput>
  <cfloop query="Nom_Prog">
      <tr <cfif non><cfoutput> class="custom_tr"</cfoutput></cfif>>
		
		
        <cfquery name="hijos" dbtype="query"> <!--- obtenemos los programas secundarios --->
          select * from programas where Id_MainProg=#Nom_Prog.Id_MainProg# and Jerarquia='s'
        </cfquery>
        
        <cfquery name="Monto_H" dbtype="query">
          select sum(monto) as monto from programas where Id_MainProg=#Nom_Prog.Id_MainProg# 
        </cfquery>
        <cfquery name="Q_Jerarquia" dbtype="query">
           select Jerarquia,Num_Egresos from programas where Id_Prog=#Nom_Prog.Id_Prog# 
        </cfquery>
        <cfquery name="Egresos" dbtype="query">
            select sum (monto1) as Monto1, sum (monto2) as Monto2, sum (monto3) as Monto3, sum (monto4) as Monto4 from montos where Id_Rubro > 4 and Id_Rubro <= #Q_Jerarquia.Num_Egresos#+#SESSION.num_Ingresos# and Id_Prog=#Nom_Prog.Id_Prog#
        </cfquery>
        
        <td>
		  <cfif #Q_Jerarquia.Jerarquia# eq "u">
            <a href="itaf_cap.cfm?Id_EntFed=#SESSION.Id_EntFed#" title="Clic aquí para ver desglose nacional">#Nom_Prog.Nom_Prog#</a>
          	<cfset QTotal_Egresos = "select sum(monto1+monto2+monto3+monto4) as Total_Egresos from montos where Id_Prog=#Nom_Prog.Id_Prog# and obsoleto=0 and Id_Rubro > 4 and Id_Rubro <= #Q_Jerarquia.Num_Egresos#+#SESSION.num_Ingresos# and 2=2">
          <cfelse>
            <a href="itaf_cap.cfm?Id_EntFed=#SESSION.Id_EntFed#" title="Clic aquí para ver desglose nacional">#Nom_Prog.Nom_Prog#</a>
            <cfquery name="Lista_Hijos" dbtype="query">
                select Id_Prog from programas where Id_MainProg=#Nom_Prog.Id_MainProg# and jerarquia='s'
            </cfquery>
            

				<cfset Hijos_str="">
                <cfloop query="Lista_Hijos">
                  <cfset Hijos_str &=#Id_Prog#&','>            
                </cfloop>
                <cfset Hijos_str= #left(Hijos_str,len(Hijos_str)-1)#>
                <cfset Hijos_str='('&#Hijos_str#&')'>
                <cfset QTotal_Egresos = "select sum(monto1+monto2+monto3+monto4) as Total_Egresos from montos where Id_Prog in #Hijos_str# and obsoleto=0 and Id_Rubro > 4 and Id_Rubro <= #Q_Jerarquia.Num_Egresos#+#SESSION.num_Ingresos# and 3=3" >

            
          </cfif>
        </td>
        
        
        <td  align="right"><cfset RFA = #Monto_H.monto#>#NumberFormat( RFA, "," )#</td>
         
         
         
         <cfset total+=val(Monto_H.monto)>
        <td  align="right">
          <cfquery name="Total_Egresos" dbtype="query">
             #QTotal_Egresos#
           </cfquery>
          <cfset TE = #iif(Total_Egresos.Total_Egresos NEQ "",Total_Egresos.Total_Egresos,0)#>
          #NumberFormat( TE, "," )#
         <cfset Sum_Egresos += val(#TE#)>
        </td>
            <cfif #RFA# GT 0>
            	<cfset porc= #TE#/#RFA#*100>
            <cfelse>
            	<cfset porc = 0>
            </cfif>
        
        <!---cfset porc =#iif(RFA gt 0,TE/RFA,0)# * 100 --->
        <td align="right"> #Numberformat(porc,"999.99")# </td>
		  <cfset DF = VAL(RFA)-VAL(TE)>
        <td align="right">#NumberFormat( DF, "," )#</td>
		<!---cfset porc2=#iif(RFA gt 0,DF/RFA,0)# * 100 --->
            <cfif #RFA# GT 0>
            	<cfset porc2= #DF#/#RFA#*100>
            <cfelse>
            	<cfset porc2 = 0>
            </cfif>

        <td align="right"> #Numberformat(porc2,"999.99")#</td>
        <cfset non= not(#non#)>
      </tr> 
        <!---cfloop query="hijos">
            <tr <cfif non><cfoutput> class="custom_tr"</cfoutput></cfif>>
            <cfset non= not(#non#)>
            <td><a href="colorama.cfm?Id_Prog=#Hijos.Id_Prog#" title="Clic aquí para ver desglose nacional"> --#hijos.Nom_Prog#</a></td>
            <td  align="right">#NumberFormat( hijos.monto, "," )#</td>
            <!---cfset total+=hijos.monto--->
            <td  align="right">
            <cfquery name="Total_Egresos" dbtype="query">
              select sum(monto1+monto2+monto3+monto4) as Total_Egresos from montos where Id_Prog=#hijos.Id_Prog# and obsoleto=0 and Id_Rubro > 4 and Id_Rubro <= #Q_Jerarquia.Num_Egresos#+#SESSION.num_Ingresos# and 1=1
            </cfquery>
            <cfset TE = #iif(Total_Egresos.Total_Egresos NEQ "",Total_Egresos.Total_Egresos,0)#>
            #NumberFormat( TE, "," )#
            </td>
		    <!---cfset Sum_Egresos += #TE#--->
            <cfset RFA = iif(#hijos.monto# gt 0,#hijos.monto#,0)>
            <cfif #RFA# GT 0>
            	<cfset porc= #TE#/#RFA#*100>
            <cfelse>
            	<cfset porc = 0>
            </cfif>

			<!---cfset porc= iif(#RFA# GT 0,#TE#/#RFA#*100,0)---> 
            <td align="right">#Numberformat(porc,"999.99")#</td>
			  <cfset DF = #RFA#-#TE#>
              <cfif #RFA# GT 0>
                  <cfset porc2= #DF#/#RFA#*100>
              <cfelse>
                  <cfset porc2 = 0>
              </cfif>
              <!---cfset porc2=#iif(RFA gt 0,DF/RFA,0)# * 100 --->
            <td  align="right">#NumberFormat( DF, "," )#</td>
            <td align="right"> #Numberformat(porc2,"999.99")#</td>
           </tr> 
       </cfloop--->
  </cfloop>
</cfoutput> 











  <tr class="colheader">
    <td class="colheader"> Total</td>
    <cfoutput>
      <td class="colheader" align="right" >#NumberFormat( total, "," )#</td>
      <td class="colheader" align="right">#NumberFormat(Sum_Egresos , "," )#</td>
      <td class="colheader" align="right">#NumberFormat(Sum_Egresos/total*100 , "999.99" )#</td>
         <cfset Total_DF += #total#-#Sum_Egresos#>
      <td class="colheader" align="right">#NumberFormat(Total_DF , "," )#</td>
      <td class="colheader" align="right">#NumberFormat(Total_DF/total*100 , "999.99" )#</td>
	</cfoutput>
  </tr> 
</table>

<!---cfquery name="Mgraph" datasource="prafipp">
select id_mainprog,nom_prog, sum(monto) as monto from programas where jerarquia <> 'p' group by id_mainProg,nom_prog 
</cfquery>
<cfchart show3d="yes" title="Programas y Proyectos SEB" foregroundcolor="666666" gridlines="3" xaxistitle="Proyecto" yaxistitle="Monto" chartwidth="900" chartheight="400" showlegend="yes">
<cfchartseries type="bar" query="Mgraph" itemcolumn="nom_Prog" valuecolumn="monto" seriescolor="0066FF">
</cfchart--->

</td></tr>
</table>

<table align="center" border="0" cellspacing="0" cellpadding="0" width="975">
<tr><td>
<img src="img/footer.jpg" width="975" height="23" alt="footer" />
</td></tr>
</table>
</body>
</html>