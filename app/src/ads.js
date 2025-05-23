
//const body = getElementById('bod').onLoad = adify;
// const ads_L = getElementById('ads_L');
// const ads_R = getElementById('ads_R');
// const ad_folder = '../ads';
// let ad_sources = [];

// function adify() {
//     console.log("onload")
    //const fileList = fs.readdirSync('/ads');

    //console.log(fileList);
	

const ads_L = document.getElementById('ads_L');
const ads_R = document.getElementById('ads_R');
let ad_sources = ["../ads/FORGEHACK.gif", "../ads/EXOFIGHTS.gif", "../ads/102 helmet.png", "../ads/DRIFTMETAL ZONE.gif"];
let ad_num = 20

const body = document.getElementById('bod')
bod.onload = adify;

function adify() {
	console.log("AAAAAAAAAAAAAAAAAAAAAAAAAAAA");
	
	for (let i = 0; i < ad_num; i++) {
		rand_ad(ads_L);
		rand_ad(ads_R);
	}
}

function rand_ad(ad_holder) {
	console.log("rand");
	let img = document.createElement('img');
	//img.src = "../ads/FORGEHACK.gif";
	img.src = ad_sources[Math.floor(Math.random() * ad_sources.length)]
	img.className = 'ad';
	ad_holder.appendChild(img);
}