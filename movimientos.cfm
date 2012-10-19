<cfapplication name="prafipp" sessionmanagement="yes">
<cfparam name="Attributes.Ejercicio" default="2012">
<cfparam name="Attributes.Id_Prog" default="20121">
<cfparam name="Attributes.Id_EntFed" default="1">
<cfparam name="Attributes.Trimestre" default="1">
<cfparam name="Attributes.Captura" default="False">
<cfparam name="Attributes.Elaboro" default="No definido ...">
<cfparam name="Attributes.Responsable" default="No definido ...">
<cfparam name="Attributes.Desde" default="13">
<cfparam name="Attributes.Num_Egresos" default="0">
<cfparam name="Attributes.Nom_Form" default="Egresos">
<cfparam name="Attributes.grupo" default="E">
<cfparam name="Attributes.Status_Trim1" default="1">
<cfparam name="Attributes.Status_Trim2" default="1">
<cfparam name="Attributes.Status_Trim3" default="1">
<cfparam name="Attributes.Status_Trim4" default="1">

<cfif #Attributes.Desde# gt 1> <!--- índice de los montos a capturar el 1 es para Movimientos --->
 <cfset hdr="Aplicaci&oacute;n de los recursos de acuerdo a la prorroga otorgada.">
<cfelse> 
 <cfset hdr="Movimientos Financieros en los trimestres I,II,III y IV del #Attributes.Ejercicio#">
</cfif>
<br/>


<!---  FUNCION PARA CARGAR CON IMAGEN ARCHIVO PDF  --->
<cffunction name="iconoDescarga" access="remote" returntype="string" description="Ubicacion del archivo"> 
 <cfargument name="Tipo" type="string" required="yes">
 <cfargument name="Trim" type="numeric" required="yes"> 
 
     <cfquery name="Consulta" datasource="prafipp">
        SELECT	Ubicacion
        FROM	Cargas
        WHERE	Id_Prog=#Attributes.Id_Prog#
        AND		Id_EntFed=#Attributes.Id_EntFed#
        AND		Trim_Captura=#arguments.Trim#
        AND		Tipo='#arguments.Tipo#'
    </cfquery>
 
	<cfset path = 0 >
    <cfset a_tag = "" >
    <cfoutput query="Consulta"><cfset path = #Ubicacion# ></cfoutput>
    <cfdirectory action="list" directory="#path#" name="qGetDirectory" />
    <cfoutput>
    <cfloop query="qGetDirectory">
	<cfset enlace = "descarga.cfm?Id_Prog=#Attributes.Id_Prog#&Id_EntFed=#Attributes.Id_EntFed#&Trim_Captura=#arguments.Trim#&Tipo=#arguments.Tipo#" />
    <cfset a_tag = "<a href='#enlace#' title='#qGetDirectory.name#' target='_blank'><img src='img/icono_descarga.jpg' alt='#qGetDirectory.name#'  border=0/></a>" />
	</cfloop>
	</cfoutput>

    <cfreturn a_tag>  
</cffunction>
<!---  FIN FUNCION PARA CARGAR CON IMAGEN ARCHIVO PDF  --->


<br />
<table width="100%" cellspacing="0" class="TblInterna">
  <tr  class="custom_tr">
    <td width="14%"><div align="center">Simbolog&iacute;a</div></td>
    <td width="14%"><div align="center">Programado <img src="img/azul.png" width="14" height="14" alt="naranja" /></div></td>
    <td width="14%"><div align="center">En captura <img src="img/amarillo.png" width="14" height="14" alt="amarillo" /></div></td>
    <td width="14%"><div align="center">Validando <img src="img/validando.png" width="14" height="14" alt="verde_rojo" /></div></td>
    <td width="16%"><div align="center">Enviar Documentos<img src="img/enviar.png" width="14" height="14" alt="amarillo_verde" /></div></td>
    <td width="14%"><div align="center">Dictamen OK <img src="img/verde.png" width="14" height="14" alt="verde" /></div></td>
    <td width="14%"><div align="center">Rechazado <img src="img/rojo.png" width="14" height="14" alt="rojo" /></div></td>
  </tr>
</table>
<br />

<table >
  <tr >
    <td width="40%" align="center" class="colheader">Evidencia Financiera</td>
    <td width="10%" align="center" class="colheader"><cfoutput>EC #iconoDescarga('EstadoCuenta',1)# RT #iconoDescarga('ReintegroTesoreria',1)# RI #iconoDescarga('ReciboInstitucional',1)# IF #iconoDescarga('InformeFinanciero',1)#</cfoutput></td>
    <td width="10%" align="center" class="colheader"><cfoutput>EC #iconoDescarga('EstadoCuenta',2)# RT #iconoDescarga('ReintegroTesoreria',2)# RI #iconoDescarga('ReciboInstitucional',2)# IF #iconoDescarga('InformeFinanciero',2)#</cfoutput></td>
    <td width="10%" align="center" class="colheader"><cfoutput>EC #iconoDescarga('EstadoCuenta',3)# RT #iconoDescarga('ReintegroTesoreria',3)# RI #iconoDescarga('ReciboInstitucional',3)# IF #iconoDescarga('InformeFinanciero',3)#</cfoutput></td>
    <td width="10%" align="center" class="colheader"><cfoutput>EC #iconoDescarga('EstadoCuenta',4)# RT #iconoDescarga('ReintegroTesoreria',4)# RI #iconoDescarga('ReciboInstitucional',4)# IF #iconoDescarga('InformeFinanciero',4)#</cfoutput></td>
    <td width="10%" align="center" class="colheader">&nbsp;</td>
  </tr>
  <tr >
    <td width="40%" align="center" class="colheader"><cfoutput>#hdr#</cfoutput></td>
    <td width="10%" align="center" class="colheader">1er trimestre <img 
      <cfswitch expression="#Attributes.Status_Trim1\10#">
       <cfcase value="1">
        src="img/azul.png" 
       </cfcase>
       <cfcase value="2">
        src="img/amarillo.png" 
       </cfcase>
       <cfcase value="3">
        src="img/verde.png" 
       </cfcase>
       <cfcase value="4">
        src="img/rojo.png" 
       </cfcase>
       <cfcase value="5">
        src="img/validando.png" 
       </cfcase>
       <cfcase value="6">
        src="img/enviar.png" 
       </cfcase>        
       <cfdefaultcase>
        src="img/azul.png" 
       </cfdefaultcase>
      </cfswitch>
      />
      <img 
      <cfswitch expression="#Attributes.Status_Trim1 MOD 10#">
       <cfcase value="1">
        src="img/azul.png" 
       </cfcase>
       <cfcase value="2">
        src="img/amarillo.png" 
       </cfcase>
       <cfcase value="3">
        src="img/verde.png" 
       </cfcase>
       <cfcase value="4">
        src="img/rojo.png" 
       </cfcase>
       <cfcase value="5">
        src="img/validando.png" 
       </cfcase>
       <cfcase value="6">
        src="img/enviar.png" 
       </cfcase>        
       <cfdefaultcase>
        src="img/azul.png" 
       </cfdefaultcase>
      </cfswitch>
      />
    </td>
    <td width="10%" align="center" class="colheader">2o trimestre <img 
      <cfswitch expression="#Attributes.Status_Trim2\10#">
       <cfcase value="1">
        src="img/azul.png" 
       </cfcase>
       <cfcase value="2">
        src="img/amarillo.png" 
       </cfcase>
       <cfcase value="3">
        src="img/verde.png" 
       </cfcase>
       <cfcase value="4">
        src="img/rojo.png" 
       </cfcase>
       <cfcase value="5">
        src="img/validando.png" 
       </cfcase>
       <cfcase value="6">
        src="img/enviar.png" 
       </cfcase>        
       
       <cfdefaultcase>
        src="img/azul.png" 
       </cfdefaultcase>
      </cfswitch>
      />
      <img 
      <cfswitch expression="#Attributes.Status_Trim2 MOD 10#">
       <cfcase value="1">
        src="img/azul.png" 
       </cfcase>
       <cfcase value="2">
        src="img/amarillo.png" 
       </cfcase>
       <cfcase value="3">
        src="img/verde.png" 
       </cfcase>
       <cfcase value="4">
        src="img/rojo.png" 
       </cfcase>
       <cfcase value="5">
        src="img/validando.png" 
       </cfcase>
       <cfcase value="6">
        src="img/enviar.png" 
       </cfcase>        
       
       <cfdefaultcase>
        src="img/azul.png" 
       </cfdefaultcase>
      </cfswitch>
      />	
    </td>
    <td width="10%" align="center" class="colheader">3er trimestre <img 
      <cfswitch expression="#Attributes.Status_Trim3\10#">
       <cfcase value="1">
        src="img/azul.png" 
       </cfcase>
       <cfcase value="2">
        src="img/amarillo.png" 
       </cfcase>
       <cfcase value="3">
        src="img/verde.png" 
       </cfcase>
       <cfcase value="4">
        src="img/rojo.png" 
       </cfcase>
       <cfcase value="5">
        src="img/validando.png" 
       </cfcase>
       <cfcase value="6">
        src="img/enviar.png" 
       </cfcase>               
       <cfdefaultcase>
        src="img/azul.png" 
       </cfdefaultcase>
      </cfswitch>
      />
      
      <img 
      <cfswitch expression="#Attributes.Status_Trim3 MOD 10#">
       <cfcase value="1">
        src="img/azul.png" 
       </cfcase>
       <cfcase value="2">
        src="img/amarillo.png" 
       </cfcase>
       <cfcase value="3">
        src="img/verde.png" 
       </cfcase>
       <cfcase value="4">
        src="img/rojo.png" 
       </cfcase>
       <cfcase value="5">
        src="img/validando.png" 
       </cfcase>
       <cfcase value="6">
        src="img/enviar.png" 
       </cfcase>               
       <cfdefaultcase>
        src="img/azul.png" 
       </cfdefaultcase>
      </cfswitch>
      />
	</td>
    <td width="10%" align="center" class="colheader">4o trimestre <img 
      <cfswitch expression="#Attributes.Status_Trim4\10#">
       <cfcase value="1">
        src="img/azul.png" 
       </cfcase>
       <cfcase value="2">
        src="img/amarillo.png" 
       </cfcase>
       <cfcase value="3">
        src="img/verde.png" 
       </cfcase>
       <cfcase value="4">
        src="img/rojo.png" 
       </cfcase>
       <cfcase value="5">
        src="img/validando.png" 
       </cfcase>
       <cfcase value="6">
        src="img/enviar.png" 
       </cfcase>
       <cfdefaultcase>
        src="img/azul.png" 
       </cfdefaultcase>
      </cfswitch>
       />     
      <img 
      <cfswitch expression="#Attributes.Status_Trim4 MOD 10#">
       <cfcase value="1">
        src="img/azul.png" 
       </cfcase>
       <cfcase value="2">
        src="img/amarillo.png" 
       </cfcase>
       <cfcase value="3">
        src="img/verde.png" 
       </cfcase>
       <cfcase value="4">
        src="img/rojo.png" 
       </cfcase>
       <cfcase value="5">
        src="img/validando.png" 
       </cfcase>
       <cfcase value="6">
        src="img/enviar.png" 
       </cfcase>        
       <cfdefaultcase>
        src="img/azul.png" 
       </cfdefaultcase>
      </cfswitch>
     />      
    </td>
    <td width="10%" align="center" class="colheader">Acumulado del Ejercicio</td>
  </tr>
  
  <tr >
    <td width="40%" align="center" class="colheader">Evidencia Tecnica</td>
    <td width="10%" align="center" class="colheader">Inf. t&eacute;cnico &nbsp;<cfoutput>#iconoDescarga('InformeTecnico',1)#</cfoutput></td>
    <td width="10%" align="center" class="colheader">Inf. t&eacute;cnico &nbsp;<cfoutput>#iconoDescarga('InformeTecnico',2)#</cfoutput></td>
    <td width="10%" align="center" class="colheader">Inf. t&eacute;cnico &nbsp;<cfoutput>#iconoDescarga('InformeTecnico',3)#</cfoutput></td>
    <td width="10%" align="center" class="colheader">Inf. t&eacute;cnico &nbsp;<cfoutput>#iconoDescarga('InformeTecnico',4)#</cfoutput></td>
    <td width="10%" align="center" class="colheader">&nbsp;</td>
  </tr>  
  
  <cfset qmontos="select * from montos,rubros where Montos.Id_rubro=Rubros.Id_Rubro and Montos.Ejercicio=Rubros.Ejercicio and Montos.Ejercicio=#Attributes.Ejercicio# and Montos.Id_Prog=rubros.Id_Prog and Montos.Id_Prog=#Attributes.Id_Prog# and Montos.Id_EntFed=#Attributes.Id_EntFed# and obsoleto=0">
  <!--- <cfoutput>#qmontos#  </cfoutput> --->
  <cfquery datasource="prafipp" name="rubros">
      #qmontos#
  </cfquery>
  <cfif #rubros.recordcount# eq 0>
    <cfquery name="max" datasource="prafipp">
       select max(obsoleto) as Last_Obsoleto from Montos where Ejercicio=#Attributes.Ejercicio# and Id_Prog=#Attributes.Id_Prog# and Id_EntFed=#Attributes.Id_EntFed#;
     </cfquery>
    <cfif  #max.Last_Obsoleto# neq "">
      <!---cfoutput>"max.Last_Obsoleto=#max.Last_Obsoleto#"</cfoutput--->
      <cfset Last_Obsoleto=#max.Last_Obsoleto# +1 />
      <cfquery name="actualiza" datasource="prafipp">
       update montos set obsoleto=#Last_Obsoleto# where Ejercicio=#Attributes.Ejercicio# and Id_Prog=#Attributes.Id_Prog# and Id_EntFed=#Attributes.Id_EntFed# and obsoleto=0;
      </cfquery>
    </cfif>
    <cfquery name="inserta" datasource="prafipp">
      insert into montos (obsoleto,ejercicio,id_prog,id_EntFed,id_rubro,Monto1,Monto2,Monto3,Monto4,actualiza,Id_User)
      select obsoleto=0,ejercicio,id_prog,id_EntFed=#Attributes.Id_EntFed#,id_rubro,Monto1=0,Monto2=0,Monto3=0,Monto4=0,actualiza={fn now()},Id_User=#SESSION.Id_User# 
      from rubros where ejercicio=#Attributes.Ejercicio# and id_prog=#Attributes.Id_Prog# 
    </cfquery>
    <cfset qmontos="select * from montos,rubros where Montos.Id_rubro=Rubros.Id_Rubro and Montos.Ejercicio=Rubros.Ejercicio and Montos.Ejercicio=#Attributes.Ejercicio# and Montos.Id_Prog=rubros.Id_Prog and Montos.Id_Prog=#Attributes.Id_Prog# and Montos.Id_EntFed=#Attributes.Id_EntFed# and obsoleto=0">
    <cfquery datasource="prafipp" name="rubros">
      #qmontos#
    </cfquery>
  </cfif>
  <cfset i_row=#Attributes.desde#>
  <!---cfform name="#Attributes.Nom_Form#" id="#Attributes.Nom_Form#" method="post" action="save_trim.cfm"--->
  <cfoutput query="rubros" startrow=#i_row# maxrows="1">
    <tr >
      <td>#Nom_rubro#</td>
      <cfset Suma_Row=0>
      <cfloop index="trim" from = "1" to = "5" step="1">
        <cfif trim LT 5>
          <cfset Monto_Display = "Monto#trim#">
          <cfset Monto_Display = #evaluate(Monto_Display)#>
          <cfset Suma_Row+=#Monto_Display#>
          <cfelse>
          <cfset Monto_Display = #Suma_Row#>
        </cfif>
        <cfif trim eq #Attributes.Trimestre# and #Attributes.Captura#>
          <td ><cfinput type="text" name="r#i_row#_#trim#"  class="suma" id="r#i_row#_#trim#" onChange="df_calc(#Attributes.Trimestre#,'#Attributes.Nom_Form#', #Attributes.Desde#,'#Attributes.grupo#');" value="#NumberFormat( Monto_Display, "," )#" readonly="true" /></td>
          <cfelse>
          <td ><cfinput type="text" name="r#i_row#_#trim#" class="suma" id="r#i_row#_#trim#" onChange="df_calc(#Attributes.Trimestre#,'#Attributes.Nom_Form#', #Attributes.Desde#,'#Attributes.grupo#');" value="#NumberFormat( Monto_Display, "," )#" readonly="true" /></td>
        </cfif>
      </cfloop>
    </tr>
    <cfset suma1=#Monto1#>
    <cfset suma2=#Monto2#>
    <cfset suma3=#Monto3#>
    <cfset suma4=#Monto4#>
  </cfoutput>
  <cfif not isDefined('suma1')>
    <cfoutput>OOPS!</cfoutput>
    <cflogout>
    <cflocation url="index.cfm">
  </cfif>
  <cfset DF_suma1=#suma1#>
  <cfset DF_suma2=#suma2#>
  <cfset DF_suma3=#suma3#>
  <cfset DF_suma4=#suma4#>
  <cfset DF_suma5=#suma1#+#suma2#+#suma3#+#suma4#>
  <cfset suma1=0>
  <cfset suma2=0>
  <cfset suma3=0>
  <cfset suma4=0>
  <cfset suma5=0>
  <cfset i_row=#i_row#+1>
  <cfoutput query="rubros" startrow=#i_row# maxrows="3">
    <cfset suma1+=#Monto1#>
    <cfset suma2+=#Monto2#>
    <cfset suma3+=#Monto3#>
    <cfset suma4+=#Monto4#>
  </cfoutput>
  <cfset suma5+=#suma1#+#suma2#+#suma3#+#suma4#>
  <cfset DF_suma1+=#suma1#>
  <cfset DF_suma2+=#suma2#>
  <cfset DF_suma3+=#suma3#>
  <cfset DF_suma4+=#suma4#>
  <cfset DF_suma5+=#suma1#+#suma2#+#suma3#+#suma4#>
  <tr>
    <td class="custom_tr">Total de ingresos (TI=RF+PF+ORF)</td>
    <td><cfinput type="text" name="#Attributes.grupo#ti1" disabled="disabled" class="suma" id="#Attributes.grupo#ti1" value="#NumberFormat( suma1, "," )#" readonly="true" /></td>
    <td><cfinput type="text" name="#Attributes.grupo#ti2" disabled="disabled" class="suma" id="#Attributes.grupo#ti2" value="#suma2#" readonly="true" /></td>
    <td><cfinput type="text" name="#Attributes.grupo#ti3" disabled="disabled" class="suma" id="#Attributes.grupo#ti3" value="#suma3#" readonly="true" /></td>
    <td><cfinput type="text" name="#Attributes.grupo#ti4" disabled="disabled" class="suma" id="#Attributes.grupo#ti4" value="#suma4#" readonly="true" /></td>
    <td><cfinput type="text" name="#Attributes.grupo#ti5" disabled="disabled" class="suma" id="#Attributes.grupo#ti5" value="#suma5#" readonly="true" /></td>
  </tr>
  <cfoutput query="rubros" startrow=#i_row# maxrows="3">
    <tr >
      <td  class="rubro" 
        <cfif #Tipo# EQ "S"> style="padding-left:15px;" </cfif>
        >#Nom_rubro#
      </td>
      <cfset Suma_Row=0>
      <cfloop index="trim" from = "1" to = "5" step="1">
        <cfif trim LT 5>
          <cfset Monto_Display = "Monto#trim#">
          <cfset Monto_Display = #evaluate(Monto_Display)#>
          <cfset Suma_Row+=#Monto_Display#>
          <cfelse>
          <cfset Monto_Display = #Suma_Row#>
        </cfif>
        <cfif trim eq #Attributes.Trimestre# and #Attributes.Captura# and (#Tipo# NEQ "C")>
         <td ><cfinput type="text" name="r#i_row#_#trim#" class="dato" id="r#i_row#_#trim#" onChange="ti_calc(#Attributes.Trimestre#,'#Attributes.Nom_Form#', #Attributes.Desde#,'#Attributes.grupo#');" value="#evaluate(Monto_Display)#" /></td>
       <cfelse>
         <td ><cfinput type="text" name="r#i_row#_#trim#" class="suma" id="r#i_row#_#trim#" onChange="ti_calc(#Attributes.Trimestre#,'#Attributes.Nom_Form#', #Attributes.Desde#,'#Attributes.grupo#');" value="#evaluate(Monto_Display)#" readonly="true" /></td>
        </cfif>
      </cfloop>
      <!---  Codigo previo a integrar la quinta columna
  
    <td class="rubro">#Nom_rubro#</td>
     <cfloop index="trim" from = "1" to = "5" step="1">
       <cfset Monto_Display = "Monto#trim#">
	   <cfset Monto_Display = #evaluate(Monto_Display)#>
	   <cfset Suma_Row+=#Monto_Display#>
       <cfif trim eq #Attributes.Trimestre# and #Attributes.Captura#>
         <td ><cfinput type="text" name="r#i_row#_#trim#" class="dato" id="r#i_row#_#trim#" onChange="ti_calc(#Attributes.Trimestre#,'#Attributes.Nom_Form#', #Attributes.Desde#,'#Attributes.grupo#');" value="#evaluate(Monto_Display)#" /></td>
       <cfelse>
         <td ><cfinput type="text" name="r#i_row#_#trim#" class="dato" id="r#i_row#_#trim#" onChange="ti_calc(#Attributes.Trimestre#,'#Attributes.Nom_Form#', #Attributes.Desde#,'#Attributes.grupo#');" value="#evaluate(Monto_Display)#" readonly="true" /></td>
       </cfif>
     </cfloop>
--->
    </tr>
    <cfset i_row=#i_row#+1>
  </cfoutput>
  <cfset suma1=0>
  <cfset suma2=0>
  <cfset suma3=0>
  <cfset suma4=0>
  <cfset suma5=0>
  <cfoutput query="rubros" startrow=#i_row# maxrows=#Attributes.Num_Egresos#>
    <cfset suma1+=#Monto1#>
    <cfset suma2+=#Monto2#>
    <cfset suma3+=#Monto3#>
    <cfset suma4+=#Monto4#>
  </cfoutput>
  <cfset suma5=#suma1#+#suma2#+#suma3#+#suma4#>
  <cfset DF_suma1-=#suma1#>
  <cfset DF_suma2-=#suma2#>
  <cfset DF_suma3-=#suma3#>
  <cfset DF_suma4-=#suma4#>
  <cfset DF_suma5-=#suma5#>
  

  
  <tr class="custom_tr">
    <td>Total  de Egresos para el trimestre elegido (TE= &sum; rubros  de gasto )</td>
    <td><cfinput type="text" name="#Attributes.grupo#te1" disabled="disabled" class="suma" id="#Attributes.grupo#te1" value="#suma1#" readonly="true" /></td>
    <td><cfinput type="text" name="#Attributes.grupo#te2" disabled="disabled" class="suma" id="#Attributes.grupo#te2" value="#suma2#" readonly="true" /></td>
    <td><cfinput type="text" name="#Attributes.grupo#te3" disabled="disabled" class="suma" id="#Attributes.grupo#te3" value="#suma3#" readonly="true" /></td>
    <td><cfinput type="text" name="#Attributes.grupo#te4" disabled="disabled" class="suma" id="#Attributes.grupo#te4" value="#suma4#" readonly="true" /></td>
    <td><cfinput type="text" name="#Attributes.grupo#te5" disabled="disabled" class="suma" id="#Attributes.grupo#te5" value="#suma5#" readonly="true" /></td>
  </tr>
  <cfoutput query="rubros" startrow=#i_row# maxrows=#Attributes.Num_Egresos#>
    <tr >
      <td  class="rubro" <cfif #Tipo# EQ "S"> style="padding-left:15px" </cfif>>
        #Nom_rubro#
      </td>
      <cfset Suma_Row=0>
      <cfloop index="trim" from = "1" to = "5" step="1">
        <cfif trim LT 5>
          <cfset Monto_Display = "Monto#trim#">
          <cfset Monto_Display = #evaluate(Monto_Display)#>
          <cfset Suma_Row+=#Monto_Display#>
          <cfelse>
          <cfset Monto_Display = #Suma_Row#>
        </cfif>
        <!---cfif trim eq #Attributes.Trimestre# and #Attributes.Captura#--->
        <cfif trim eq #Attributes.Trimestre# and #Attributes.Captura# and (#Tipo# NEQ "C")>
<td><cfinput type="text" name="r#i_row#_#trim#" class="editable" id="r#i_row#_#trim#" onChange="te_calc(#Attributes.Trimestre#,'#Attributes.Nom_Form#', #Attributes.Desde#,'#Attributes.grupo#',#Attributes.Num_Egresos#,this);" value="#evaluate(Monto_Display)#" /></td>
          <cfelse>
          <td ><cfinput type="text" name="r#i_row#_#trim#" class="suma" id="r#i_row#_#trim#" value="#evaluate(Monto_Display)#" readonly="true" onChange="limite(50,function(a,b){return a<b},this)"/></td>
        </cfif>
      </cfloop>
      <!---  
    <td class="rubro">#Nom_rubro#</td>
     <cfloop index="trim" from = "1" to = "4" step="1">
       <cfset Monto_Display = "Monto#trim#">
       <cfif trim eq #Attributes.Trimestre# and #Attributes.Captura#>
          <td>xx<cfinput type="text" name="r#i_row#_#trim#" class="editable" id="r#i_row#_#trim#" onChange="te_calc(#Attributes.Trimestre#,'#Attributes.Nom_Form#', #Attributes.Desde#,'#Attributes.grupo#',#Attributes.Num_Egresos#,this);" value="#evaluate(Monto_Display)#" /></td>
          <cfelse>
          <td >yy<cfinput type="text" name="r#i_row#_#trim#" class="suma" id="r#i_row#_#trim#" value="#evaluate(Monto_Display)#" readonly="true" onChange=limite(50,function(a,b){return a<b},this)"/></td>
       </cfif>
     </cfloop>
--->
    </tr>
    <cfset i_row=#i_row#+1>
  </cfoutput>
  <input name="i_row" id="i_row" type="hidden" value="<cfoutput>#i_row#</cfoutput>" />
  <input name="desde" id="desde" type="hidden" value="<cfoutput>#Attributes.desde#</cfoutput>" />
  <tr>
    <td class="colfooter">Disponibilidad Financiera del trimestre (DF=SI+TI-TE)</td>
    <td class="colfooter"><cfinput type="text" name="#Attributes.grupo#df1" disabled="disabled" class="suma" id="#Attributes.grupo#df1" value="#DF_suma1#" readonly="true" /></td>
    <td class="colfooter"><cfinput type="text" name="#Attributes.grupo#df2" disabled="disabled" class="suma" id="#Attributes.grupo#df2" value="#DF_suma2#" readonly="true" /></td>
    <td class="colfooter"><cfinput type="text" name="#Attributes.grupo#df3" disabled="disabled" class="suma" id="#Attributes.grupo#df3" value="#DF_suma3#" readonly="true" /></td>
    <td class="colfooter"><cfinput type="text" name="#Attributes.grupo#df4" disabled="disabled" class="suma" id="#Attributes.grupo#df4" value="#DF_suma4#" readonly="true" /></td>
    <td class="colfooter"><!---cfinput type="text" name="#Attributes.grupo#df5" disabled="disabled" class="suma" id="#Attributes.grupo#df5" value="#DF_suma5#" readonly="true" /---></td>
  </tr>
</table>
<!---/cfform--->
<br />


<!---cfset mr1=#DF_suma1#+0>
<cfset mr2=#DF_suma2#+0>
<cfset mr3=#DF_suma3#+0>
<cfset mr4=#DF_suma4#+0>

<cfset saldo_ini="UPDATE Montos SET Monto2=#mr1#,Monto3=#mr2#,Monto4=#mr3# WHERE obsoleto=0 AND Id_rubro=1 AND Ejercicio=#Attributes.Ejercicio# AND Id_EntFed=#Attributes.Id_EntFed# AND Id_Prog=#Attributes.Id_Prog#">
<cfoutput>saldo_ini=#saldo_ini#</cfoutput> 
<cfquery name="updateSaldo" datasource="prafipp">
	UPDATE Montos
    SET Monto2=#mr1#,Monto3=#mr2#,Monto4=#mr3#
    WHERE Id_Prog=#Attributes.Id_Prog#
    AND Id_EntFed=#Attributes.Id_EntFed#
    AND Ejercicio=#Attributes.Ejercicio#
    AND Id_rubro=1
    AND obsoleto=0
</cfquery>
<cfquery name="updateSaldo2" datasource="prafipp">
	SELECT Monto1,Monto2,Monto3,Monto4
    FROM Montos
    WHERE Id_Prog=#Attributes.Id_Prog#
    AND Id_EntFed=#Attributes.Id_EntFed#
    AND Ejercicio=#Attributes.Ejercicio#
    AND Id_rubro=1 AND obsoleto=0
</cfquery>
</br>
<cfoutput>Monto1=#updateSaldo2.Monto1#</cfoutput>
</br>
<cfoutput>Monto2=#updateSaldo2.Monto2#</cfoutput>
</br>
<cfoutput>Monto3=#updateSaldo2.Monto3#</cfoutput> 
</br>
<cfoutput>Monto4=#updateSaldo2.Monto4#</cfoutput---> 
 
    


<table width="100%" border="0" cellspacing="0" class="TblInterna">
  <tr align="center">
    <td width="45%">
    
    <cfoutput>
    <cfinput type="text" value="#Attributes.Elaboro#" name="#Attributes.grupo#Elaboro" class="editable" preserveData="no">
    </cfoutput>

    </td>
    <td>&nbsp;</td>
    <td width="45%">
    
    <cfoutput>
    <cfinput type="text" value="#Attributes.Responsable#" name="#Attributes.grupo#Responsable" class="editable">
    </cfoutput>

    </td>
  <tr align="center">
    <td width="45%">Nombre de la persona que lo elabor&oacute;</td>
    <td>&nbsp;</td>
    <td width="45%">Nombre del responsable del manejo de los recursos</td>
  </tr>
</table>
<br />

<cfif #Attributes.captura#>
	<p align="center">
	<input type="submit" name="button" id="button" value="Guardar valores">
 <!---input type="submit" name="button2" id="button2" value="Cerrar captura"---></p>
</cfif> 



<br />

