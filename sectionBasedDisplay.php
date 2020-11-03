<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
<script>
function getval(){
	var values = $('#sel').val();
	// var values = document.getElementById("sel").val();
	document.getElementById("values_sel").innerHTML = values;
}
function fnShow2(){
	var val = document.getElementById("sel1").checked;
	var val1 = document.getElementById("ssel1").value;
	if(val && val1 != ""){
		document.getElementById("sub2").style.display = "block";
	}else{
		document.getElementById("sub2").style.display = "none";
		document.getElementById("sub3").style.display = "none";
		document.getElementById("res").style.display = "none";
	}
	
}

function fnShow3(){
	var val = document.getElementById("sel2").checked;
	var val1 = document.getElementById("ssel1").value;
	if(val && val1 != ""){
		document.getElementById("sub3").style.display = "block";
	}else{
		document.getElementById("sub3").style.display = "none";
		document.getElementById("res").style.display = "none";
	}
}

function fnShowRes(){
	var val = document.getElementById("sel3").checked;
	var val1 = document.getElementById("ssel3").value;
	if(val && val1 != ""){
		document.getElementById("res").style.display = "block";
	}else{
		document.getElementById("res").style.display = "none";
	}
}
</script>
<div id="values_sel"></div>

<div id="sub1">
	<fieldset>
		First Section :
		<input type="checkbox" name = "sel1" id="sel1" onchange="fnShow2()">
		<br>
		Select somthing: 
		<select id="ssel1" onchange="fnShow2()">
			<option value="">-Select-</option>
		    <option value="1">Breakfast</option>
		    <option value="2">Lunch</option>
		    <option value="3">Dinner</option>
		    <option value="4">Snacks</option>
		    <option value="5">Dessert</option>
		</select>
	</fieldset>
</div>
<div id="sub2" style="display:none">
	<fieldset>
		Second Section :
		<input type="checkbox" name = "sel2" id="sel2" onchange="fnShow3()">
		<br>
		Select somthing: 
		<select id="ssel2" onchange="fnShow3()">
			<option value="">-Select-</option>
		    <option value="1">Breakfast</option>
		    <option value="2">Lunch</option>
		    <option value="3">Dinner</option>
		    <option value="4">Snacks</option>
		    <option value="5">Dessert</option>
		</select>
	</fieldset>	
</div>
<div id="sub3" style="display:none">
	<fieldset>
		Third Section :
		<input type="checkbox" name = "sel3" id="sel3" onchange="fnShowRes()">
		<br>
		Select somthing: 
		<select id="ssel3" onchange="fnShowRes()">
			<option value="">-Select-</option>
		    <option value="1">Breakfast</option>
		    <option value="2">Lunch</option>
		    <option value="3">Dinner</option>
		    <option value="4">Snacks</option>
		    <option value="5">Dessert</option>
		</select>
	</fieldset>				
</div>
<div id="res" style="display:none">
	<fieldset>
		Last Section : All section completed
	</fieldset>
</div>
