$(function () {
   MaraltoElevadores.init()
});
var MaraltoElevadores = {};
MaraltoElevadores = {
   init: function () {
      $('#root').fadeOut();
      window.addEventListener('message', function (event) {
         if (event.data.action === 'openElevator') {
            if (event.data.andares !== null) {
               MaraltoElevadores.showElevadores(event.data.elevatorId, event.data.andares)
            }
         };
         if (event.data.action === 'close') {
            $('#root').fadeOut();
            $('#root').html('')
         };
         if (event.data.action === 'bell') {
            const audioPromise = new Promise((resolve) => {
               const audio = new Audio('bell.ogg');
               audio.volume = 0.2;
               audio.addEventListener('canplaythrough', () => {
                  resolve(audio)
               })
            });
            async function playBell() {
               const audio = await audioPromise;
               audio.currentTime = 0;
               audio.play()
            }
            async function pauseBell() {
               const audio = await audioPromise;
               audio.pause()
            }
            playBell()
         }
      });
      document.onkeyup = function (event) {
         if (event.which == 27) {
            MaraltoElevadores.sendData('UIRequest', {
               action: 'close'
            }, false)
         }
      }
   },
   showElevadores: function (elevatorId, andares) {
      $('#root').html("<div class='container'>" + '<h6>Elevador</h6>' + "<div class='andares'>" + '</div>' + '</div>');
      let buttonTemplate = "<button class='andar' onclick='MaraltoElevadores.teleport(" + elevatorId + ",{$ANDARID})'>{$ANDARNAME}</button>";
      let buttonsHTML = '';
      $(andares).each(function (index, andar) {
         if (andar !== null && andar.id !== null && andar.name !== null) {
            var button = buttonTemplate;
            button = button.replace('{$ANDARID}', andar.id);
            button = button.replace('{$ANDARNAME}', andar.name);
            buttonsHTML += button;
         }
      });
      $('.andares').html(buttonsHTML);
      setTimeout(function () {
         $('#root').fadeIn(400)
      }, 100)
   },
   teleport: function (elevatorId, andarId) {
      MaraltoElevadores.sendData('UIRequest', {
         action: 'teleport',
         elevatorId: elevatorId,
         andarId: andarId
      }, false)
   },
   sendData: function (requestType, data, delay) {
      var delayTime = 0;
      if (delay !== false) {
         delayTime = 500;
      };
      setTimeout(function () {
         $.post(`https://${GetParentResourceName()}/` + requestType, JSON.stringify(data))
      }, delayTime)
   }
}