$(document).ready(() => {
    let bShiftPress = false;

    // $(".menu-item").click(function() {
    //     $(".menu-item").removeClass("active");
    //     $(this).addClass("active");
    //     $(".option-separator").removeClass("active");
    //     $(`.${$(this).attr('data-ref')}`).addClass("active");
    // });

    document.onkeyup = function(data) {
        if (data.which == 16) {
            bShiftPress = false;
        }
    };

    document.onkeydown = function(data) {
        if (data.which == 16) {
            bShiftPress = true;
        }

        if (data.which == 65) {
            $.post('http://barbershop/rotate', JSON.stringify("right"));
        }

        if (data.which == 68) {
            $.post('http://barbershop/rotate', JSON.stringify("left"));
        }
    };

    updateSlider();

    $('.fa-angle-left').click(function(e) {
        e.preventDefault();
        const valueCap = bShiftPress ? 10 : 1;
        $(this).parent().find('input[type=range]').val(Number($(this).parent().find('input[type=range]').val()) - valueCap);
        updateSlider();
        arrowClick();
    });

    $('.fa-angle-right').click(function(e) {
        e.preventDefault();
        const valueCap = bShiftPress ? 10 : 1;
        $(this).parent().find('input[type=range]').val(Number($(this).parent().find('input[type=range]').val()) + valueCap);
        updateSlider();
        arrowClick();
    });



    function arrowClick() {
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
    }

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