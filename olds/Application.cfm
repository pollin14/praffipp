 <cfapplication name="cfcentral"
    sessionmanagement="true"
    sessiontimeout="#CreateTimeSpan(0,0,30,0)#"
    />
  <cfset application.dsname="prafipp">
  <cfset request.dsname="prafipp">
  <cfset session.profile=StructNew()>
 
 <cfif IsDefined("Form.logout")>
  <cflogout>
 </cfif>
 
 <cflogin>
  <cfif NOT IsDefined("cflogin")>
   <cfinclude template="loginform.cfm">
   <cfabort>
  <cfelse>
   <cfif cflogin.name IS "" OR cflogin.password IS "">
    <cfoutput>
  <h2>Debes capturar ambos campos</h2>
    </cfoutput>
    <cfinclude template="loginform.cfm">
    <cfabort>
   <cfelse>
    <cfquery name="loginQuery" dataSource="#request.dsname#">
    SELECT AdminName, Role
    FROM admin
    WHERE
  AdminName = '#cflogin.name#'
  AND Password = '#cflogin.password#'
    </cfquery>
    <cfif loginQuery.Role NEQ "">
  <cfloginuser name="#cflogin.name#" Password = "#cflogin.password#"
   roles="#loginQuery.Role#">
    <cfelse>
  <cfoutput>
   <H2>Los datos no son correctos.<br>
   Intente nuevamente</H2>
  </cfoutput> 
  <cfinclude template="loginform.cfm">
  <cfabort>
    </cfif>
   </cfif> 
  </cfif>
 </cflogin>
 
 <cfif GetAuthUser() NEQ "">
  <cfoutput>
   <form action="#CGI.script_name#?#CGI.query_string#" method="Post">
    <input type="submit" Name="Logout" value="Logout">
   </form>
  </cfoutput>
 </cfif>
