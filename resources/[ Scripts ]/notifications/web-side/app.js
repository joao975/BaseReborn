let list = []
let blocked = false

$(document).ready(function(){
    window.addEventListener("message",function(event){
        switch(event.data.action){
            case 'notify':
                if (event.data.data) {
                    addNotification(event.data.data)
                    break
                }

            case 'showAll':
                if (list.length > 0){
                    showLast()
                    $.post("http://notifications/focusOn")
                }
                break

            case 'hideAll':
                hideAll()
                $.post("http://notifications/focusOff")
                break
            case 'sendNotify':
                if (event.data.prefix) {
                    newNotify(event.data);
                }
                break
        }
        if (event.data.item) {
            var html = `<div class="item" style="background-image: url('http://177.73.101.236/imagens/${event.data.item}.png');">
                <div class="top">
                    <div class="itemWeight">${event.data.mode}</div>
                    <div class="itemAmount">${event.data.amount}x</div>
                </div>
                <div class="itemname">${event.data.name}</div>
            </div>`;

            $(html).fadeIn(500).appendTo("#notifyitens").delay(3000).fadeOut(500);
        }
        document.onkeyup = function(data){
            if (data.which == 27){
                hideAll()
                $.post("http://notifications/focusOff")
            }
        };

        $(document).on("click","#loc",function(){
            $.post("http://notifications/setWay",JSON.stringify({ x: $(this).attr("data-x"), y: $(this).attr("data-y") }))
        });

        $(document).on("click","#phone",function(){
            $.post("http://notifications/phoneCall",JSON.stringify({ phone: $(this).attr("data-phone") }))
        });

        var item = event.data;
        if (item !== undefined && item.type === "ui") {
            if (item.display === true) {
                $("#body").show();
                var start = new Date();
                var maxTime = item.time;
                var text = item.text;
                var timeoutVal = Math.floor(maxTime / 100);
                animateUpdate();

                $('#pbar_innertext').text(text);

                function updateProgress(percentage) {
                    $('#pbar_innerdiv').css("height", percentage + "%");
                }

                function animateUpdate() {
                    var now = new Date();
                    var timeDiff = now.getTime() - start.getTime();
                    var perc = Math.round((timeDiff / maxTime) * 100);
                    if (perc <= 100) {
                        updateProgress(perc);
                        setTimeout(animateUpdate, timeoutVal);
                    } else {
                        $("#body").hide();
                    }
                }
            } else {
                $("#body").hide();
            }
        }    
    })
});

function newNotify(data) {
    let color = ''
    let img = ''
    let type = data.prefix.toLowerCase()
    if (type == 'sucesso') {
        color = '#6FCF97'
        img = 'sucess.svg'
    } else if (type == 'negado') {
        color = '#EB5757'
        img = 'cancel.svg'
    } else if (type == 'importante' || type == 'aviso') {
        color = '#F2994A'
        img = 'warning.svg'
    } else if (type == 'financeiro') {
        color = '#F2C94C'
        img = 'money.svg'
    }
    notify(img, data.message, color)
}
    

function notify(img, message, color) {
    let container = document.querySelector('.notifies-container')
    let element = document.createElement('div')
    element.classList.add('notify')
    let line = document.createElement('div')
    line.classList.add('notifyLine')
    line.style.backgroundColor = color
    line.classList.add('width')
    element.innerHTML = `
    <div class = 'notifyText'>
        <img src="images/${img}" alt="">
        <p>${message}</p>
    </div>
    `
    element.appendChild(line)
    container.appendChild(element)
    element.classList.add('appear')
    deleteElement(element)
}

function deleteElement(element) {
    setTimeout(() => {
        element.classList.remove('appear')
        element.classList.add('disappear')
        setTimeout(() => {
            element.remove()
        }, 590);
    }, 4900);
}

const addNotification = data => {
    if (list.length > 9) list.shift()
    const html = `<div class="notification" style="background: rgba(${data.rgba[0]},${data.rgba[1]},${data.rgba[2]},0.7); border-left: rgba(${data.rgba[0]},${data.rgba[1]},${data.rgba[2]},1.0) 5px solid;">
        <div class="content">
            ${data.code === undefined ? "" : `<div class="code">QRU</div>`}
            <div class="titulo">${data.title}</div>

            ${data.street === undefined ? "" : `<div class="content-line"><i class="fa fa-arrow-right"></i>  ${data.street}</div>`}

            ${data.criminal === undefined ? "" : `<div class="content-line"><i class="fa fa-arrow-right"></i>  ${data.criminal}</div>`}

            ${data.name === undefined ? "" : `<div class="content-line"><i class="fa fa-arrow-right"></i>  ${data.name}</div>`}

            ${data.vehicle === undefined ? "" : `<div class="content-line"><i class="fa fa-arrow-right"></i>  ${data.vehicle}</div>`}

            ${data.time === undefined ? "" : `<div class="content-line"><i class="fa fa-arrow-right"></i>  ${data.time}</div>`}
        </div>

        <div class="buttons">
            <div class="chamados" id="loc" data-x="${data.x}" data-y="${data.y}"><i class="fas fa-map-marker-alt fa-lg"></i></div>
            ${data.phone === undefined ? "" : `<div class="chamados" id="phone" data-phone="${data.phone}"><i class="fas fa-phone-alt"></i></div>`}
        </div>

        ${data.text === undefined ? "" : `<div class="texto">${data.text}</div>`}
    </div>`

    list.push(html)

    if (!blocked){
        $(html).prependTo(".body")
        .hide()
        .show("slide",{ direction: "right" },250)
        .delay(5000)
        .hide("slide",{ direction: "right" },250)
    }
};

const hideAll = () => {
    blocked = false
    $(".body").css("overflow","hidden")
    $(".body").html("")
};

const showLast = () => {
    hideAll()
    blocked = true

    $(".body").css("overflow-y","scroll")
    for (i in list){
        $(list[i]).prependTo(".body")
    }
};