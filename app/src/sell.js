const shipment = document.getElementById('shipment_input')
const outputtext = document.getElementById('end_val')
document.getElementById('send').onclick = decode;

var start_array = []

function decode() {
	console.log("works");
	//console.log(JSON.parse(shipment.value));

	//start_array = JSON.parse(shipment.value);
	//for (let i = 0; )

	start_array = shipment.value.split(" ").map(Number)
	start_array = shipment.value.split();
	for (let i = 0; i < start_array.length; i++)
		console.log(start_array[i]);
		console.log("ababarfer")
		console.log(start_array.length);

	//start_array = shipment.value.split();
	//for (let i = 0; i < start_array.length; i++)
	//	console.log(start_array[i]);
	//	console.log("ababarfer")
	//console.log(start_array.length);

	outputtext.textContent = shipment.value;
}

//[4, 72, -16, 7, 7]
//4 72 -16 7 7