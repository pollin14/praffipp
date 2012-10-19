<cfparam name="Numero" default="1">
<cfparam name="Fecha" default="">
<cfparam name="Monto" default="0">
<cfparam name="Tiene_Recibo" default="0">
<cfparam name="F2" default=" ">
<cfparam name="clase" default="none">
<cfparam name="carga" default="">

<cfif #SESSION.Rol# EQ 4>
	<cfoutput>
      <tr class="#Attributes.clase#">
      <td align="center">#Attributes.Numero#</td>
      <td align="center">#Attributes.Fecha#</td>
      <td  align="right">#NumberFormat( Attributes.Monto, "," )#</td>
    <!---  <td align="center">
       <cfif #Attributes.Tiene_Recibo# eq 1>
        Si
      <cfelse>
        No
      </cfif></td>--->
      <td align="center">#Attributes.Tiene_Recibo#</td>  
      <td align="center">#Attributes.F2#</td>
      <td align="center">#Attributes.carga#</td>
    </tr>
    </cfoutput>
<cfelse>
	<cfoutput>
      <tr class="#Attributes.clase#">
      <td align="center">#Attributes.Numero#</td>
      <td align="center">#Attributes.Fecha#</td>
      <td  align="right">#NumberFormat( Attributes.Monto, "," )#</td>
    <!---  <td align="center">
       <cfif #Attributes.Tiene_Recibo# eq 1>
        Si
      <cfelse>
        No
      </cfif></td>--->
      <td align="center">#Attributes.Tiene_Recibo#</td>  
      <td align="center" colspan="2">#Attributes.F2#</td>
    </tr>
    </cfoutput>
</cfif>