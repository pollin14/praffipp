<cfif isDefined("fileUpload")>
  <cffile action="upload"
     fileField="fileUpload"
     destination="C:\docs\prafipp">
     <p>Thankyou, your file has been uploaded.</p>
</cfif>
<form enctype="multipart/form-data" method="post">
<input type="file" name="fileUpload" /><br />
<input type="submit" value="Upload File" />
</form>