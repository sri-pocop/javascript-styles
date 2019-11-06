  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
  <cfparam name="Isupdate" default="0">
  <html>
  <head>
  <CFINCLUDE TEMPLATE="../../include-GlobalVariables.cfm">
  <CFINCLUDE TEMPLATE="../../include-BaseHref.cfm">
  <CFINCLUDE TEMPLATE="../../include-StyleSheet.cfm">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <script type="text/javascript" charset="utf-8" src="jquery.js"></script>
  <title>Manage units allowed for BDWO jobs</title>
  <script type="text/javascript">
  function UnCheckOther(firstId,secondId)
  {
      if(document.getElementById(firstId).checked)
      {
          document.getElementById(secondId).checked = false;
      }
      else
      {
          document.getElementById(secondId).checked = true;
      }
  }
    function AddUnitRow()
    {
        removeClass('.new_entry','hideContent');
        recordCount = document.getElementById("recordCountOfUnits").value;
        for (span_class = 1;span_class <= recordCount;span_class++)
        {
            var class_name_default = ".default_span_"+span_class;
            var class_name_edit = ".edit_span_"+span_class;
            removeClass(class_name_default,'hideContent');
            addClass(class_name_default,'displayContent');
            removeClass(class_name_edit,'displayContent');
            addClass(class_name_edit,'hideContent');
        }
        
    }
    function CancelUnitRow()
    {
        //removeClass('.new_entry','displayContent');
        addClass('.new_entry','hideContent');
    }
    function selectUnitSeq(element)
    {
       document.getElementById("UNIT_SEQ").value = $(element). children("option:selected"). attr("u_seq");
    }
    function SaveUnit()
    {
        SaveUpdateUnit("ADD","_n");
    }
    function UpdateUnit(r_number,u_id)
    {
        SaveUpdateUnit("UPDATE","_"+r_number,u_id);
    }
    function SaveUpdateUnit(action_to_do,second_string,u_id)
    {
        var list_col = ['BURIED','AERIAL','FIBER_PREMISIS','FIXED_WIRELESS','GBOND','GPON_SMB_FIBER',
        'NEW','REPAIR','REPLACEMENT','PR2','PR6','FTTP','RG11','G1015','FW','BORE','GROUND_ROD','GROUND_WIRE',
        'CUTOVER_INITIAL_DROP','CUTOVER_ADDITIONAL_DROP','RISER_GUARD','GOPHER','STATUS'];
        if(document.getElementById("select_unit_id").value == "" && action_to_do == "ADD")
        {
            alert("Unit ID is Empty");
            //alert(document.getElementById("inp1").value);
            document.getElementById("select_unit_id").focus();
            return false;
        }
        else{
            if(action_to_do == "ADD")
            {
                document.getElementById("UNIT_ID").value = document.getElementById("select_unit_id").value;
            }else{
                document.getElementById("UNIT_ID").value = u_id;
            }
            for ( i=0; i<list_col.length; i++) 
            {
                if(document.getElementById(list_col[i]+second_string).checked)
                {
                    document.getElementById(list_col[i]).value = "1";
                }
            }
            document.getElementById("submit_action").value = action_to_do;
            document.forms["SubmitData"].submit();
            return true;
        }
        return false;
    }
    function editview(passedClass1,passedClass2,recordCount)
    {
        //alert(passedClass);
      //$(".passedClass").css("pointer-events:n ");
      //document.querySelectorAll(".edit_span_1").style.display="block";
      addClass('.new_entry','hideContent');
      for (span_class=1;span_class<=recordCount;span_class++)
      {
        var class_name_default = ".default_span_"+span_class;
        var class_name_edit = ".edit_span_"+span_class;
        if(class_name_default == passedClass1)
        {
            removeClass(passedClass2,'hideContent');
            addClass(passedClass2,'displayContent');
            removeClass(passedClass1,'displayContent');
            addClass(passedClass1,'hideContent');
        }
        else
        {
            removeClass(class_name_edit,'displayContent');
            addClass(class_name_edit,'hideContent');
            removeClass(class_name_default,'hideContent');
            addClass(class_name_default,'displayContent');
        }
          
      }
    }
    function defaultview(passedClass2,passedClass1,recordCount)
    {
      removeClass(passedClass1,'displayContent');
      addClass(passedClass1,'hideContent');
      removeClass(passedClass2,'hideContent');
      addClass(passedClass2,'displayContent');     
    }
    function removeClass(elements, myClass) 
    {
        // if there are no elements, we're done
        if (!elements) { return; }

        // if we have a selector, get the chosen elements
        if (typeof(elements) === 'string') {
            elements = document.querySelectorAll(elements);
        }

        // if we have a single DOM element, make it an array to simplify behavior
        else if (elements.tagName) { elements=[elements]; }

        // create pattern to find class name
        var reg = new RegExp('(^| )'+myClass+'($| )','g');

        // remove class from all chosen elements
        for (var i=0; i<elements.length; i++) {
            elements[i].className = elements[i].className.replace(reg,' ');
        }
    }

    function addClass(elements, myClass) 
    {
        // if there are no elements, we're done
        if (!elements) { return; }

        // if we have a selector, get the chosen elements
        if (typeof(elements) === 'string') {
            elements = document.querySelectorAll(elements);
        }

        // if we have a single DOM element, make it an array to simplify behavior
        else if (elements.tagName) { elements=[elements]; }

        // add class to all chosen elements
        for (var i=0; i<elements.length; i++) {

            // if class is not already found
            if ( (' '+elements[i].className+' ').indexOf(' '+myClass+' ') < 0 ) {

            // add class
            elements[i].className += ' ' + myClass;
        }
    }
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
    <cfquery name = "query_bdwo_osp_units" datasource = "#DatabaseName#">
      select 
        UNIT_SEQ, UNIT_ID, STATUS, BURIED, AERIAL, FIBER_PREMISIS, FIXED_WIRELESS,GBOND, GPON_SMB_FIBER,  
        NEW, REPAIR, REPLACEMENT, PR2, PR6, FTTP, RG11, G1015, FW, BORE, GROUND_ROD, GROUND_WIRE,  
        CUTOVER_INITIAL_DROP, CUTOVER_ADDITIONAL_DROP, RISER_GUARD,GOPHER 
      from #TableSpaceOSP#.BDWO_MANAGE_OSP_UNITS
      ORDER BY ID
    </cfquery>
    <cfquery name="query_osp_unit_id" datasource = "#DatabaseName#">
        select OU.UNIT_SEQ,OU.UNIT_ID,OU.UNIT_DESCRIPTION 
        from #TableSpaceOSP#.OSP_UNITS OU
        where OU.STATUS = 1 and OU.UNIT_ID NOT IN (SELECT UNIT_ID FROM #TableSpaceOSP#.BDWO_MANAGE_OSP_UNITS MOU)
    </cfquery>
    <cfset column_list=['BURIED','AERIAL','FIBER_PREMISIS','FIXED_WIRELESS','GBOND','GPON_SMB_FIBER',
'NEW','REPAIR','REPLACEMENT','PR2','PR6','FTTP','RG11','G1015','FW','BORE','GROUND_ROD','GROUND_WIRE',
'CUTOVER_INITIAL_DROP','CUTOVER_ADDITIONAL_DROP','RISER_GUARD','GOPHER']>

    <cfset column_list_header=['UNIT ID','BURIED','AERIAL','Fiber to the premisis',
    'Fixed Wireless','GBOND','GPON/ SMB Fiber','New','Repair','Replace ment','2PR','6PR','FTTP','RG11','1015',
    'FW','BORE','Ground Rod','Ground Wire','Cutover Initial Drop','Cutover Additional Drop','Riser Guard','Gopher','Status']>

<form id="SubmitData" name="SubmitData" method="post" action="OSPWorkflow\BDWO\manage_units_BDWO_Update.cfm">
<input type="hidden" name="BURIED" id="BURIED" value="">
<input type="hidden" name="AERIAL" id="AERIAL" value="">
<input type="hidden" name="FIBER_PREMISIS" id="FIBER_PREMISIS" value="">
<input type="hidden" name="FIXED_WIRELESS" id="FIXED_WIRELESS" value="">
<input type="hidden" name="GBOND" id="GBOND" value="">
<input type="hidden" name="GPON_SMB_FIBER" id="GPON_SMB_FIBER" value="">
<input type="hidden" name="NEW" id="NEW" value="">
<input type="hidden" name="REPAIR" id="REPAIR" value="">
<input type="hidden" name="REPLACEMENT" id="REPLACEMENT" value="">
<input type="hidden" name="PR2" id="PR2" value="">
<input type="hidden" name="PR6" id="PR6" value="">
<input type="hidden" name="FTTP" id="FTTP" value="">
<input type="hidden" name="RG11" id="RG11" value="">
<input type="hidden" name="G1015" id="G1015" value="">
<input type="hidden" name="FW" id="FW" value="">
<input type="hidden" name="BORE" id="BORE" value="">
<input type="hidden" name="GROUND_ROD" id="GROUND_ROD" value="">
<input type="hidden" name="GROUND_WIRE" id="GROUND_WIRE" value="">
<input type="hidden" name="CUTOVER_INITIAL_DROP" id="CUTOVER_INITIAL_DROP" value="">
<input type="hidden" name="CUTOVER_ADDITIONAL_DROP" id="CUTOVER_ADDITIONAL_DROP" value="">
<input type="hidden" name="RISER_GUARD" id="RISER_GUARD" value="">
<input type="hidden" name="GOPHER" id="GOPHER" value="">
<input type="hidden" name="STATUS" id="STATUS" value="">
<input type="hidden" name="UNIT_ID" id="UNIT_ID" value="">
<input type="hidden" name="UNIT_SEQ" id="UNIT_SEQ" value="">
<input type="hidden" name="submit_action" id="submit_action" value=""> 
<input type="hidden" id="recordCountOfUnits" value="<cfoutput>#query_bdwo_osp_units.recordcount#</cfoutput>">

<table width="80%" align="center">
	<tr>
		<td class="label" align="center" colspan="2"><h2>Manage OSP units for BDWO jobs</h2></td>
	</tr>
    <tr>
        <td align="right">
            <a href="OSPWorkflow\BDWO\admin.cfm">Return to BDWO Administration</a>
        </td>
        <td></td>
    </tr>
    <tr>
        <td colspan="3"><span id="error_message"></span></td>
        <td align="right" valign="center" nowrap>
            <input type="button" value="Add New Unit" name="btn_addunit" id="btn_addunit" title="Click here to create add Unit" onclick="AddUnitRow()">
        </td>   
    </tr>
</table>
    <table width="100%" id="manageReasonCode" align="center" class="table" cellpadding="3" cellspacing="0">
 	    <thead>
	        <tr>
                <cfloop array="#column_list_header#" index="col">
                    <cfoutput><td width="6%" class="heading">#col#</td></cfoutput>
                </cfloop>
                <td width="6%" class="heading">Action</td>
                <!---<td class="heading">Action</td>--->
            </tr>
        </thead>
        <tbody>
            <tr class="new_entry hideContent">
                <td align="center" width="6%" class="detail0">
                    <select name="select_unit_id" id="select_unit_id" autocomplete="off" onchange="selectUnitSeq(this)">
                        <option value="" u_seq="">Select</option>
                        <cfoutput query="query_osp_unit_id">
                            <option value="#query_osp_unit_id.UNIT_ID#" u_seq="#query_osp_unit_id.UNIT_SEQ#">#query_osp_unit_id.UNIT_ID#</option>
                        </cfoutput> 
                    </select>
                </td>
                <cfset new_record=1>
                <cfloop array="#column_list#" index="col">
                    <td align="center" width="6%" class="detail0">
                        <cfoutput><input type="checkbox" name="#col#_n" id="#col#_n" autocomplete="off"></cfoutput>
                        <cfset new_record = new_record+1>
                    </td>
                </cfloop>
                <td align="center" width="6%" class="detail0">
                    <span class="">
                        Active<cfoutput><input type="checkbox" name="STATUS_n" id="STATUS_n" onchange="UnCheckOther('STATUS_n','STATUS_d_n')" autocomplete="off" checked></cfoutput><br>
                        InActive<cfoutput><input type="checkbox" name="STATUS_d_n" id="STATUS_d_n" onchange="UnCheckOther('STATUS_d_n','STATUS_n')" autocomplete="off"></cfoutput>
                    </span>
                </td>
                <td align="center" width="6%" class="detail0">
                    <span class="">
                        <a href = "javascript:void(0);" style="font-size:8pt;" onclick="SaveUnit()" name="Save" title="Save">Save</a><br>
                        <a href = "javascript:void(0);" style="font-size:8pt;" onclick="CancelUnitRow()" title="Cancel">Cancel</a>
                    </span>
                </td>
            </tr>
            <cfoutput query="query_bdwo_osp_units">
                <cfset row_number = query_bdwo_osp_units.CurrentRow>
                <cfset rowMod = query_bdwo_osp_units.CurrentRow Mod 2>
                <tr>
                    <!---<td align="center" width="6%" class="detail#rowMod#">
                        <span>
                            #query_bdwo_osp_units.UNIT_SEQ#
                        </span>
                    </td>--->
                    <td align="center" width="6%" class="detail#rowMod#">
                        <span>
                            #query_bdwo_osp_units.UNIT_ID#
                        </span>
                    </td>
                    <cfloop array="#column_list#" index="col">
                        <cfset col_name_val = #query_bdwo_osp_units[col][currentrow]#>
                        <td align="center" width="6%" class="detail#rowMod#">
                            <span class="default_span_#row_number# displayContent">
                                <cfif col_name_val eq '1'>
                                    <span style="color:blue">&check;&nbsp;</span>
                                <cfelseif col_name_val eq '0' or col_name_val eq ''>
                                    
                                </cfif>
                            </span>
                            <span class="edit_span_#row_number# hideContent">
                                <cfif col_name_val eq '1'>
                                    <input type="checkbox" name="#col#_#row_number#" id="#col#_#row_number#" autocomplete="off" checked>
                                <cfelseif col_name_val eq '0' or col_name_val eq ''>
                                    <input type="checkbox" name="#col#_#row_number#" id="#col#_#row_number#" autocomplete="off">
                                </cfif>
                            </span>
                        </td>
                    </cfloop>
                    <td align="center" width="6%" class="detail#rowMod#">
                    <span class="default_span_#row_number# displayContent">
                        <cfif query_bdwo_osp_units.STATUS eq 1>
                            Active
                        <cfelse>
                            Inactive
                        </cfif>
                    </span>
                    <span class="edit_span_#row_number# hideContent">
                        Active<input type="checkbox" name="STATUS_#row_number#" id="STATUS_#row_number#" onchange="UnCheckOther('STATUS_#row_number#','STATUS_d_#row_number#')" autocomplete="off" <cfif query_bdwo_osp_units.STATUS eq 1>checked</cfif>><br>
                        InActive<input type="checkbox" name="STATUS_d_#row_number#" id="STATUS_d_#row_number#" onchange="UnCheckOther('STATUS_d_#row_number#','STATUS_#row_number#')" autocomplete="off" <cfif query_bdwo_osp_units.STATUS neq 1>checked</cfif>>
                    </span>
                    </td>
                    <td align="center" width="6%" class="detail#rowMod#">
                    <span class="default_span_#row_number# displayContent">
                        <a href = "javascript:void(0);" style="font-size:8pt;" onclick="editview('.default_span_#row_number#','.edit_span_#row_number#',#query_bdwo_osp_units.recordcount#)" title="Edit">Edit</a>
                    </span>
                    <span class="edit_span_#row_number# hideContent">
                        <a href = "javascript:void(0);" style="font-size:8pt;" onclick="UpdateUnit(#row_number#,'#query_bdwo_osp_units.UNIT_ID#')" title="Update">Update</a><br>
                        <a href = "javascript:void(0);" style="font-size:8pt;" onclick="defaultview('.default_span_#row_number#','.edit_span_#row_number#',#query_bdwo_osp_units.recordcount#)" title="Cancel">Cancel</a>
                    </span>
                    </td>
                <tr>
            </cfoutput>
        </tbody>
    </table>
    </form>
  <CFINCLUDE TEMPLATE="../../footer.cfm">
  </body>
  </html>
