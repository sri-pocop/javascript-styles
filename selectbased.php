<script>
function changeSelect(val){
    var options = '<option value="">select</option>';
    if(val == ""){
    }else if(val == "1"){
        options = options + '<option value="1">BullDog</option>';
        options = options + '<option value="2">Labrador</option>';
        options = options + '<option value="3">Shepherd</option>';
    }else if(val == "2"){
        options = options + '<option value="1">Ragdoll</option>';
        options = options + '<option value="2">Scottish</option>';
        options = options + '<option value="3">Manx</option>';
    }else if(val == "3"){
        options = options + '<option value="1">American</option>';
        options = options + '<option value="2">Fuzzy lop</option>';
    }
        document.getElementById("select2").innerHTML = options;
        return false;
}
</script>
<select name="select1" onchange="changeSelect(this.value)">
    <option value="">select</option>
    <option value="1">dog</option>
    <option value="2">cat</option>
    <option value="3">rabit</option>
</select>
<select name="select2" id="select2">
    <option value="">select</option>
</select>
