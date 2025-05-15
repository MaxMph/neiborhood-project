
const shipment = document.getElementById('shipment_input')
const outputtext = document.getElementById('end_val')
document.getElementById('send').onclick = decode;

var start_array = []

function decode() {
	console.log("works");
	start_array = shipment.value.split();
	for (let i = 0; i < start_array.length; i++)
		console.log(start_array[i]);
		console.log("ababarfer")
		console.log(start_array.length)

	outputtext.textContent = shipment.value;
}

//[4, 72, -16, 7, 7]