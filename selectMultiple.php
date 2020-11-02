<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
<script>
function getval(){
	var values = $('#sel').val();
	// var values = document.getElementById("sel").val();
	document.getElementById("values_sel").innerHTML = values;
}
</script>
<select id="sel" multiple="multiple">
    <option value="1">Breakfast</option>
    <option value="2">Lunch</option>
    <option value="3">Dinner</option>
    <option value="4">Snacks</option>
    <option value="5">Dessert</option>
</select>
<button onclick="getval()">get</button>
<div id="values_sel"></div>
