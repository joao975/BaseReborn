$(document).ready(function() {
    var documentWidth = document.documentElement.clientWidth;
    var documentHeight = document.documentElement.clientHeight;
    var cursor = $('#cursorPointer');
    var cursorX = documentWidth / 2;
    var cursorY = documentHeight / 2;

    function triggerClick(x, y) {
        var element = $(document.elementFromPoint(x, y));
        element.focus().click();
        return true;
    }

    window.addEventListener('message', function(event) {
        document.getElementById("hair").value = event.data.hairModel;
		document.getElementById("haircolor").value = event.data.firstHairColor;
		document.getElementById("haircolor2").value = event.data.secondHairColor;
		document.getElementById("makeup").value = event.data.makeupModel;
		document.getElementById("makeupcolor").value = event.data.makeupcolor;
		document.getElementById("lipstick").value = event.data.lipstickModel;
		document.getElementById("lipstickcolor").value = event.data.lipstickColor;
		document.getElementById("eyebrow").value = event.data.eyebrowsModel;
		document.getElementById("eyebrowcolor").value = event.data.eyebrowsColor;
		document.getElementById("beard").value = event.data.beardModel;
		document.getElementById("beardcolor").value = event.data.beardColor;
		document.getElementById("blush").value = event.data.blushModel;
		document.getElementById("blushcolor").value = event.data.blushColor;
		document.getElementById("eyescolor").value = event.data.eyesColor;
		document.getElementById("frecklesmodel").value = event.data.frecklesModel;

        updateSlider();

        if (event.data.openBarbershop === true) {
            $("body").show();
        }

        if (event.data.openBarbershop === false) {
            $("body").hide();
        }

        if (event.data.type == "click") {
            triggerClick(cursorX - 1, cursorY - 1);
        }
    });

    $('input').change(function() {
        $.post('http://barbershop/updateSkin', JSON.stringify({
            value: false,
			hairModel: $('.hair').val(),
			firstHairColor: $('.haircolor').val(),
			secondHairColor: $('.haircolor2').val(),
			makeupModel: $('.makeup').val(),
			makeupintensity: $('.makeupintensity').val(),
			makeupcolor: $('.makeupcolor').val(),
			lipstickModel: $('.lipstick').val(),
			lipstickintensity: $('.lipstickintensity').val(),
			lipstickColor: $('.lipstickcolor').val(),
			eyebrowsModel: $('.eyebrow').val(),
			eyebrowintensity: $('.eyebrowintensity').val(),
			eyebrowsColor: $('.eyebrowcolor').val(),
			beardModel: $('.beard').val(),
			beardintentisy: $('.beardintentisy').val(),
			beardColor: $('.beardcolor').val(),
			blushModel: $('.blush').val(),
			blushintentisy: $('.blushintentisy').val(),
			blushColor: $('.blushcolor').val(),
			eyesColor: $('.eyescolor').val(),
			frecklesModel: $('.frecklesmodel').val(),
		}));
    });

    $('.submit-button').on('click', function(e) {
        e.preventDefault();
        $.post('http://barbershop/updateSkin', JSON.stringify({
            value: true,
			hairModel: $('.hair').val(),
			firstHairColor: $('.haircolor').val(),
			secondHairColor: $('.haircolor2').val(),
			makeupModel: $('.makeup').val(),
			makeupintensity: $('.makeupintensity').val(),
			makeupcolor: $('.makeupcolor').val(),
			lipstickModel: $('.lipstick').val(),
			lipstickintensity: $('.lipstickintensity').val(),
			lipstickColor: $('.lipstickcolor').val(),
			eyebrowsModel: $('.eyebrow').val(),
			eyebrowintensity: $('.eyebrowintensity').val(),
			eyebrowsColor: $('.eyebrowcolor').val(),
			beardModel: $('.beard').val(),
			beardintentisy: $('.beardintentisy').val(),
			beardColor: $('.beardcolor').val(),
			blushModel: $('.blush').val(),
			blushintentisy: $('.blushintentisy').val(),
			blushColor: $('.blushcolor').val(),
			eyesColor: $('.eyescolor').val(),
			frecklesModel: $('.frecklesmodel').val(),
		}));
        $("body").hide();
    });

	$('.cancel-button').on('click', function(e) {
        e.preventDefault();
		$.post('http://barbershop/closeNui', JSON.stringify({}));
	});

    function updateSlider() {
        $('input').each(function() {
            var max = $(this).attr('max'),
                val = $(this).val();
            $(this).parent().parent().find('label').find('p:last-child').text(val + ' / ' + max);
        });

        for (let e of document.querySelectorAll('input[type="range"].slider-progress')) {
            e.style.setProperty('--value', e.value);
            e.style.setProperty('--min', e.min == '' ? '0' : e.min);
            e.style.setProperty('--max', e.max == '' ? '100' : e.max);
            e.addEventListener('input', () => e.style.setProperty('--value', e.value));
        }
    }
});


function change(e) {
    $.post('http://barbershop/updateSkin', JSON.stringify({
        value: false,
			hairModel: $('.hair').val(),
			firstHairColor: $('.haircolor').val(),
			secondHairColor: $('.haircolor2').val(),
			makeupModel: $('.makeup').val(),
			makeupintensity: $('.makeupintensity').val(),
			makeupcolor: $('.makeupcolor').val(),
			lipstickModel: $('.lipstick').val(),
			lipstickintensity: $('.lipstickintensity').val(),
			lipstickColor: $('.lipstickcolor').val(),
			eyebrowsModel: $('.eyebrow').val(),
			eyebrowintensity: $('.eyebrowintensity').val(),
			eyebrowsColor: $('.eyebrowcolor').val(),
			beardModel: $('.beard').val(),
			beardintentisy: $('.beardintentisy').val(),
			beardColor: $('.beardcolor').val(),
			blushModel: $('.blush').val(),
			blushintentisy: $('.blushintentisy').val(),
			blushColor: $('.blushcolor').val(),
			eyesColor: $('.eyescolor').val(),
			frecklesModel: $('.frecklesmodel').val(),
		}));
    $(e).parent().parent().find('label').find('p:last-child').html($(e).val() + ' / ' + $(e).attr('max'));
}