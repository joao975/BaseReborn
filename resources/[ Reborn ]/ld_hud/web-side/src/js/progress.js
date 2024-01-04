// var progress2 = undefined;
// $(document).ready(function () {
//   window.addEventListener("message", function (event) {
//     $("#body").is(":visible") && progress2 && clearTimeout(progress2);
//     $("#body").fadeIn();
//     var start = new Date();
//     var maxTime = event.data.time;
//     var timeoutVal = Math.floor(maxTime / 115);
//     animateUpdate();

//     function updateProgress(percentage) {
//       var $circle = $('#svg #bar');
//       var r = $circle.attr('r');
//       var c = Math.PI * (r * 2);
//       var pct = ((100 - percentage) / 100) * c;
//       $circle.css({ strokeDashoffset: pct });
//     };

//     function animateUpdate() {
//       var now = new Date();
//       var timeDiff = now.getTime() - start.getTime();
//       var perc = Math.round((timeDiff / maxTime) * 100);
//       if (perc <= 100) {
//         console.log(perc)
//         updateProgress(perc);
//         progress2 = setTimeout(animateUpdate, timeoutVal);
//       } else {
//         $("#body").fadeOut();
//         clearTimeout(progress2);
//         progress2 = undefined;
//       }
//     }
//   });
// });