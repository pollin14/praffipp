<cfapplication name="prafipp" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(0, 0, 45, 0)# ">
<!--- Includes the login template to verify logins for every page. --->
<cfinclude template="login_action.cfm">
