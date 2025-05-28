const notes_input = document.getElementById('notes_input');
const spell_correct = document.getElementById('spellcorrect');
const page_height = document.getElementById('page_height');
notes_input.addEventListener("input", savetext);
spell_correct.addEventListener("input", update_settings);
page_height.addEventListener("input", update_settings);

document.addEventListener("DOMContentLoaded", function() {
	page_height.value = 20
	spell_correct.checked = true
	loadtext();
	update_settings();
})

async function loadtext() {
	notes_input.value = await window.api.get_notes();
}

async function savetext() {
	await window.api.set_notes(notes_input.value);
	console.log(notes_input.value)
	//console.log("ooogabooga")
}

function update_settings() {
	notes_input.spellcheck = spell_correct.checked;
	// console.log(notes_input.spellcheck);
	// console.log(spell_correct.checked);
	//notes_input.style.height = page_height + "px"
	//console.log(notes_input.style.height)
	notes_input.setAttribute('rows', page_height.value);
}
