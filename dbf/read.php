<?php

// open in read-only mode
$db = dbase_open('PRIMGF10.DBF', 0);

if ($db) {
  // read some data ..
  
  dbase_close($db);
}

?> 