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
						return "<a href='' onClick=\"javascript:if('IE'){HelpWindow1=window.open('Editexchange.cfm?S_NO="+data+"','HelpWindow1','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=950,height=500'); return false;}else{HelpWindow1=window.open('Editexchange.cfm?="+data+"','HelpWindow1','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=950,height=500'); return false;}\">Edit</a>" 
					}
				},
			],
			"sServerMethod": "POST",
    		'sAjaxSource': "ospworkflow/bdwo/exchangesearchresult.cfm",
		});
    });


//Sample JSON Response:
{
   "sEcho":5,
   "iTotalRecords":2313,
   "iTotalDisplayRecords":2313,
   "aaData":[
      [
         "LCLR-563289",
         "IA",
         "180702N1-IA",
         "11/01/2019",
         "12/04/2019",
         "160"
      ],
      [
         "GNCT-319824",
         "IA",
         "180702N1-IA",
         "11/01/2019",
         "",
         "161"
      ],
      [
         "OLEY-610987",
         "PA",
         "180626N2",
         "11/01/2019",
         "",
         "162"
      ],
      [
         "RYMN-402783",
         "NE",
         "180725N2-NE",
         "11/01/2019",
         "",
         "163"
      ],
      [
         "PRRT-229623",
         "GA",
         "181221N20-GA-S",
         "11/01/2019",
         "",
         "164"
      ],
      [
         "ODEN-870326",
         "AR",
         "180719N1-AR",
         "11/01/2019",
         "",
         "165"
      ],
      [
         "WMSN-641862",
         "IA",
         "180702N1-IA",
         "11/01/2019",
         "",
         "166"
      ],
      [
         "FRTN-319878",
         "IA",
         "180702N1-IA",
         "11/01/2019",
         "",
         "167"
      ],
      [
         "BBVL-606546",
         "KY",
         "180626N2-KY",
         "11/01/2019",
         "",
         "168"
      ],
      [
         "OKVL-319766",
         "IA",
         "180702N1-IA",
         "11/01/2019",
         "",
         "169"
      ]
   ]
}
