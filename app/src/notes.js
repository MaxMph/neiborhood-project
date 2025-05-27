const notes_input = document.getElementById('notes_input');
const spell_correct = document.getElementById('spellcorrect');
const page_height = document.getElementById('page_height');
notes_input.addEventListener("input", savetext);
spell_correct.addEventListener("input", update_settings);
page_height.addEventListener("input", update_settings);

document.addEventListener("DOMContentLoaded", function() {
	loadtext();
})

async function loadtext() {
	notes_input.value = await window.api.get_notes();
}

async function savetext() {
	await window.api.set_notes(notes_input.value);
	console.log(notes_input.value)
	//console.log("ooogabooga")
}

