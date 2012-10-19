 Por favor ingrese sus datos<cfoutput>
    <form name="LoginForm" action="#CGI.script_name#?#CGI.query_string#" method="Post">
    <table>
    <tr>
    <td>Usuario:</td>
    <td><input type="text" name="j_userName"></td>
    </tr>
    <tr>
    <td>Contrase&ntilde;a:</td>
    <td><input type="password" name="j_password"></td>
    </tr>
    </table>
    <br>
    <input type="submit" value="Ingreso">
    </form>
 </cfoutput>
