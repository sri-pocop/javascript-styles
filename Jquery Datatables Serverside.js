$(document).ready(function() {
		//$('#loading-image').show();
		var params={'ACTION':'DEFAULT_LOAD'};
		$('#Resultpage').DataTable({
			'dom': '<"top">rt<"bottom"lip><"clear">',
			'bServerSide': true,
			'bProcessing':true,
			"iDisplayLength": 10,
			"sPaginationType": "full_numbers",
			 "columnDefs": [
				{"className": "dt-center", "targets": "_all"}
			],
			"fnServerParams": function ( aoData ) {
				aoData.push( { "name": "ACTION", "value": "DEFAULT_LOAD" } );
				},
			'aoColumns': [
				{ "sName": 'EXCHANGE' },
				{ "sName": 'STATE_ID' },
				{ "sName": 'CONTRACT' },
				{ "sName": 'START_DATE' },
				{ "sName": 'END_DATE' },
				{ "sName": 'ACTION',"bSortable": false,"mRender": function ( data, type, full) 
					{
						return "<a href='' onClick=\"javascript:if('IE'){HelpWindow1=window.open('ospworkflow/bdwo/Editexchange.cfm?S_NO="+data+"','HelpWindow1','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=950,height=500'); return false;}else{HelpWindow1=window.open('ospworkflow/bdwo/Editexchange.cfm?="+data+"','HelpWindow1','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=950,height=500'); return false;}\">Edit</a>" 
					}
				},
			],
			"sServerMethod": "POST",
    		'sAjaxSource': "ospworkflow/bdwo/exchangesearchresult.cfm",
		});
    });
