$(document).ready(function () {
	var notifyNumber = 0;
	window.addEventListener("message", function (event) {

		if (event.data.css) {
			var html23 = `
			<div id='${event.data.css}'>
				<img width="19" src=${event["data"]["image"]}>
				<span>${event["data"]["mensagem"]}</span>
				<div class="timer-bar ${notifyNumber}"></div>
			</div>
		`;
		}

		if (event["data"]["hood"] !== undefined){
			if (event["data"]["hood"] == true){
				$("#hoodDisplay").fadeIn(500);
			} else {
				$("#hoodDisplay").fadeOut(500);
			}
		}

		
		$(html23).fadeIn(500).appendTo(`.${event.data.position === undefined ? "normal" : `${event.data.position}`}`).delay(event["data"]["timer"]).fadeOut(500);
		$(`.${notifyNumber}`).css('transition', `width ${event["data"]["timer"]}ms`);

		setTimeout(() => {
			$(`.${notifyNumber}`).css('width', '0%');
			notifyNumber += 1;
		}, 100);
	});
});