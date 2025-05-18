const shipment = document.getElementById('shipment_input');
const outputtext = document.getElementById('end_val');
const sell_button = document.getElementById('sell');
const key = [-4, 8, 2, -3, 6, 1]
document.getElementById('send').onclick = code_tested;
sell_button.onclick = sold;

let start_array = [];
let shipment_price = 0;

function code_tested() {
	if (check_validity() == true){
		_validcode();
	} else {
		_invalidcode();
	}
}

function check_validity() {
	let valid_code = true;

	start_array = shipment.value.trim().split(" ").map(Number)

	//check if code is all numbers
	for (let i = 0; i < start_array.length; i++) {
		let curnum = start_array[i]

		if (isNaN(curnum)) {
			valid_code = false;
			console.log("nan in array");
		}

	}

	//check if code length is validated
	if (start_array[start_array.length - 2] !== (10 - (start_array.length - 2))) {
		valid_code = false;
		console.log(start_array.length - 2);
	}

	return valid_code;
}

function decode(){
	let final_value = 0;
	let final_text = "";
	start_array.pop();
	start_array.pop();
	start_array = start_array.reverse();

	//final text setup
	for (let i = 0; i < start_array.length; i++) {
		start_array[i] = start_array[i] / key[i];
		final_text = final_text + String(start_array[i]);
		//final_value += start_array[i]
	}
	return final_text //String(final_value) //final_text
	//start_array.remove(start_array.lastIndex);
	//start_array.remove(start_array.lastIndex);
}

function _validcode() {
	console.log("valid_code");
	outputtext.textContent = "";
	outputtext.textContent = "$" + decode();
	sell_button.disabled = false;
}

function _invalidcode() {
	outputtext.textContent = "Invalid Code";
}
//[4, 72, -16, 7, 7]
//4 72 -16 7 7

function sold() {
	outputtext.textContent = "";
	sell_button.disabled = true;
}