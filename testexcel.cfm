<cfquery name="queryData" datasource="prafipp">
SELECT * 
FROM montos
</cfquery>

<body>

<cfheader name="Content-Disposition" 
value="inline; filename=Employee_Report.xls">
<cfcontent type="application/vnd.ms-excel">



<table border="2">
<tr>
<td> ID </td><td> Name </td>
</tr>
 <cfoutput query="queryData">
<tr>
<td>#Id_rubro#</td><td>#Monto1#</td> 
</tr>
</cfoutput>
</table>

</cfcontent>
</body>