// JavaScript Document

// JavaScript Document
// JavaScript Document
$(function(){
//	$("#btn_file_Submit").click(function(){
//	var delete_validation_cookie = 'tabchanges_'+$("#job_cmr").val();
//	$.removeCookie(delete_validation_cookie, { path: '/' });
//		
//	});
    $('#btn_file_Attach').click(function( objEvent ){
    //	$(':button[id* = "btn_file_"]').click(function( objEvent ){   
        $("#istabChanged").val("false");
        $("#loading-Tabs").show();
        $('#loading-Tabs-Page-File').show();
        if(this.id == 'btn_file_Attach' && $("#UploadFile").val().indexOf("..")!=-1){
            $('#loading-Tabs-Page-File').hide();
            alert("You can not have 2 consecutive periods in a file name.  Please rename the file then browse, select, and attach it again.");
            $("#loading-Tabs").hide();
        }
        else if(this.id == 'btn_file_Attach' && $("#UploadFile").val().length==0){
            $('#loading-Tabs-Page-File').hide();
            alert("Please select a file to attachment.");
            $("#loading-Tabs").hide();
        }
    <!--- LSC:  2006.02.08 (#784039)  Add js test and message for # (skf)  start mod --->
        else if(this.id == 'btn_file_Attach' && $("#UploadFile").val().indexOf("#")!=-1) {
            $('#loading-Tabs-Page-File').hide();
            alert("You can not have a Pound (#) sign in a file name.  Please rename the file then browse, select, and attach it again.");
            $("#loading-Tabs").hide();
        }
    <!--- LSC:  2006.02.08 (#784039)  Add js test and message for # (skf)  end mod --->
        else if(this.id == 'btn_file_Attach')  
            {	  
            $(this).hide();
            var strName = ("uploader" + (new Date()).getTime());
            var iframe = $('<iframe name="' + strName + '" id="' + strName + '" style="display: none"></iframe>');
            $("body").append(iframe);
            var form = $('#frmUpload');
            var fd = new FormData();
            fd.append("job_cmr", $('#job_cmr').val());
            fd.append("do_upload", true);
            fd.append("AttachmentDescription",document.getElementsByName("AttachmentDescription")[0].value);
            fd.append("UploadFile", document.getElementById('UploadFile').files[0]);
            var xhr = new XMLHttpRequest();
            xhr.upload.addEventListener("progress", uploadProgress, false);
            xhr.addEventListener("load", uploadComplete, false);
            xhr.open("POST", "UpLoadFile.cfm");
            xhr.send(fd);

            function uploadProgress(evt) 
            {
                if (evt.lengthComputable) 
                {
                    var percentComplete = Math.round(evt.loaded * 100 / evt.total) + '%';
                    if($('#load-percentage').length){
                        $( "#load-percentage" ).empty();
                        $( "#load-percentage" ).append(percentComplete);
                    }
                    else{
                        $( "#loading-Tabs" ).append( "<span id = 'load-percentage' style='font-size: 18px;'>Loading....</span>" );
                    }
                    //console.log(percentComplete);
                }
            }

            function uploadComplete(evt) 
            {
                $( "#load-percentage" ).empty();
                $('#loading-Tabs-Page-File').hide();
                var current_index = $("#tabs").tabs("option","selected");
                $("#tabs").tabs('load',current_index);
            }
            }
	});
	$("#loading-Tabs").hide();
});
