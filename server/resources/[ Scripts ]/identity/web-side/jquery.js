$(document).ready(function() {

	window.addEventListener('message',function(event){
		let item = event.data;
        if (item.open) {
            $(".container").show();
            showInfos(item.infos);
        } else {
            $(".container").hide();
		}
	});
});

const showInfos = (info) => {
    $("#infos").html(`
    <div id="passport">#${info.userId}</div>
    <div id="leftInfos">
        <div id="info">${info.name}</div>
        <div id="info">${info.phone}</div>
        <div id="info">${info.job}</div>
    </div>
    <div id="rightInfos">
        <div id="info">R$${info.bank}</div>
        <div id="info">R$${info.fines}</div>
        <div id="info">${info.vip}</div>
    </div>
    `);
};
