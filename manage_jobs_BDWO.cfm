  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
  <cfparam name="Isupdate" default="0">
  <html>
  <head>
  <CFINCLUDE TEMPLATE="../../include-GlobalVariables.cfm">
  <CFINCLUDE TEMPLATE="../../include-BaseHref.cfm">
  <CFINCLUDE TEMPLATE="../../include-StyleSheet.cfm">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <script type="text/javascript" charset="utf-8" src="jquery.js"></script>
  <title>Manage Copy or Cancel the BDWO jobs</title>
  <script type="text/javascript">
    function ValidateSearch()
    {
        var job_number = document.getElementById("job_number").value;
        if(job_number.length == 14)
        {
            searchJob();
        }
        else if(job_number == "")
        {
            $('#search_result').empty();
            alert("Please enter Job number..");
            return false;
        }
        else
        {
            validationAlert("Job number should contain 14 characters","show");
            $('#search_result').empty();
            return false;
        }
    } 
    function validationAlert(content,action)
    {
        var alertId = '#validation_alert';
        if(action="show")
        {
            $(alertId).empty();
            $(alertId).show();
            $(alertId).append(content);	
        }
        else if(action="hide")
        {
            $(alertId).empty();
        }
        setTimeout(function () {
            $(alertId).hide();
        }, 8000);
    }
    function ClearSearch() 
    {
        document.getElementById("job_number").value="";
    }
    function isNumber(evt) 
    {
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if(charCode == 13)
        {
            ValidateSearch();
        }
        else if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
        return true;
    }
    function searchJob()
    {
            var job_number= $("#job_number").val();
			var params={'JOB_NUMBER':job_number,'ACTION':'SEARCH'};
                $.ajax({
                url: 'ospworkflow/bdwo/manage_jobs_BDWO_Ajax.cfm',
                type : "POST",
                data: params,
                success: function(result)
                {
                        $('#search_result').empty();
                        $('#search_result').append(result);					
                }});
    }
  </script>
  <style>
    .displayContent{
        display : block;
    }
    .hideContent{
        display : none;
    }
  </style>
  </head>
  <body>

  <CFINCLUDE TEMPLATE="../../include-imagescript.cfm">
  <CFINCLUDE TEMPLATE="../../include-bodytag.cfm">
  <CFINCLUDE TEMPLATE="../../include-navbar.cfm">
  <br>
  <cfquery name="manage_tax_query" datasource = "#DatabaseName#">    
    SELECT MT.ID,MT.STATE_NAME,TS.STATE_DESC,MT.SBID,MT.PMR, MT.LABOUR_TAX, MT.MATERIAL_TAX, MT.HANDLE
    FROM #TablespaceOSP#.MANAGETAX MT join #TablespaceOSP#.TBL_STATES TS
    on TS.STATE_NAME = MT.STATE_NAME
  </cfquery>
  <table width="80%" align="center">
        <tr>
            <td class="label" align="center" colspan="2"><h2> Manage Copy or Cancel the BDWO jobs</h2></td>
        </tr>
        <tr>
            <td align="right">
                <a href="OSPWorkflow\BDWO\admin.cfm">Return to BDWO Administration</a>
            </td>
            <td></td>
        </tr>
    </table>
    <br>
    <table width="50%" align="center" class="table" cellpadding="3" cellspacing="0">   
        <tbody>
            <tr>
                <td colspan="2">
                    <div align="center">
                        &nbsp;<span id="validation_alert" align="center" style="color:red"></span>&nbsp;
                        <br>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Enter job Number to Search: 
                </td>
                <td align="left">
                    <input type="text" name = "job_number" id = "job_number" minlength="14" maxlength="14" onkeypress="return isNumber(event)" autocomplete="off">
                </td>
            </tr>
            <tr>
                <td><br></td>
                <td></td>
            </tr>
            <tr>
                <td align="right">
                    <input type = "button" name = "search_clear" id = "search_clear" onclick="ClearSearch()" value = "Clear">
                </td>
                <td align="left">
                    <input type = "button" name = "search_job" id = "search_job" onclick="ValidateSearch()" value = "Search">
                </td>
            </tr>
        </tbody>
    </table>
    <div id="search_result">
    </div>

  <CFINCLUDE TEMPLATE="../../footer.cfm">
  </body>
  </html>
