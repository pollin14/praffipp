  <tr <cfif non><cfoutput> class="custom_tr"</cfoutput></cfif>>
  <cfswitch expression="#Jerarquia#">
    <cfcase value = "s">
    <cfoutput group="Id_Prog">
        <td> <a href="colorama.cfm" title="Clic aquí para ver desglose nacional">---#Nom_Prog#</a></td>
        <td align="right" >#NumberFormat( Monto, "," )#</td>
    </cfoutput>
    </cfcase>    
    <cfcase value = "p">
    
  	<!---cfset qsec = "select sum(monto) as monto from programas where Id_MainProg=#Id_MainProg# and Jerarquia = "&chr(39)&"s"&chr(39)>
        <cfquery name="secundarios" datasource="prafipp">
            #qsec#
        </cfquery>
        <cfoutput query="secundarios" startrow="1" maxrows="1">
          <td align="right" >#NumberFormat( Monto, "," )#</td>
        </cfoutput--->
        
        <!---cfset qhijos = "select * from programas where Id_MainProg=#Id_MainProg# and Jerarquia = "&chr(39)&"s"&chr(39)>
        <cfoutput>#qhijos#</cfoutput>
        <cfquery name="hijos" dbtype="query">
        	#qhijos#
        </cfquery>
        <cfoutput query="hijos">
        	<cfset MontoP= #hijos.monto#>
        </cfoutput--->
        
        
        <td> #Nom_Prog#</td>
        <td align="right" >#NumberFormat( Monto, "," )#</td>
    </cfcase>
    <cfcase value = "u">
        <td> <a href="colorama.cfm" title="Clic aquí para ver desglose nacional">#Nom_Prog#</a></td>
        <td align="right" >#NumberFormat( Monto, "," )#</td>
    </cfcase>
    </cfswitch>
    <td  align="right">Y</td>
    <td align="right">%1</td>
    <td  align="right">X-Y</td>
    <td align="right">%2</td>
  </tr> 
  <cfset non= not(#non#)>
  <cfset total+=#monto#>
 </cfoutput> 
 <cfif #programas.RecordCount# eq 0>
 <cfoutput>
   <tr>
    <td colspan="6" align="center" class="custom_tr">No se han capturado proyectos para la UR #url.ur#</td>
  </tr>
