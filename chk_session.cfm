<cfif Not IsDefined("SESSION.rol")>
  <cflogout>
  <cflocation url="index.cfm">
</cfif>
<p align="center"><cfoutput>#SESSION.Nombre# &nbsp;&nbsp;&nbsp;&nbsp;| </cfoutput>
<!---cfif #SESSION.Id_User# IS 1>
	<a href="cambio_trim.cfm" target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=460,left = 387,top = 259'); return false;">Trimestre</a> &nbsp; | &nbsp;
</cfif--->
<cfif #SESSION.Id_User# IS 829>
	<a href="noticias.cfm" target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=460,left = 387,top = 259'); return false;">Nuevas noticias</a> &nbsp; | &nbsp;
</cfif>
<cfif #SESSION.Rol# EQ 1>
	<a href="estatus_fin.cfm" target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=380,left = 387,top = 259'); return false;">Estatus Financiero</a> &nbsp; | &nbsp;
    <a href="estatus_tec.cfm" target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=380,left = 387,top = 259'); return false;">Estatus T&eacute;cnico</a> &nbsp; | &nbsp;
</cfif>
<a href="cambio_password.cfm" target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=460,left = 387,top = 259'); return false;">Cambiar contrase&ntilde;a</a> &nbsp; | &nbsp;
<a href="cambio_email.cfm" target='_blank' onClick="window.open(this.href, this.target, 'toolbar=0,scrollbars=0,location=0,statusbar=0,men ubar=0,resizable=0,width=550,height=460,left = 387,top = 259'); return false;">Cambiar correo electr&oacute;nico</a> &nbsp; | &nbsp;
<!--<a href="cambio_password.cfm" target='_blank'/>Cambiar contraseña</a></p>-->
<a href="logout.cfm">Salir de la plataforma</a> </p>





