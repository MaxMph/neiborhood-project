//const { app } = require("electron");

//const { app } = require("electron");

// import music from "./First Project!!!!!!! cut 1.mp3"
const shipment = document.getElementById('shipment_input');
const outputtext = document.getElementById('end_val');
const sell_button = document.getElementById('sell');
const ballance = document.getElementById('ballance');
const key = [-4, 8, 2, -3, 6, 1]
document.getElementById('send').onclick = code_tested;
sell_button.onclick = sold;

document.getElementById('reset').onclick = clear_ballance;

let start_array = [];
let shipment_price = 0;
let used_ids = [];
let id = 0


document.addEventListener("DOMContentLoaded", function() {
	set_ballance();
	//background_music
})


// function background_music() {
// 	new Audio(music)
// }


function clear_ballance() {
	window.api.set_money(0);
	set_ballance();
}

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

	id = start_array[start_array.length - 1]

	for (let i = 0; i < used_ids.length; i++)
		if (id == used_ids[i]) {
			valid_code = false
			console.log("this holdup is because of id stuff")
		}

	//check if code length is validated
	if (start_array[start_array.length - 2] !== (10 - (start_array.length - 2))) {
		valid_code = false;
		console.log(start_array.length - 2);
	}

	return valid_code;
}

function decode(){
	
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
	final_value = Number(final_text)
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

async function sold() {
		//let stored_money = await window.api.get_money('money');
	//ballance.textContent = stored_money || '(No value)';
	//ballance.textContent = "20"
	//app.getPath("userData")
	//console.log(window.api);
	//console.log(final_value);
	//window.api.set_money(final_value);// + stored_money);
		//window.api.set_money(final_value + stored_money);
	//console.log(window.api.get_money());
		//ballance.textContent = stored_money; //final_value + stored_money;
	
	//ballance.textContent = String(final_value + stored_money);
	//ballance.textContent = String(window.api.get_money());

	// console.log(window.api.get_money())
	// console.log(window.api.get_money())
	//console.log(window.storageAPI.get_money)
	//  let stored_money = window.;
	//  if (window.storageAPI.getMoney) {
	//  	storage.set('money', final_value + stored_money);
	//  	console.log();
	//  }
	let stored_money = await window.api.get_money('money');

	await window.api.set_money(final_value + stored_money);

	//let stored_ids = await window.api.get_sell_ids();
	used_ids.push(id)
	
	await window,api.set_sell_ids(used_ids);

	set_ballance()
	
	outputtext.textContent = "";
	sell_button.disabled = true;
}

async function set_ballance() {
	used_ids = await window.api.get_sell_ids()
	ballance.textContent = "$" + await window.api.get_money();
}