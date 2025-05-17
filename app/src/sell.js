const shipment = document.getElementById('shipment_input');
const outputtext = document.getElementById('end_val');
const key = []
document.getElementById('send').onclick = decode;

let start_array = [];
let shipment_price = 0;

let valid_code = true;

function decode() {
	valid_code = true;
	//console.log(JSON.parse(shipment.value));

	//start_array = JSON.parse(shipment.value);
	//for (let i = 0; )
	start_array = shipment.value.trim().split(" ").map(Number)
	//start_array = shipment.value.split();
	for (let i = 0; i < start_array.length; i++) {
		let curnum = start_array[i]
		//console.log(curnum);
		//console.log("ababarfer");
		//console.log(start_array.length);

		if (isNaN(curnum)) {
			valid_code = false;
			console.log("nan in array");
		}

	}

	//console.log(start_array[start_array.length - 2]);
	if (start_array[start_array.length - 2] !== (10 - (start_array.length - 2))) {
		valid_code = false
		console.log(start_array.length - 2)
	}

	if (valid_code == true){
			_validcode();
	} else {
			_invalidcode();
	}

	//start_array = shipment.value.split();
	//for (let i = 0; i < start_array.length; i++)
	//	console.log(start_array[i]);
	//	console.log("ababarfer")
	//console.log(start_array.length);

	//outputtext.textContent = shipment.value;
}

function _validcode() {
	//outputtext.textContent = shipment.value;
	console.log("valid_code");
	outputtext.textContent = "";
	for (let i = 0; i < start_array.length; i++) {
		outputtext.textContent = outputtext.textContent + String(start_array[i]);


	}
}

function _invalidcode() {
	outputtext.textContent = "Invalid Code"
}
//[4, 72, -16, 7, 7]
//4 72 -16 7 7