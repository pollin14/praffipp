<title>PRAFIPP Cat&aacute;logo de BANCOS</title>
<link rel="stylesheet" type="text/css" href="../css/prafipp.css">
<style type="text/css">

div { display:block;}


</style>
</head>
<script type="text/javascript" language="javascript" src="../js/func.js">
</script>

<body>
<table align="center" border="0" cellspacing="0" cellpadding="0" width="975">
    <tr><td align="center" >
        <img src="../img/header.jpg" width="975" height="90" alt="Encabezado" />
    <tr><td>
    <tr><td align="center" >
        <br />
      <h2>Cat&aacute;logo de BANCOS</h2>
        <br />
    <tr><td>
    <tr><td align="center" height="600" valign="top" >       
            <cfquery name="Qbancos" datasource="prafipp">  
             SELECT Clave_Banco, Nom_Banco FROM bancos  
            </cfquery>  
            <cfform method="post" name="GridBancosForm" >  
             <cfgrid    
                   selectmode="edit"
                   name="BancosGrid"   
                   query="Qbancos"   
                   format="html"
                   width="460"   
                   height="350"
                   insert="yes"
                   delete="yes"
                    bgcolor="##ACC5CA">  
                   <cfgridcolumn name = "Clave_Banco" header = "Clave" width="25" href="http://gmail.com" textcolor="blue" bold="Yes">  
                   <cfgridcolumn name = "Nom_Banco" header = "Nombre" width="400">         
             </cfgrid>  
            </cfform>  
    <tr><td>            
        <table align="center" border="0" cellspacing="0" cellpadding="0" width="975">
          <tr><td>
          <img src="../img/footer.jpg" width="975" height="23" alt="footer" />
          </td></tr>
        </table>
    </td></tr>
</table>

</body>
</html>




