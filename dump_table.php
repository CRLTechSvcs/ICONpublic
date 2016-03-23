<?php
/*
	contribution in PHP manual by user:
 	andresa dot ms at gmail dot com 03-Sep-2010 07:56
*/


function dump_table($var, $title=false, $level=0) {
     if($level==0)
     {
         echo '<table width="100%" border="5" bordercolor="#ff0000" cellspacing="1" cellpadding="3" class="dump">';

         if($title)
               echo '<tr>
                      <th align="center" colspan="2">'.$title.'</th>
                    </tr>';

         echo '
           <tr>
             <th align="right">VAR NAME</th>
             <th align="left">VALUE</th>
           </tr>';
     }
     else
     {
         echo '<tr>
                 <td colspan="2">
                     <table width="100%" border="1" bordercolor="#0000ff"  cellspacing="3" cellpadding="3" class="dump_b">
                 </td>
               </tr>';
     }

     foreach($var as $i=>$value)
     {
         if(is_array($value) or is_object($value))
         {
             dump_table($value, false, ($level +1));
         }
         else
         {
                 echo '<tr>
                         <td align="right" width="50%" >'.$i.'</th>
                         <td align="left" width="50%" >'.$value.'</th>
                        </tr>';
         }
     }
     echo '</table>';
 }

?>