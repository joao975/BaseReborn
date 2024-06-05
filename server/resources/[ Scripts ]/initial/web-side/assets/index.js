$(document).ready(function () {
  window.addEventListener("message", function (event) {
    if (event.data.name === "Open") {
      $("#notify").hide();
      $("#app").fadeIn();
      if (event.data.vehicles) {
        $(".vehicles").html("");
        event.data.vehicles.map((item) => {
          $(".vehicles").append(`
            <div
              class="border-2 h-full group bg-gray-300 hover:bg-green-500 transition-all"
            >
              <h3
                class="absolute uppercase text-center text-white text-3xl font-bold z-2 ml-4"
              >
                ${item.title}
              </h3>
              <img
                src="./assets/${item.index}.png"
                alt=""
                class="h-full group-hover:scale-105 group-hover:ml-2 transition-all"
              />
              <button
                class="w-full bg-blue-400 hover:bg-blue-700 text-white font-semibold h-12 text-2xl"
                onclick="chooseVehicle('${item.index}')"
              >
                ESCOLHER
              </button>
            </div>
          `);
        });
      }
    } else if (event.data.name === "Notify") {
      $("#notify").fadeIn();
    }
  });
  document.onkeyup = function (data) {
    if (data["which"] == 27) {
      $("#app").fadeOut();
      $("#notify").fadeIn();
      $.post("http://initial/close");
    }
  };
});

function chooseVehicle(vehicle) {
  $("#app").fadeOut();
  $.post("http://initial/Save", JSON.stringify({ name: vehicle }));
}
