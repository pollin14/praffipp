<cfapplication name="prafipp" sessionmanagement="yes">


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/prafipp.css" rel="stylesheet" type="text/css" />
<title>Cambiar estatus financiero</title>


</head>

<body>

<cfinclude template="chk_session.cfm">

<cfset Trimestre_Actual = #SESSION.Trimestre# / 10>
<cfset Trimestre_siguiente = #Trimestre_Actual# + 1>

<cfset c=#form.RadioDictamen#>

<cfif #SESSION.rol# eq 4 >
	  <!---cfset consulta = "update Prog_EntFed set Trim_Captura=(#SESSION.Trimestre#/10)+1 " --->
      <cfset consulta = "update Prog_EntFed set Trim_Captura=(#SESSION.Trimestre#/10) " >
         <cfif #c#> <!---cumple--->
          <cfset consulta = #consulta#& ", Status_Trim#Trimestre_Actual#=60 + Status_Trim#Trimestre_Actual# % 10" >
         <cfelse>
          <cfset consulta = #consulta#& ", Status_Trim#Trimestre_Actual#=40 + Status_Trim#Trimestre_Actual# % 10" >
         </cfif>
         <!---cfset consulta = #consulta#& ", Status_Trim#Trimestre_siguiente#=20 + Status_Trim#Trimestre_siguiente# % 10 where Ejercicio=#SESSION.Ejercicio# and Id_Prog=#SESSION.Id_Prog# and Id_EntFed=#SESSION.Id_EntFed#"--->
         <cfset consulta = #consulta#& " where Ejercicio=#SESSION.Ejercicio# and Id_Prog=#SESSION.Id_Prog# and Id_EntFed=#SESSION.Id_EntFed#" >
      <!---cfdump var="#consulta#"--->
       <cfquery name="inserta" datasource="prafipp">
          #consulta#
       </cfquery>
 <cfelseif #SESSION.rol# eq 6 >
	  <!---cfset consulta = "update Prog_EntFed set Trim_CapturaT=(#SESSION.Trimestre#/10)+1 " --->
      <cfset consulta = "update Prog_EntFed set Trim_CapturaT=(#SESSION.Trimestre#/10) ">
         <cfif #c#> <!---cumple--->
          <cfset consulta = #consulta#& ", Status_Trim#Trimestre_Actual#=6 + (Status_Trim#Trimestre_Actual# / 10)*10" >
         <cfelse>
          <cfset consulta = #consulta#& ", Status_Trim#Trimestre_Actual#=4 + (Status_Trim#Trimestre_Actual# / 10)*10" >
         </cfif>
         <!---cfset consulta = #consulta#& ", Status_Trim#Trimestre_siguiente#=2 + (Status_Trim#Trimestre_siguiente# / 10)*10 where Ejercicio=#SESSION.Ejercicio# and Id_Prog=#SESSION.Id_Prog# and Id_EntFed=#SESSION.Id_EntFed#" --->
         <cfset consulta = #consulta#& " where Ejercicio=#SESSION.Ejercicio# and Id_Prog=#SESSION.Id_Prog# and Id_EntFed=#SESSION.Id_EntFed#" >
      <!---cfdump var="#consulta#"--->
      <cfoutput>QUERY=#consulta#</cfoutput>
       <cfquery name="inserta" datasource="prafipp">
          #consulta#
       </cfquery> 
 </cfif>


<cfset RadioDictamen=#Form.RadioDictamen#>
<cfif #Form.RadioDictamen# EQ 1>
	<cfset Calif="Aprobado">
<cfelse>
	<cfset Calif="Rechazado">
</cfif>
<cfset Time=#TimeFormat(Now(), "hh:mm:ss")#>
<cfset Date=#DateFormat(Now(), "mm/dd/yyyy")#>
<cfset Fecha='#Date# #Time#'>

<cfquery name="insertar" datasource="prafipp">
		INSERT INTO logs(Ejercicio, Id_EntFed, Id_Prog, Id_User, Log_Type, Descrip, Fecha)
		VALUES(#SESSION.Ejercicio#,#SESSION.Id_EntFed#,#SESSION.Id_Prog#, '#SESSION.Id_User#', 10 , '#Calif#,#Form.nota_dictamen#' , '#Fecha#')
</cfquery>

<!---cfset consulta = "insert into logs values ( #SESSION.Ejercicio#, #SESSION.Id_EntFed# ,#SESSION.Id_Prog#, #SESSION.Id_User#, 1,#chr(39)# Oops! #chr(39)#,#now()#)">
   <!---cfif #c#> <!---cumple--->
   	<cfset consulta = #consulta#&  "'aceptacion " >
   <cfelse>
   	<cfset consulta = #consulta#&  "'rechazo " >
   </cfif>
   <cfset consulta = #consulta#& " de trimestre numero #Trimestre_Actual# por #SESSION.nombre#',#now()# )" --->
<cfdump var="#consulta#">
 <cfquery name="logs" datasource="prafipp">
 	#consulta#
 </cfquery--->


<CFQUERY NAME="QRY_usuarios" DATASOURCE="prafipp">
    SELECT *
    FROM usuarios
    WHERE Id_EntFed=#SESSION.Id_EntFed#
    AND Id_Prog in ('#SESSION.Id_Prog#')   
</CFQUERY> 

<cfloop query = "QRY_usuarios"> 
    <cfif #Role# GT 2>
        <cfmail 
            server="pop.sep.gob.mx"
            to="#QRY_usuarios.email#"
            from="#SESSION.email#"
            subject="Trimestre calificado"
            type="html"
            charset="utf-8"
            >  
            Estimado(a) #QRY_usuarios.Nombre#:
            <br />
            <br />
            Por este medio se le notifica que la validaci&oacute;n <cfif #SESSION.rol# eq 4 >financiera <cfelse>f&iacute;sica </cfif>del trimestre n&uacute;mero #Trimestre_Actual# ha sido <cfif #c#>aprobado<cfelse>rechazado</cfif>
            <br />
            Con la siguiente justificaci&oacute;n:   #form.nota_dictamen#
            <br />
            <br />
            A partir de este momento puede enviar la documentaci�n soporte en f�sico a la direcci�n de enlace.
            <br />
            Si requiere informaci&oacute;n adicional, favor de ponerse en contacto con #SESSION.Nombre# al correo #SESSION.email#<br />
            <br />
            <br />
            <br />    
            Attentamente<br />
            Coordinaci&oacute;n Administrativa<br />
            SEB<br /> 
            <!---	la hora actual es #TimeFormat(Now())#. la hora es #Hour(Now())#, Minuto #Minute(Now())# y segundo #Second(Now())# del dia.  --->
            Saludos
        </cfmail>
    </cfif>
</cfloop>

<cfdump var="#Application#" label="Application Variables">
<cfdump var="#CGI#" label="CGI Variables">
<cfdump var="#Client#" label="Client Variables">
<cfdump var="#Form#" label="Form Variables">
<cfdump var="#Request#" label="Request Variables">
<cfdump var="#Server#" label="Server Variables">
<cfdump var="#Session#" label="Session Variables">
<cfdump var="#URL#" label="URL Variables">

<cflocation url="itaf_cap.cfm?Id_EntFed=#SESSION.Id_EntFed#">



<!---
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
      insert into Montos values(0,#Ejercicio#,#Id_Prog#,#Id_EntFed#,#rubro#,#Monto1a#,#Monto2a#,#Monto3a#,#Monto4a#,#now()#,'#SESSION.Id_User#');
    </cfloop>
  </cfquery>

--->






</body>
</html>