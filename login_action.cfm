<!--- The Login Script below Only Executes if the user has not logged in yet --->
<!--- Once the user has been logged in and verified via the <cflogin> script, the following code within the <cflogin> tags is ignored. --->
<!--- Begin Login Script --->
<cflogin idletimeout="3000">
    <!--- SETS the action page of the login form to whatever page the user was trying to go to.  Since the login will actually be processed in the application.cfm file (or a template included in it), then the FORM action is the page that will be loaded after the login has been completed. --->
    <!--- IF there IS NOT a Query String passed in the URL, only the requested page name is used --->
    <cfif CGI.QUERY_STRING IS "">
        <cfset FormAction = #CGI.SCRIPT_NAME#>
    <!--- IF there IS a Query String passed in the URL, it is added to the requested page name. --->
    <cfelse>
        <cfset FormAction = "#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">
    </cfif>
<!--- IF the Username and Password are not present, then the user has not logged in and the login form is displayed and all further processing stops. --->
    <cfif NOT (IsDefined ("Form.Username") AND IsDefined ("Form.Password"))>
        <cfinclude template="login.cfm">
        <cfabort>
    <!--- Else, If the username and password ARE present, the login is processed. --->    
    <cfelse>
        <!--- Query gets the information from the database matching the login provided. --->
            <CFQUERY NAME="login" DATASOURCE="prafipp">
            SELECT      Id_User,Usuario, Nombre, Role, ur, Id_Prog, Id_EntFed, Password, email, cargo
            FROM         usuarios         
            WHERE        (usuario = <cfqueryparam value="#Form.Username#" cfsqltype="CF_SQL_VARCHAR">                         AND Password = <cfqueryparam value="#Form.password#" cfsqltype="CF_SQL_VARCHAR">)
            </CFQUERY>
<!--- IF there was a matching login record, the user is logged in --->
        <cfif login.RecordCount EQ '1'>
          <cfset SESSION.rol=#login.Role#>
		  <cfset SESSION.usuario=#login.Usuario#>
		  <cfset SESSION.Nombre=#RTrim(LTrim(login.Nombre))#>
          <cfset SESSION.ur=#login.ur#>
          <cfset SESSION.Id_User=#login.Id_User#>
          <cfset SESSION.Id_Prog=#login.Id_Prog#>
          <cfset SESSION.Id_EntFed=#login.Id_EntFed#>
          <cfset SESSION.Ejercicio=2012>
          <cfset SESSION.num_Ingresos=4> <!--- Si+RF+PF+Otros--->
          <cfset SESSION.email=#login.email#>
          <cfquery datasource="prafipp" name="accesos">
	 	    SET DATEFORMAT ymd;
          	insert into accesos values(#login.Id_User#,#now()#)
          </cfquery>
          
          <cfloginuser name="#login.Nombre#" password="#Form.password#" roles="#trim(login.Role)#">
<!--- IF there WAS NOT a matching record, an "Invalid Login" message is shown and the user is prompted to login again. --->     
        <cfelse>
            <!--- Creates the Variable "Invalid" to instruct Login page to display "Invalid Login" Message. --->
            <cfset Invalid = "Yes">
                <cflogout>
                <cfset tmp_var = StructClear(session)>
                <cflocation url="index.cfm">

            <cfinclude template="login.cfm">
            <cfabort>
        </cfif>        
    </cfif>    
</cflogin>

<!--- These SET statements take the values in the <cflogin> tag's "Name" attribute and seperates them into two seperate variables (EmployeeID and EmployeeName) to be used throughout the application.  These variables exist as long as the login session exists. --->
<cfset EmployeeID = ListFirst(GetAuthUser())>
<cfset EmployeeName = ListRest(GetAuthUser())>
