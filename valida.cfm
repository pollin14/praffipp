<!--- checks to make sure user has permission to view this page. --->
<cfif IsUserInRole("Admin") OR IsUserInRole("Accounting")>
...You can view this page...
<cfelse>
...You can not view this page...    
</cfif>