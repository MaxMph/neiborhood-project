 
const money_text = document.getElementById('balance');
const freemoneybutton = document.getElementById('calc_money');
var money = 0
money_text.textContent = "$0";

freemoneybutton.onclick = calc_money;
document.onCl

function calc_money() {
    console.log("IIFE executed");
    money += 12;
    money_text.textContent = "$" + String(money);
}
