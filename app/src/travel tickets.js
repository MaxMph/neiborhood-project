const ballance = document.getElementById('ballance');
const price1button = document.getElementById('price1');
const price2button = document.getElementById('price2');
const price3button = document.getElementById('price3');

const popup = document.getElementById('popup');
const closebutton = document.getElementById('close').onclick = close_popup;
const popup_text = document.getElementById('popup_text');

price1button.onclick = _1purchased;
price2button.onclick = _2purchased;
price3button.onclick = _3purchased;

const price1 = 60;

const price2 = 140;

const price3 = 400;

document.addEventListener("DOMContentLoaded", function() {
    price1button.textContent = "$" + String(price1);
    price2button.textContent = "$" + String(price2);
    price3button.textContent = "$" + String(price3);
    set_ballance();
})

function _1purchased() {
    buy(price1, 1);
}

function _2purchased() {
    buy(price2, 2);
}

function _3purchased() {
    buy(price3, 3);
}

async function buy(price, num) {
    let stored_money = await window.api.get_money();
    if (price <= stored_money) {
        await window.api.set_money(stored_money - price);
        set_ballance(num);
        let stored_ids = await window.api.get_used_ids();
        // if (stored_ids == null){
        //     stored_ids = 0
        // }
        stored_ids += 1;
        create_ticket(num,stored_ids);
        await window.api.set_used_ids(stored_ids);

    }
}

async function set_ballance() {
	ballance.textContent = "$" + await window.api.get_money();
}

function create_ticket(num, id) {
    let ticket = "";
    for (i = 0; i < (4 + num); i++) {
        //ticket += String(num);
        if (i == 3) {
            ticket += String(num);
            ticket += " ";
            ticket += String(id);
            ticket += " ";
        }
        else {
            ticket += String(Math.floor(Math.random() * (id * 10) ));
            ticket += " ";
        }
    }
    console.log("works");
    console.log(ticket);
    if (popup) {
        popup_text.textContent = ticket
        popup.showModal()
    } else{
        console.log("popup failed")
    }
}

function close_popup() {
    popup.close()
}