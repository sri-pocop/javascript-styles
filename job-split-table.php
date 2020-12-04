<?php

include("common/session.php");
include("common/connect.php");

if($_SESSION["role"] == '3' OR $_SESSION["role"] == '4' OR $_SESSION["role"] == '5')
			{

			$dep_result = mysqli_query($conn,"SELECT * FROM bi_job_split_details  WHERE status_id != '1003' ORDER BY created_date DESC");

			}else{
			$dep_result = mysqli_query($conn,"SELECT * FROM bi_job_split_details  WHERE user_id='".$_SESSION["AppUserID"]."' and status_id != '1003' ORDER BY created_date DESC");	
			}
			

?>

 <table id="example" class="table table-striped table-bordered" style="width:100%">

	<thead>

		<tr>

			<th>Job ID</th>

			
            <!-- <th>File Name</th> -->
			<th >Split Pages</th>
            <th>Total Pages</th>
            <th>Remaining Pages</th>
            <th>Process Type</th>

			<th>Process Name</th>

			<th>Assignee</th>

			<th>Created By</th>
            <th>Timer</th>
			<th> Work Log</th>
             <?php if($_SESSION["role"] == '3' OR $_SESSION["role"] == '4' OR $_SESSION["role"] == '5')
			{?>
            <th>Action</th>
            <?php
            }
            ?>

		</tr>

	</thead>

	<tbody>

	<?php

	$j=1;

	while($dep_row = mysqli_fetch_array($dep_result,MYSQLI_ASSOC))

	{

	?>

		<tr>

			
                  <?php 
				  if(strlen($dep_row["job_id"])==1 )
				  { ?>
			  
				  <td>BI000<?=$dep_row["job_id"]?>_<?=$dep_row["split_id"]?> </td>
				
				<?php 
				  } elseif(strlen($dep_row["job_id"]) ==2){?>
					    <td>BI00<?=$dep_row["job_id"]?>_<?=$dep_row["split_id"]?> </td>
						
				<?php 
				  } elseif(strlen($dep_row["job_id"]) ==3){?>
					   <td>BI0<?=$dep_row["job_id"]?>_<?=$dep_row["split_id"]?> </td>
				  <?php 
				  } else{?>
				   <td>BI<?=$dep_row["job_id"]?>_<?=$dep_row["split_id"]?> </td>
				 <?php }
				  ?>
            
            <?php
            $equery = "SELECT job_ref,file_name FROM bi_job_creation WHERE job_id ='" . $dep_row["job_id"] . "'";
            $eresult = mysqli_query($conn, $equery);
            while ($erow = mysqli_fetch_array($eresult, MYSQLI_ASSOC)) {
            ?>
               
                <td><?= $erow["file_name"] ?></td>
            <?php
            }
            ?>

           
                
            

			<td><?=$dep_row["split_pages"]?></td>
            <td><?=$dep_row["total_pages"]?> </td>

            <td>
             <?php
            $jobid = $dep_row["job_id"];
			$totPages = $dep_row["total_pages"];
            $wquery = "SELECT * FROM bi_job_split_worklog WHERE job_id ='".$jobid."' AND split_id ='".$dep_row["split_id"]."' AND status=true";
            $workLogId = "";
            $startTime = "";
            $workedPages = 0;
            if($wresult = mysqli_query($conn, $wquery)){
                while($wrow = mysqli_fetch_array($wresult, MYSQLI_ASSOC)) {
                    if($wrow["end_time"] == ""){
                        $workLogId = $wrow["work_log_id"];
                        $startTime = date('D M d Y H:i:s O',strtotime($wrow["start_time"]));
                    }
                    $workedPages = $workedPages + (int)$wrow["page_count"];
                }
            }?>
            <span id="idRemainPages<?=$j?>"><?php echo ($totPages-$workedPages);?></span>
            
            </td>  

            <?php
                $equery = "SELECT process_name, process_cat FROM bi_process_info WHERE proc_order ='" . $dep_row["process_id"] . "' and  process_cat='".$dep_row["process_cat"]."'";
                $eresult = mysqli_query($conn, $equery);
                while ($erow = mysqli_fetch_array($eresult, MYSQLI_ASSOC)) {
            ?>
                     <td><?= $erow["process_cat"] ?></td>
                    <td><?= $erow["process_name"] ?></td>
            <?php
            }
            ?>
                                
            <?php
            $equery = "SELECT full_name FROM bi_user_info WHERE user_id ='" . $dep_row["user_id"] . "'";
            $eresult = mysqli_query($conn, $equery);
            while ($erow = mysqli_fetch_array($eresult, MYSQLI_ASSOC)) {
            ?>
                <td><?= $erow["full_name"] ?></td>
            <?php
            }
            ?>

            <?php
            $equery = "SELECT full_name FROM bi_user_info WHERE user_id ='" . $dep_row["rep_manager_id"] . "'";
            $eresult = mysqli_query($conn, $equery);
            while ($erow = mysqli_fetch_array($eresult, MYSQLI_ASSOC)) {
            ?>
                <td><?= $erow["full_name"] ?></td>
            <?php
            }
            ?>
                
            

			<td>
           <div style="width:150px;">
            <input type="hidden" name="workLogId<?=$j?>" id="workLogId<?=$j?>" value="<?=$workLogId?>" />
            <input type="hidden" name="workJobId<?=$j?>" id="workJobId<?=$j?>" value="<?=$jobid?>" />
            <input type="hidden" name="workSplitId<?=$j?>" id="workSplitId<?=$j?>" value="<?=$dep_row["split_id"]?>"/>             

            <button name="btnStartTimer" id="btnStartTimer<?=$j?>" class="btn btn-success" onclick="onStartTimer<?=$j?>('start','<?=$j?>');" <?=($startTime != "" ? "disabled='disabled'" : "")?>>Start</button>&emsp;

		    <button name="btnPauseTimer" id="btnPauseTimer<?=$j?>" class="btn btn-warning" onclick="onStartTimer<?=$j?>('pause','<?=$j?>');"<?=($startTime != "" ? "disabled='disabled'" : "")?>>pause</button> 
            
            <button name="btnEndTimer" id="btnEndTimer<?=$j?>" class="btn btn-danger" onclick="onStartTimer<?=$j?>('end','<?=$j?>');">End</button><br/><br/>
            </div>
            <input type="textbox" name="noOfPagesCount<?=$j?>" placeholder="No.Of Pages" id="noOfPagesCount<?=$j?>" class="form-control form-control-sm" style="<?=($startTime == "" ? "display:none":"")?>" />
            <div id="time-elapsed<?=$j?>"></div>
            <script> 
            var timer<?=$j?>;
             paused=false;
             var startDateTimeGlobal = 0;
            //alert(timer)
             //paused = false
            //var timer1=-1;
            function onStartTimer<?=$j?>(status,rowId,startDate,endDate){
                var pageValue = document.getElementById("noOfPagesCount"+rowId).value;
                var remainPages = document.getElementById("idRemainPages"+rowId).innerText;
                //alert(var timer)
                if(pageValue == "" && status == "end")
                {
                    alert("Please enter worked page count");
                    return false;
                }
				
                else if(status == "end"){
                    if(parseInt(pageValue) > parseInt(remainPages)){
                        alert("Please enter valid page count");
                        return false;
                    }

                }
                var jobid = document.getElementById("workJobId"+rowId).value;
                var workLogId = document.getElementById("workLogId"+rowId).value;
                var noOfPagesCount = document.getElementById("noOfPagesCount"+rowId).value;
                var workSplitId = document.getElementById("workSplitId"+rowId).value;
				 var noOfremainPages = parseInt(remainPages) - parseInt(pageValue);
                if(startDate == undefined || startDate == null){   
                //alert(jobid)               
                    $.ajax({
                        method:"GET",
                        url:"job-split-timer.php",
                        data:{status:status,jobid:jobid,workLogId:workLogId,workSplitId:workSplitId,noOfPagesCount:noOfPagesCount,noOfremainPages:noOfremainPages},
                        success:function (result){
                            debugger;
                            if(result != null && result != ""){                            
                               // alert(result);
								workLogId = result;
                                $("#btnStartTimer"+rowId).prop("disabled",true);
                                if(status == "end"){
                                    alert("Process updated successfully");
                                    window.location.href="";
                                }
                                document.getElementById("noOfPagesCount"+rowId).style.display = "block";
                                document.getElementById("workLogId"+rowId).value = workLogId;
                            }

                        }
                    });
                }
                if(status == "end")
                {
                    clearInterval(timer<?=$j?>);
                    return false;
                }
                 if(status == "pause")
                {
                     
                    clearInterval(timer<?=$j?>);
                    paused=!paused;
                    if (!paused){
                          // clearInterval(timer<?=$j?>);
                             //clearTimeout(timer<?=$j?>);
                            var startStamp = startDateTimeGlobal;
                           // clearInterval(timer<?=$j?>);
                            //console.log(startDateTimeGlobal,paused,startStamp);

                            timer<?=$j?> = setInterval(function (){
                            newDate = new Date();
                            newStamp = newDate.getTime();
                            startDateTimeGlobal = startDateTimeGlobal+1;
                            var diff = startDateTimeGlobal;
                            
                            var d = Math.floor(diff/(24*60*60)); /* though I hope she won't be working for consecutive days :) */
                            diff = diff-(d*24*60*60);
                            var h = Math.floor(diff/(60*60));
                            diff = diff-(h*60*60);
                            var m = Math.floor(diff/(60));
                            diff = diff-(m*60);
                            var s = diff;    
                            document.getElementById("time-elapsed<?=$j?>").innerHTML = "<b>"+d+"</b> day(s),<b> "+(h < 10 ? ("0"+h) : h)+":"+(m < 10 ? ("0"+m) : m)+": "+(s < 10 ? ("0"+s) : s)+"</b>";
                            if(startStamp < endDateTime)
                                clearInterval(timer<?=$j?>);
                        }, 1000);
                    }
        
                    return false;
                
                }
           

                var startDateTime = new Date(); // (year,month,date,hours,minutes,seconds, milliseconds) (2020,1,8,23,59,59,0) YYYY (M-1) D H m s ms (start time and date from DB)
                if(startDate != undefined && startDate != null){
                    startDateTime = new Date(startDate);
                }
                
                    // startDateTimeGlobal = startDateTime;
                var endDateTime = (endDate != undefined && endDate != null) ? (new Date(endDate)) : (new Date(0));
                var startStamp = startDateTime.getTime();

                var newDate = new Date();
                var newStamp = newDate.getTime();

                // for storing the interval (to stop or pause later if needed)	
                timer<?=$j?> = setInterval(function (){
                    newDate = new Date();
                    newStamp = newDate.getTime();
                    
                    // var diff = Math.round((newStamp-startStamp)/1000);
                    startDateTimeGlobal = startDateTimeGlobal + 1;
                    var diff = startDateTimeGlobal;
                    console.log(startStamp,diff);
                    var d = Math.floor(diff/(24*60*60)); /* though I hope she won't be working for consecutive days :) */
                    diff = diff-(d*24*60*60);
                    var h = Math.floor(diff/(60*60));
                    diff = diff-(h*60*60);
                    var m = Math.floor(diff/(60));
                    diff = diff-(m*60);
                    var s = diff;    
                    document.getElementById("time-elapsed<?=$j?>").innerHTML = "<b>"+d+"</b> day(s),<b> "+(h < 10 ? ("0"+h) : h)+":"+(m < 10 ? ("0"+m) : m)+": "+(s < 10 ? ("0"+s) : s)+"</b>";
                    if(startStamp < endDateTime)
                        clearInterval(timer<?=$j?>);
                }, 1000);
            }
            </script>
            <?php
            if($startTime != ""){
            ?>
            <script>
                setTimeout(() => {
                    onStartTimer<?php echo $j; ?>('start','<?=$j?>','<?=$startTime?>');
                }); 
            </script>               
            <?php
            }
            ?>            
            </td>
            <td>
            <button type="button" class="btn btn-info" data-toggle="modal" data-target="#worklog-show-modal" onclick="onWorkLogShowUpdate('<?=$jobid?>','<?=$dep_row["split_id"]?>')"><i class="fa fa-info" aria-hidden="true"></i></button>
            </td>	
            <?php if($_SESSION["role"] == '3' OR $_SESSION["role"] == '4' OR $_SESSION["role"] == '5')
			{?>
            <td>
              <a href="#" name="editFile" id="editFile<?= $j ?>" onclick="onSplitShowUpdate('edit','<?=$jobid?>','<?= $dep_row["split_id"] ?>','','','');"><i class="fa fa-pencil-square-o" aria-hidden="true" display= "none"></i> Edit</a>
            </td>	

            <?php
            }
            ?>	

		</tr>

	<?php

	$j++;

	}

	?>

	</tbody>				

</table>
