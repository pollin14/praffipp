<cfif Not IsDefined("SESSION.rol")>
  <cflogout>
  <cflocation url="index.cfm">
</cfif>
<p align="center"><cfoutput>#SESSION.Nombre# &nbsp;&nbsp;&nbsp;&nbsp;| </cfoutput>
<cfif #SESSION.Id_User# IS 829>
	<a href="noticias.cfm" target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=460,left = 387,top = 259'); return false;">Nuevas noticias</a> &nbsp; | &nbsp;
</cfif>

<a href="cambio_password.cfm" target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=460,left = 387,top = 259'); return false;">Cambiar contraseña</a> &nbsp; | &nbsp;
<!--<a href="cambio_password.cfm" target='_blank'/>Cambiar contraseña</a></p>-->
<a href="logout.cfm">Salir de la plataforma</a> </p>
