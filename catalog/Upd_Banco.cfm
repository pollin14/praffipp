<cfquery name="qbancos" datasource="prafipp">  
 SELECT * FROM bancos  WHERE Id_Banco=2  
</cfquery>  
<cfdump var="#qbancos#">  
  
<cfquery name="qBancosUpdate" datasource="prafipp" result="BancosUpdate">  
 UPDATE Bancos SET Clave_Banco='30012', Nom_Banco='Swiss Bank'  
    WHERE Id_Banco=2  
</cfquery>  
<cfdump var="#qBancosUpdate#">  
<cfdump var="#BancosUpdate#">  
  
<cfquery name="qbancos" datasource="prafipp">  
 SELECT * FROM bancos  WHERE Id_Banco=2  
</cfquery>  

<cfdump var="#qbancos#">  