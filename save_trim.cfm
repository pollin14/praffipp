<cfapplication name="prafipp" sessionmanagement="yes">
<cfinclude template="chk_session.cfm">



<cfquery name="inserta" datasource="prafipp">
 	update Prog_EntFed
 		set Responsable = '#EResponsable#', Elaboro = '#EElaboro#'
 		where Id_Prog = #SESSION.Id_Prog# and
 				Id_EntFed = #SESSION.Id_EntFed# and
 				Ejercicio = #SESSION.Ejercicio#
 	
</cfquery>				

<cffunction name="replaceSpecialChars" access="public" output="false" returntype="String">
    <cfargument name="textString" type="String" hint="String to have special characters replaced">
    <!--- If you would not like to remove spaces take the number 32 out of the list.--->
    <cfargument name="replaceTheseChars" type="String" default="39,44" required="false" hint="Characters to be replaced">
    <cfargument name="replaceWithChar" type="String" default="" required="no" hint="Character to replace special characters with.">
    <cfscript>
        var returnString = ARGUMENTS.textString;
        var i = 1;
        
        for(i=1; i <= listLen(ARGUMENTS.replaceTheseChars,','); i++){
            returnString = replace(returnString,chr(listGetAt(ARGUMENTS.replaceTheseChars,i)),ARGUMENTS.replaceWithChar,'all');
        }
    </cfscript>
    
    <cfreturn returnString />
</cffunction>

 <cfquery name="inserta" datasource="prafipp">
   select max(obsoleto) as Last_Obsoleto from Montos where Ejercicio=#SESSION.Ejercicio# and Id_Prog=#SESSION.Id_Prog# and Id_EntFed=#SESSION.Id_EntFed#;
 </cfquery>
 <CFOUTPUT QUERY = "inserta">
  <cfset Last_Obsoleto=#Last_Obsoleto# +1 />
 </CFOUTPUT>
 <cfquery name="inserta" datasource="prafipp">
   update montos set obsoleto=#Last_Obsoleto# where Ejercicio=#SESSION.Ejercicio# and Id_Prog=#SESSION.Id_Prog# and Id_EntFed=#SESSION.Id_EntFed# and obsoleto=0;
 </cfquery>
  	<cfset pos=Find(',',#I_Row#)>
    <cfset stop=val(RemoveChars(#I_Row#, 1, pos))>
    
  <cfquery name="inserta" datasource="prafipp">
    <cfloop index="rubro" from = "1" to =#Total_Rubros#  step="1">
    <cfset M1=Evaluate("r#rubro#_1")>
    <cfset M2=Evaluate("r#rubro#_2")>
    <cfset M3=Evaluate("r#rubro#_3")>
    <cfset M4=Evaluate("r#rubro#_4")>
    <cfset Monto1a=replaceSpecialChars(#M1#)>
    <cfset Monto2a=replaceSpecialChars(#M2#)>
    <cfset Monto3a=replaceSpecialChars(#M3#)>
    <cfset Monto4a=replaceSpecialChars(#M4#)>
 	SET DATEFORMAT ymd;
      insert into Montos values(0,#Ejercicio#,#Id_Prog#,#Id_EntFed#,#rubro#,#Monto1a#,#Monto2a#,#Monto3a#,#Monto4a#,#now()#,'#SESSION.Id_User#');
    </cfloop>
  </cfquery>
<cflocation url="itaf_cap.cfm?Id_EntFed=#SESSION.Id_EntFed#">
