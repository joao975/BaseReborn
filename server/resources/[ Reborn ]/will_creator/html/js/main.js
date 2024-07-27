var _0x72da3a = _0x58f4;
(function (_0x15bdd5, _0x1bfeb8) {
  var _0x202cc7 = _0x58f4,
    _0x52255f = _0x15bdd5();
  while (!![]) {
    try {
      var _0x591a43 =
        parseInt(_0x202cc7(0x1e9)) / 0x1 +
        parseInt(_0x202cc7(0x1c1)) / 0x2 +
        (parseInt(_0x202cc7(0x1f4)) / 0x3) *
          (-parseInt(_0x202cc7(0x273)) / 0x4) +
        -parseInt(_0x202cc7(0x264)) / 0x5 +
        parseInt(_0x202cc7(0x17a)) / 0x6 +
        (parseInt(_0x202cc7(0x15c)) / 0x7) *
          (parseInt(_0x202cc7(0x1bf)) / 0x8) +
        -parseInt(_0x202cc7(0x255)) / 0x9;
      if (_0x591a43 === _0x1bfeb8) break;
      else _0x52255f["push"](_0x52255f["shift"]());
    } catch (_0x42d0c8) {
      _0x52255f["push"](_0x52255f["shift"]());
    }
  }
})(_0x3d22, 0xc923c);
let maxValues = [],
  currentIndex = 0x2,
  cachedMugshotCount = 0x0,
  currentOpenType = _0x72da3a(0x150),
  selectedPlayer = null,
  actualCategory = _0x72da3a(0x1b6);
function componentToHex(_0xb54db5) {
  var _0x2c6795 = _0xb54db5["toString"](0x10);
  return _0x2c6795["length"] == 0x1 ? "0" + _0x2c6795 : _0x2c6795;
}
function rgbToHex(_0x474eac, _0x414d21, _0x454681) {
  return (
    "#" +
    componentToHex(_0x474eac) +
    componentToHex(_0x414d21) +
    componentToHex(_0x454681)
  );
}
class PedVariation {
  [_0x72da3a(0x16a)] = "";
  [_0x72da3a(0x1f6)] = 0x0;
  ["sex"] = _0x72da3a(0x246);
  [_0x72da3a(0x27e)] = ![];
  ["fatherClass"] = "";
  [_0x72da3a(0x228)] = 0x0;
  constructor(_0x3a6a90, _0x3797dd, _0x54f37a, _0x5ca686, _0x1818f5) {
    var _0x503171 = _0x72da3a;
    (this["name"] = _0x3a6a90),
      (this[_0x503171(0x1f6)] = _0x3797dd),
      (this["hasNegative"] = _0x5ca686),
      (this[_0x503171(0x1c8)] = _0x54f37a),
      (this[_0x503171(0x228)] = _0x1818f5),
      this[_0x503171(0x228)] && this["showColors"](),
      this[_0x503171(0x1d9)]();
  }
  [_0x72da3a(0x1d9)] = () => {
    var _0x3ca669 = _0x72da3a;
    let _0x1e8611 = "";
    $(this[_0x3ca669(0x1c8)])[_0x3ca669(0x16e)]("");
    const _0x2bd42f =
      this[_0x3ca669(0x16a)] === _0x3ca669(0x1d0)
        ? _0x3ca669(0x184)
        : this[_0x3ca669(0x16a)];
    this[_0x3ca669(0x27e)]
      ? (_0x1e8611 =
          "\x0a\x20\x20\x20\x20\x20\x20\x20\x20<div\x20class=\x22flex\x20" +
          this[_0x3ca669(0x16a)] +
          _0x3ca669(0x23f) +
          this["name"] +
          "ItemActive\x22\x20id=\x22" +
          this[_0x3ca669(0x16a)] +
          _0x3ca669(0x181) +
          this[_0x3ca669(0x180)] +
          "/" +
          _0x2bd42f +
          _0x3ca669(0x280) +
          this[_0x3ca669(0x16a)] +
          "Btn\x22\x20id=\x22" +
          this[_0x3ca669(0x16a)] +
          _0x3ca669(0x16c) +
          this[_0x3ca669(0x180)] +
          "/" +
          _0x2bd42f +
          _0x3ca669(0x221))
      : (_0x1e8611 =
          _0x3ca669(0x222) +
          this[_0x3ca669(0x16a)] +
          _0x3ca669(0x23f) +
          this["name"] +
          "ItemActive\x22\x20id=\x22" +
          this[_0x3ca669(0x16a)] +
          _0x3ca669(0x1fd) +
          this[_0x3ca669(0x180)] +
          "/" +
          _0x2bd42f +
          _0x3ca669(0x179)),
      Array[_0x3ca669(0x151)]({ length: this[_0x3ca669(0x1f6)] })[
        _0x3ca669(0x149)
      ]((_0x3d26fa, _0x44d868) => {
        var _0x541b77 = _0x3ca669;
        _0x1e8611 +=
          _0x541b77(0x222) +
          this[_0x541b77(0x16a)] +
          _0x541b77(0x161) +
          this[_0x541b77(0x16a)] +
          "-" +
          (_0x44d868 + 0x1) +
          "\x22>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<img\x20class=\x22w-[85px]\x20h-[85px]\x20rounded\x22\x20src=\x22http://212.18.114.101/creator/" +
          this[_0x541b77(0x180)] +
          "/" +
          _0x2bd42f +
          "/" +
          (_0x44d868 + 0x1) +
          _0x541b77(0x279);
      }),
      $(this[_0x3ca669(0x1c8)])[_0x3ca669(0x287)](_0x1e8611),
      $("." + this[_0x3ca669(0x16a)] + _0x3ca669(0x1d2))["on"](
        _0x3ca669(0x15e),
        this[_0x3ca669(0x223)]
      );
  };
  [_0x72da3a(0x230)] = () => {
    var _0x699509 = _0x72da3a;
    apiPost(_0x699509(0x220), { type: this["showColor"] }, (_0x4df279) => {
      var _0x521186 = _0x699509;
      $("." + this["name"] + "-colors")[_0x521186(0x16e)]("");
      for (const [_0x2292d7, _0x41199a] of Object["entries"](_0x4df279)) {
        const _0x2b6d6f = rgbToHex(
          _0x41199a["r"],
          _0x41199a["g"],
          _0x41199a["b"]
        );
        $("." + this[_0x521186(0x16a)] + _0x521186(0x1d7))[_0x521186(0x287)](
          _0x521186(0x172) +
            this["name"] +
            _0x521186(0x1c7) +
            _0x2292d7 +
            _0x521186(0x25c) +
            _0x2292d7 +
            _0x521186(0x1cd) +
            this[_0x521186(0x16a)] +
            _0x521186(0x14a) +
            (_0x2292d7 == 0x0 ? "colorSelected" : "") +
            _0x521186(0x1f7) +
            _0x2b6d6f +
            "]\x20w-8\x20h-8\x20rounded\x22\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20></div>\x0a\x20\x20\x20\x20\x20\x20\x20\x20"
        );
      }
      let _0x559fdc = this[_0x521186(0x16a)];
      $("." + this[_0x521186(0x16a)] + _0x521186(0x202))[_0x521186(0x15e)](
        function () {
          var _0x43185e = _0x521186,
            _0x100289 = parseInt($(this)["attr"](_0x43185e(0x1d8)));
          $("." + _0x559fdc + _0x43185e(0x202))[_0x43185e(0x148)](
            _0x43185e(0x226)
          ),
            $(this)[_0x43185e(0x17c)](_0x43185e(0x226)),
            apiPost(_0x43185e(0x1cc), {
              clothingType: _0x559fdc,
              articleNumber: _0x100289,
              type: "texture",
            });
        }
      );
    });
  };
  ["showVariation"] = (_0x40e6fc) => {
    var _0x1bbc6c = _0x72da3a;
    const _0x198fca = _0x40e6fc?.[_0x1bbc6c(0x199)]["id"];
    _0x198fca &&
      ($("." + this[_0x1bbc6c(0x16a)] + "Btn")[_0x1bbc6c(0x148)](
        this[_0x1bbc6c(0x16a)] + _0x1bbc6c(0x194)
      ),
      $("#" + _0x198fca)["addClass"](this["name"] + "ItemActive"),
      apiPost("updateSkin", {
        clothingType: this[_0x1bbc6c(0x16a)],
        articleNumber: _0x198fca[_0x1bbc6c(0x205)]("-")[0x1],
        type: _0x1bbc6c(0x215),
      }));
  };
  [_0x72da3a(0x1ef)] = (_0x2ce60c) => {
    var _0x445b46 = _0x72da3a;
    (this[_0x445b46(0x180)] = _0x2ce60c), this[_0x445b46(0x1d9)]();
  };
}
function _0x58f4(_0x1e123d, _0x4184af) {
  var _0x3d2258 = _0x3d22();
  return (
    (_0x58f4 = function (_0x58f459, _0x5eadc8) {
      _0x58f459 = _0x58f459 - 0x145;
      var _0x554ad6 = _0x3d2258[_0x58f459];
      return _0x554ad6;
    }),
    _0x58f4(_0x1e123d, _0x4184af)
  );
}
function registerSavedSkins(_0x191e85) {
  var _0x25e4f9 = _0x72da3a;
  $(_0x25e4f9(0x28e))["html"](""),
    (cachedMugshotCount = (_0x191e85 && _0x191e85[_0x25e4f9(0x1df)]) || 0x0);
  for (var _0x2aedae = 0x0; _0x2aedae < cachedMugshotCount; _0x2aedae++) {
    $(_0x25e4f9(0x28e))[_0x25e4f9(0x287)](
      _0x25e4f9(0x274) +
        _0x191e85[_0x2aedae]["id"] +
        _0x25e4f9(0x23c) +
        _0x191e85[_0x2aedae][_0x25e4f9(0x207)] +
        _0x25e4f9(0x25e) +
        _0x191e85[_0x2aedae]["id"] +
        _0x25e4f9(0x1c3)
    ),
      $(_0x25e4f9(0x216) + _0x191e85[_0x2aedae]["id"])[_0x25e4f9(0x19b)](
        _0x25e4f9(0x15e)
      ),
      $(_0x25e4f9(0x216) + _0x191e85[_0x2aedae]["id"])[_0x25e4f9(0x15e)](
        function () {
          var _0x2c03ab = _0x25e4f9,
            _0x8660ac = $(this)
              [_0x2c03ab(0x165)]("id")
              [_0x2c03ab(0x27f)](_0x2c03ab(0x207), "");
          if (
            $(_0x2c03ab(0x16d) + _0x8660ac)[_0x2c03ab(0x272)](
              _0x2c03ab(0x1de)
            ) == 0x1
          )
            return;
          apiPost("loadSkinData", { id: _0x8660ac, type: currentOpenType });
        }
      ),
      $(_0x25e4f9(0x216) + _0x191e85[_0x2aedae]["id"])[_0x25e4f9(0x1a6)](
        function () {
          var _0xc2bbe1 = _0x25e4f9,
            _0x16b86e = $(this)
              [_0xc2bbe1(0x165)]("id")
              ["replace"](_0xc2bbe1(0x207), "");
          $(_0xc2bbe1(0x16d) + _0x16b86e)[_0xc2bbe1(0x1f8)](
            { opacity: 0x1 },
            0xfa
          ),
            $(_0xc2bbe1(0x16d) + _0x16b86e)[_0xc2bbe1(0x19b)]("click"),
            $(_0xc2bbe1(0x16d) + _0x16b86e)[_0xc2bbe1(0x15e)](function () {
              apiPost(
                "deleteSkinData",
                { id: _0x16b86e, type: currentOpenType },
                function (_0x14faff) {
                  var _0x2232fe = _0x58f4;
                  $(_0x2232fe(0x16d) + _0x16b86e)[_0x2232fe(0x19b)](
                    _0x2232fe(0x15e)
                  ),
                    registerSavedSkins(_0x14faff);
                }
              );
            }),
            setTimeout(function () {
              var _0x10e779 = _0xc2bbe1;
              $(_0x10e779(0x16d) + _0x16b86e)[_0x10e779(0x1f8)](
                { opacity: 0x0 },
                0xfa
              ),
                $(_0x10e779(0x16d) + _0x16b86e)[_0x10e779(0x19b)]("click");
            }, 0x3e8);
        }
      );
  }
}
function openCreateMenu() {
  var _0x39b399 = _0x72da3a;
  $(_0x39b399(0x250))["text"](_0x39b399(0x214)),
    apiPost("selectChar"),
    $(_0x39b399(0x1f5))[_0x39b399(0x17c)]("hidden"),
    setTimeout(function () {
      var _0x41ca9a = _0x39b399;
      $(_0x41ca9a(0x1f5))["addClass"](_0x41ca9a(0x24c));
    }, 0x96),
    $("#doneBtn")[_0x39b399(0x19b)](_0x39b399(0x15e)),
    $(_0x39b399(0x1c5))["on"](_0x39b399(0x15e), function () {
      var _0x2275bd = _0x39b399;
      apiPost(_0x2275bd(0x157)),
        $(_0x2275bd(0x267))[_0x2275bd(0x17c)]("hidden"),
        $(_0x2275bd(0x267))["hide"]();
    });
}
function openSelectMenu(_0x1a6770) {
  var _0x55073e = _0x72da3a;
  (selectedPlayer = _0x1a6770),
    $(_0x55073e(0x250))[_0x55073e(0x152)](_0x55073e(0x28d)),
    $("#createMenu")[_0x55073e(0x17c)](_0x55073e(0x265)),
    setTimeout(function () {
      var _0x598e61 = _0x55073e;
      $(_0x598e61(0x189))[_0x598e61(0x17c)](_0x598e61(0x24c));
    }, 0x96),
    $(_0x55073e(0x1f5))[_0x55073e(0x148)](_0x55073e(0x265)),
    setTimeout(function () {
      var _0x2f9bf7 = _0x55073e;
      $(_0x2f9bf7(0x1f5))[_0x2f9bf7(0x148)](_0x2f9bf7(0x24c));
    }, 0x96),
    apiPost("selectChar", { identifier: _0x1a6770 }, function (_0x1e177c) {
      var _0x557da7 = _0x55073e;
      $(_0x557da7(0x1a2))[_0x557da7(0x152)](_0x1e177c[_0x557da7(0x16a)]),
        $(_0x557da7(0x20b))["text"](_0x1e177c["lastname"]),
        $(_0x557da7(0x16f))[_0x557da7(0x152)](_0x1e177c["job"]),
        $(_0x557da7(0x27a))[_0x557da7(0x152)](
          "$" + _0x1e177c[_0x557da7(0x249)]
        ),
        $(_0x557da7(0x1a5))["text"]("$" + _0x1e177c[_0x557da7(0x147)]);
    }),
    $(_0x55073e(0x1c5))[_0x55073e(0x19b)](_0x55073e(0x15e)),
    $("#doneBtn")["on"]("click", function () {
      if (selectedPlayer != null)
        apiPost(
          "playChar",
          { identifier: selectedPlayer },
          function (_0x3540dd) {
            var _0x4e13b9 = _0x58f4;
            _0x3540dd == ![]
              ? errorNotify(_0x4e13b9(0x1e7))
              : ($(_0x4e13b9(0x267))[_0x4e13b9(0x17c)]("hidden"),
                $(_0x4e13b9(0x267))["hide"]());
          }
        );
    });
}
function openKeycodeMenu() {
  var _0x2de297 = _0x72da3a;
  $(_0x2de297(0x1e2))[_0x2de297(0x148)](_0x2de297(0x265)),
    setTimeout(function () {
      var _0x43c947 = _0x2de297;
      $(_0x43c947(0x1e2))["removeClass"]("opacity-0");
    }, 0x96);
}
function _0x3d22() {
  var _0x3e5c5a = [
    "-0\x22>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<img\x20class=\x22w-[85px]\x20h-[85px]\x20rounded\x22\x20src=\x22http://212.18.114.101/creator/",
    "#mugshotDelete",
    "html",
    "#loadedCharJob",
    "maleBtnActive",
    "data-slider",
    "\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<div\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20id=\x22",
    ".box-3\x20.place",
    "active-menu-content",
    "keyup",
    "right",
    "string",
    "\x22\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20key=\x22",
    "/0.png\x22\x20alt=\x22\x22\x20/>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20</div>\x0a\x20\x20\x20\x20\x20\x20\x20\x20",
    "1631202sysloK",
    "\x20.box-img\x20img",
    "addClass",
    "data-id",
    "#randomCharBtn",
    "spawncoords",
    "sex",
    "--1\x22>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<img\x20class=\x22w-[85px]\x20h-[85px]\x20rounded\x22\x20src=\x22http://212.18.114.101/creator/",
    ".beards-content",
    "face2",
    "facialHair",
    ".sliderNegative",
    "/10",
    "moms",
    "\x20w-[97px]\x20h-[107px]\x20flex\x20flex-col\x20items-center\x20justify-end\x20text-[12px]\x22>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<img\x20class=\x22h-20\x22\x20src=\x22http://212.18.114.101/creator/parents/",
    "#createMenu",
    "#tebexStore",
    ".box-3",
    ".box-4\x20.place",
    "show",
    "tebexStore",
    "#categories",
    ".box-5",
    "data",
    "height",
    "#hairCategoryBtn",
    "ItemActive",
    "\x0a\x20\x20\x20\x20\x20\x20<div\x20class=\x22cursor-pointer\x20uppercase\x20parentItem\x20",
    "#serverName",
    ".createCharacterBtn",
    "type",
    "currentTarget",
    "my-4",
    "off",
    "#closeKeycodeMenu",
    "selectedChar",
    ".hair-colors-2",
    "#parentsDiv",
    "Codigo\x20inválido!",
    "key=\x22female\x22",
    "#loadedCharFirstname",
    "female",
    "saveSkin",
    "#loadedCharBank",
    "contextmenu",
    "sort",
    ".box-4",
    "#dadSimilarity",
    "setupCam",
    "hair2",
    "Value",
    "data-spawncoordz",
    ".cam",
    ".sliderPositiveOpacity",
    ".sliderNegativeTexture",
    ".sliderPositive",
    "#femaleBtn",
    "#leftMenu",
    "data-cam",
    "#saveSkinDataBtn",
    "DNA",
    "#saveCharBtnText",
    "#sexSection",
    ".sliderGreen",
    "chars",
    ".selectCharacterBtn",
    "barber",
    "serverName",
    ".charUnlockItem",
    "1416uYVZwN",
    ".box-4\x20.box-title",
    "1070878wDPfwb",
    ".lipstick-content",
    "\x22\x20class=\x22opacity-0\x20absolute\x20w-full\x20h-full\x20backdrop-blur-[7px]\x20bg-black\x20bg-opacity-30\x20flex\x20items-center\x20justify-center\x22>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<svg\x20class=\x22deleteIconShadow\x22\x20width=\x2218\x22\x20height=\x2225\x22\x20viewBox=\x220\x200\x2014\x2018\x22\x20xmlns=\x22http://www.w3.org/2000/svg\x22>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<path\x20d=\x22M14\x201H10.5L9.5\x200H4.5L3.5\x201H0V3H14M1\x2016C1\x2016.5304\x201.21071\x2017.0391\x201.58579\x2017.4142C1.96086\x2017.7893\x202.46957\x2018\x203\x2018H11C11.5304\x2018\x2012.0391\x2017.7893\x2012.4142\x2017.4142C12.7893\x2017.0391\x2013\x2016.5304\x2013\x2016V4H1V16Z\x22\x20fill=\x22#E32B2B\x22/>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20</svg>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20</div>\x0a\x20\x20\x20\x20\x20\x20\x20\x20</div>\x0a\x20\x20\x20\x20\x20\x20\x20\x20",
    ".box-5\x20.place",
    "#doneBtn",
    ".box-2\x20.place",
    "-color-",
    "fatherClass",
    "point",
    "#charCreateLastname",
    "fadeOut",
    "updateSkin",
    "\x22\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20class=\x22",
    ".eyes-content",
    "serverLogo",
    "beard",
    "Texture",
    "Btn",
    ".box-1\x20.box-title",
    "Finalizar\x20($",
    "686px",
    "invokeNative",
    "-colors",
    "data-color",
    "showContent",
    "fadeIn",
    "disabled",
    "categories",
    "OpacityValue",
    "opacity",
    "length",
    "closeMultichar",
    ".makeup-content",
    "#keycodeMenu",
    "randomChar",
    ".box-2\x20.box-img\x20img",
    "key",
    ".box-5\x20.box-title",
    "Você\x20deve\x20selecionar\x20um\x20personagem!",
    "assets/",
    "1583693SRukVE",
    ".category-btn",
    "beardCategoryBtn",
    ".nextCam",
    "Opacity",
    "#ustGradient",
    "setSex",
    ".bodyBGG",
    ".box-1\x20.box-img\x20img",
    ".box",
    "\x20w-[97px]\x20h-[107px]\x20flex\x20flex-col\x20items-center\x20justify-end\x20text-[12px]\x22>\x0a\x20\x20\x20\x20\x20\x20\x20\x20<img\x20class=\x22h-20\x22\x20src=\x22http://212.18.114.101/creator/parents/",
    "3pPAILI",
    "#selectedChar",
    "quantity",
    "\x20bg-[",
    "animate",
    "SALVAR\x20PERSONAGEM",
    "closeWithoutPay",
    "#serverDescription",
    "none",
    "-0\x22>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<img\x20class=\x22w-[85px]\x20h-[85px]\x20rounded\x22\x20src=\x22http://212.18.114.101/creator/",
    "translations",
    "data-camcoordz",
    ".actualCam",
    "min",
    "-color",
    "maxValues",
    "\x22\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20data-color=\x22",
    "split",
    "#serverLogo",
    "mugshot",
    ".box\x20.place",
    ".box-2",
    "\x0a\x20\x20\x20\x20\x20\x20\x20\x20<div\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20id=\x22mom-",
    "#loadedCharLastname",
    "block",
    "eyes",
    "MaxCharacterSlots",
    "redeemKeycode",
    "TextureMax",
    "includes",
    "h-[227px]",
    "femaleBtnActive",
    "CRIAR\x20PERSONAGEM",
    "item",
    "#mugshot",
    "\x0a\x20\x20\x20\x20\x20\x20\x20\x20<div\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20id=\x22hair-color-2-",
    "flex",
    "data-spawncoordx",
    "#charCreateFirstname",
    "cursor-pointer",
    ".box-4\x20.box-img\x20img",
    "opacity-50",
    "#maleBtn",
    "hairCategoryBtn",
    "getVariationColors",
    "/0.png\x22\x20alt=\x22\x22\x20/>\x0a\x20\x20\x20\x20\x20\x20\x20\x20</div>",
    "\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<div\x20class=\x22flex\x20",
    "showVariation",
    "noseCategoryBtn",
    "data-camcoordy",
    "colorSelected",
    "data-spawnoordz",
    "showColor",
    ".sliderPositiveTexture",
    "\x20.place",
    "close",
    "parse",
    "first",
    "saved",
    "top",
    "showColors",
    "index",
    "max",
    "values",
    "h-[200px]",
    "\x22\x20onerror=\x22this.onerror=null;this.src=\x27./assets/icons/head.svg\x27;\x22\x20/>\x0a\x20\x20\x20\x20",
    "opacity-100",
    "openUrl",
    ".box\x20.box-img\x20img",
    "openMultichar",
    "data-spawncoordy",
    "Max",
    "\x22\x20class=\x22relative\x20cursor-pointer\x20overflow-hidden\x20backdrop-blur-[5.5px]\x20mb-[6px]\x20bg-white\x20bg-opacity-[0.06]\x20h-[76px]\x20w-[76px]\x20rounded-[4px]\x20flex\x20items-center\x20justify-center\x22>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<img\x20class=\x22w-full\x20h-full\x20cursor-pointer\x22\x20src=\x22",
    "src",
    "#randomChar",
    "Btn\x20",
    "face",
    "Salvar\x20(R$",
    "facemix",
    ".box-",
    "main",
    "select",
    "male",
    "DefaultExtraCharacterSlots",
    ".eyebrows-content",
    "cash",
    "value",
    "hasTexture",
    "opacity-0",
    "updateMaxSinle",
    "price",
    "addEventListener",
    "#doneBtnText",
    "#activeGradient",
    "serverDescription",
    "Você\x20deve\x20ter\x20um\x20nome\x20válido!",
    "makeup",
    "8890623TNuPej",
    "openSurgery",
    "#redeemInput",
    "val",
    "surgery",
    ".categoryGroup",
    ".box-1",
    "\x22\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20data-color=\x22",
    "eyebrows",
    "\x22\x20alt=\x22\x22>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<div\x20id=\x22mugshotDelete",
    "parentBtnRightActive",
    "OpacityMax",
    "parentBtnLeftActive",
    "hasClass",
    "eyeCategoryBtn",
    "6821865arKsaB",
    "hidden",
    "#saveCharBtn",
    ".multichar",
    ".png\x22\x20alt=\x22\x22>\x0a\x20\x20\x20\x20\x20\x20\x20\x20</div>\x0a\x20\x20\x20\x20\x20\x20\x20\x20",
    "#momsBtn",
    "[data-charid=\x22",
    "data-category",
    "closeSpawn",
    "display",
    ".sliderNegativeOpacity",
    ".box-2\x20.box-title",
    ".hairs-content",
    "TextureValue",
    "css",
    "2442932WghuyD",
    "\x0a\x20\x20\x20\x20\x20\x20\x20\x20<div\x20id=\x22mugshot",
    "saveSkinData",
    "rotatePed",
    ".my-4",
    "camcoords",
    ".png\x22\x20alt=\x22\x22\x20/>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20</div>\x0a\x20\x20\x20\x20\x20\x20\x20\x20",
    "#loadedCharCash",
    ".prevCam",
    "#momSimilarity",
    "#altGradient",
    "hasNegative",
    "replace",
    "/-1.png\x22\x20alt=\x22\x22\x20/>\x0a\x20\x20\x20\x20\x20\x20\x20\x20</div>\x0a\x20\x20\x20\x20\x20\x20\x20\x20<div\x20class=\x22flex\x20",
    "hair",
    "data-camcoordx",
    "updateMax",
    ".box-1\x20.place",
    "texture",
    "trigger",
    "append",
    "slider",
    "#dadsBtn",
    "head",
    "img",
    ".parentItem",
    "INICIAR",
    "#savedSkins",
    "openBarber",
    "setValues",
    "bank",
    "removeClass",
    "map",
    "-color\x20",
    "toLowerCase",
    "#firstZa",
    "parentItemActive",
    "\x0a\x20\x20\x20\x20\x20\x20\x20\x20<img\x20src=\x22./assets/icons/",
    "\x0a\x20\x20\x20\x20\x20\x20\x20\x20<div\x20class=\x22cursor-pointer\x20uppercase\x20parentItem\x20",
    "character",
    "from",
    "text",
    "open",
    "Category",
    "data-charid",
    "z-40",
    "createChar",
    "action",
    ".box-3\x20.box-title",
    "dads",
    "street",
    "55202iGoyLr",
    "body",
    "click",
    "active",
    "gender",
    "Btn\x22\x20id=\x22",
    ".hair-color-2",
    "\x20.box-title",
    "ready",
    "attr",
    "hide",
    "0px",
    "spawn",
    "slidechange",
    "name",
    ".svg\x22\x20alt=\x22",
  ];
  _0x3d22 = function () {
    return _0x3e5c5a;
  };
  return _0x3d22();
}
function closeKeycodeMenu() {
  var _0x42623d = _0x72da3a;
  $("#keycodeMenu")[_0x42623d(0x17c)](_0x42623d(0x24c)),
    setTimeout(function () {
      var _0x2e5160 = _0x42623d;
      $(_0x2e5160(0x1e2))[_0x2e5160(0x17c)](_0x2e5160(0x265));
    }, 0x96);
}
$(document)[_0x72da3a(0x164)](function () {
  var _0x1395c2 = _0x72da3a;
  $(_0x1395c2(0x1f0))[_0x1395c2(0x166)](),
    $(".multichar")[_0x1395c2(0x166)](),
    $(_0x1395c2(0x17e))["click"](function () {
      var _0x3c086e = _0x1395c2;
      apiPost(_0x3c086e(0x1e3), { type: currentOpenType });
    }),
    $(_0x1395c2(0x266))[_0x1395c2(0x15e)](function () {
      var _0x27d662 = _0x1395c2,
        _0x4c39dc = $(_0x27d662(0x21a))[_0x27d662(0x258)](),
        _0x56c064 = $(_0x27d662(0x1ca))["val"]();
      if (!validateName(_0x4c39dc, _0x56c064)) {
        errorNotify(_0x27d662(0x253));
        return;
      }
      apiPost(_0x27d662(0x1a4), {
        gender: _0x8c7945,
        firstname: _0x4c39dc,
        lastname: _0x56c064,
      }),
        $(_0x27d662(0x1f0))[_0x27d662(0x17c)](_0x27d662(0x265)),
        $(_0x27d662(0x1f0))[_0x27d662(0x166)](),
        $(_0x27d662(0x1ae))[_0x27d662(0x17c)](_0x27d662(0x265));
    }),
    $(document)[_0x1395c2(0x175)](function (_0x5744d4) {
      var _0x77696c = _0x1395c2;
      _0x5744d4[_0x77696c(0x1e5)] === "Escape" &&
        (currentOpenType == _0x77696c(0x1bc) ||
          currentOpenType == _0x77696c(0x259)) &&
        (apiPost(_0x77696c(0x1fa), { status: ![] }),
        $(_0x77696c(0x1f0))["addClass"](_0x77696c(0x265)),
        $(_0x77696c(0x1f0))[_0x77696c(0x166)](),
        $(_0x77696c(0x1ae))[_0x77696c(0x17c)](_0x77696c(0x265))),
        _0x5744d4[_0x77696c(0x1e5)][_0x77696c(0x14b)]() === "d" &&
          actualCategory !== _0x77696c(0x1b6) &&
          apiPost(_0x77696c(0x276), { mode: "left" }),
        _0x5744d4[_0x77696c(0x1e5)][_0x77696c(0x14b)]() === "a" &&
          actualCategory !== "DNA" &&
          apiPost("rotatePed", { mode: _0x77696c(0x176) });
    });
  let _0x8c7945 = "male";
  var _0x4f1b41 = 0x0,
    _0x5930dc = 0x0,
    _0xf7b62f = 0x0,
    _0x2cb60f = 0.5;
  let _0x489fe2 = 0x0;
  const _0x1f874f = defaultCams;
  let _0x1378dc = defaultValues;
  function _0x13d359(_0x174dfc) {
    var _0x5b34c0 = _0x1395c2;
    $(_0x5b34c0(0x200))[_0x5b34c0(0x16e)](
      _0x5b34c0(0x14e) +
        _0x174dfc +
        _0x5b34c0(0x16b) +
        _0x174dfc +
        _0x5b34c0(0x235)
    ),
      apiPost(_0x5b34c0(0x1aa), { value: _0x174dfc });
  }
  $(_0x1395c2(0x27b))[_0x1395c2(0x15e)](function () {
    var _0x8337fc = _0x1395c2;
    _0x489fe2 === 0x0
      ? (_0x489fe2 = _0x1f874f[_0x8337fc(0x1df)] - 0x1)
      : (_0x489fe2 -= 0x1),
      _0x1f874f[_0x489fe2] && _0x13d359(_0x1f874f[_0x489fe2]);
  }),
    $(_0x1395c2(0x1ec))[_0x1395c2(0x15e)](function () {
      var _0xee25f8 = _0x1395c2;
      _0x489fe2 === _0x1f874f[_0xee25f8(0x1df)] - 0x1
        ? (_0x489fe2 = 0x0)
        : (_0x489fe2 += 0x1),
        _0x1f874f[_0x489fe2] && _0x13d359(_0x1f874f[_0x489fe2]);
    }),
    $(_0x1395c2(0x1b5))["click"](function () {
      var _0x4e2fa7 = _0x1395c2;
      if (cachedMugshotCount >= 0x6) return;
      apiPost(
        _0x4e2fa7(0x275),
        { values: _0x1378dc, type: currentOpenType },
        function (_0x3672de) {
          registerSavedSkins(_0x3672de);
        }
      );
    });
  function _0xee5b2() {
    var _0x105869 = _0x1395c2;
    for (var _0x6c6335 in _0x1378dc) {
      (_0x1378dc[_0x6c6335][_0x105869(0x24a)] = 0x0),
        _0x1378dc[_0x6c6335][_0x105869(0x24b)] != ![] &&
          ((_0x1378dc[_0x6c6335][_0x105869(0x24b)][
            _0x1378dc[_0x6c6335]["value"]
          ] = { value: 0x0, max: 0x0 }),
          $("#" + _0x6c6335 + "TextureValue")[_0x105869(0x258)](
            _0x1378dc[_0x6c6335][_0x105869(0x24b)][
              _0x1378dc[_0x6c6335]["value"]
            ]["value"]
          ),
          $("#" + _0x6c6335 + _0x105869(0x1d1))[_0x105869(0x288)](
            _0x105869(0x24a),
            _0x1378dc[_0x6c6335][_0x105869(0x24b)][
              _0x1378dc[_0x6c6335]["value"]
            ][_0x105869(0x24a)]
          )),
        $("#" + _0x6c6335 + "Value")[_0x105869(0x258)](
          _0x1378dc[_0x6c6335]["value"]
        ),
        $("#" + _0x6c6335)[_0x105869(0x288)](
          _0x105869(0x24a),
          _0x1378dc[_0x6c6335][_0x105869(0x24a)]
        );
    }
    (_0x5930dc = 0x0),
      (_0x4f1b41 = 0x15),
      _0x8c7945 === _0x105869(0x246) ? (_0x2cb60f = 0x50) : (_0x2cb60f = 0x14),
      (_0xf7b62f = 0x0),
      $(_0x105869(0x1a9))[_0x105869(0x288)](_0x105869(0x24a), 0x0),
      $(_0x105869(0x27c))[_0x105869(0x288)](_0x105869(0x24a), _0x2cb60f),
      $(_0x105869(0x289))["click"]();
  }
  const _0xbe709e = [
    new PedVariation(_0x1395c2(0x281), 0x4a, _0x1395c2(0x270), ![], 0x1),
    new PedVariation("eyes", 0x1f, _0x1395c2(0x1ce), !![]),
    new PedVariation("blush", 0x20, ".blush-content", !![], 0x2),
    new PedVariation(_0x1395c2(0x1d0), 0x1c, _0x1395c2(0x182), !![], 0x1),
    new PedVariation(_0x1395c2(0x254), 0x50, _0x1395c2(0x1e1), !![], 0x2),
    new PedVariation("lipstick", 0x9, _0x1395c2(0x1c2), !![], 0x2),
    new PedVariation(_0x1395c2(0x25d), 0x21, _0x1395c2(0x248), !![], 0x1),
  ];
  apiPost(_0x1395c2(0x220), { type: 0x1 }, (_0x392bac) => {
    var _0x487497 = _0x1395c2;
    for (const [_0x42f85a, _0x32ef03] of Object["entries"](_0x392bac)) {
      const _0x3d0eb5 = rgbToHex(
        _0x32ef03["r"],
        _0x32ef03["g"],
        _0x32ef03["b"]
      );
      $(_0x487497(0x19e))[_0x487497(0x287)](
        _0x487497(0x217) +
          _0x42f85a +
          _0x487497(0x204) +
          _0x42f85a +
          "\x22\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20class=\x22hair-color-2\x20" +
          (_0x42f85a == 0x0 ? _0x487497(0x226) : "") +
          "\x20bg-[" +
          _0x3d0eb5 +
          "]\x20w-8\x20h-8\x20rounded\x22\x0a\x20\x20\x20\x20\x20\x20\x20\x20></div>\x0a\x20\x20\x20\x20\x20\x20"
      );
    }
    $(".hair-color-2")[_0x487497(0x15e)](function () {
      var _0x1c1cf5 = _0x487497,
        _0x55241b = parseInt($(this)[_0x1c1cf5(0x165)](_0x1c1cf5(0x1d8)));
      $(_0x1c1cf5(0x162))[_0x1c1cf5(0x148)](_0x1c1cf5(0x226)),
        $(this)["addClass"](_0x1c1cf5(0x226)),
        apiPost("updateSkin", {
          clothingType: _0x1c1cf5(0x1ab),
          articleNumber: _0x55241b,
          type: "texture",
        });
    });
  }),
    window[_0x1395c2(0x24f)]("message", function (_0x53495a) {
      var _0x43c47d = _0x1395c2;
      _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x1fe)] != undefined &&
        ((translations = _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x1fe)]),
        translate());
      let _0x5e2b05 = _0x53495a["data"];
      _0x5e2b05[_0x43c47d(0x198)] == "convert" &&
        Convert(_0x5e2b05["pMugShotTxd"], _0x5e2b05["id"]);
      switch (_0x53495a[_0x43c47d(0x191)][_0x43c47d(0x158)]) {
        case _0x43c47d(0x153):
          $(_0x43c47d(0x1b3))[_0x43c47d(0x18d)](),
            $(_0x43c47d(0x18f))[_0x43c47d(0x18d)](),
            $("#beardFaceSettings")[_0x43c47d(0x148)](_0x43c47d(0x265)),
            $(_0x43c47d(0x1ae))[_0x43c47d(0x148)]("hidden"),
            $(_0x43c47d(0x1b8))[_0x43c47d(0x148)](_0x43c47d(0x265)),
            $(_0x43c47d(0x1b7))[_0x43c47d(0x16e)](_0x43c47d(0x1f9)),
            (currentOpenType = _0x43c47d(0x150)),
            $(_0x43c47d(0x1ea))[_0x43c47d(0x148)](_0x43c47d(0x24c)),
            $(".category-btn")[_0x43c47d(0x17c)]("opacity-50"),
            $(".category-btn")[_0x43c47d(0x17c)](_0x43c47d(0x21b)),
            $(_0x43c47d(0x1ea))[_0x43c47d(0x15e)](function () {
              var _0x3657ef = _0x43c47d;
              $(_0x3657ef(0x25a))[_0x3657ef(0x1cb)](0x64);
              var _0x54b9a4 = $(this)[_0x3657ef(0x165)]("data-category");
              actualCategory = _0x54b9a4;
              var _0x259f4d = $(this)["attr"](_0x3657ef(0x1b4));
              _0x13d359(_0x259f4d),
                setTimeout(function () {
                  var _0x27cedb = _0x3657ef;
                  $("#" + _0x54b9a4 + _0x27cedb(0x154))[_0x27cedb(0x1da)](0x64),
                    $("#" + _0x54b9a4 + _0x27cedb(0x154))[_0x27cedb(0x272)](
                      _0x27cedb(0x26d),
                      _0x27cedb(0x218)
                    );
                }, 0x64),
                $(".category-btn")[_0x3657ef(0x148)](_0x3657ef(0x174)),
                $(_0x3657ef(0x1ea))[_0x3657ef(0x17c)]("opacity-50"),
                $(_0x3657ef(0x1ea))[_0x3657ef(0x148)](_0x3657ef(0x212)),
                $(_0x3657ef(0x1ea))[_0x3657ef(0x17c)]("h-[200px]"),
                $(this)[_0x3657ef(0x17c)](_0x3657ef(0x174)),
                $(this)[_0x3657ef(0x148)](_0x3657ef(0x21d)),
                $(".my-4")[_0x3657ef(0x148)](_0x3657ef(0x19a)),
                $(this)["addClass"](_0x3657ef(0x19a)),
                $(this)[_0x3657ef(0x17c)](_0x3657ef(0x212));
              var _0x4d0f14 = $(this)[_0x3657ef(0x231)]() - 0x2;
              _0x4d0f14 == 0x1
                ? ($(_0x3657ef(0x1ee))[_0x3657ef(0x272)](
                    _0x3657ef(0x192),
                    _0x3657ef(0x167)
                  ),
                  $(_0x3657ef(0x1ee))[_0x3657ef(0x272)](
                    _0x3657ef(0x26d),
                    _0x3657ef(0x1fc)
                  ),
                  $(_0x3657ef(0x27d))[_0x3657ef(0x272)](
                    _0x3657ef(0x192),
                    "686px"
                  ),
                  $(_0x3657ef(0x251))[_0x3657ef(0x272)](
                    _0x3657ef(0x22f),
                    _0x4d0f14 * 0xc8 - 0xc8 + "px"
                  ))
                : $(_0x3657ef(0x1ee))[_0x3657ef(0x272)](
                    _0x3657ef(0x26d),
                    "block"
                  );
              $("#altGradient")[_0x3657ef(0x272)](
                _0x3657ef(0x26d),
                _0x3657ef(0x20c)
              );
              var _0x15ebf8 = 0x5 - _0x4d0f14,
                _0x141ee1 = 0x5 - _0x15ebf8 - 0x1,
                _0x557424 = _0x141ee1 * 0xc8;
              $(_0x3657ef(0x1ee))[_0x3657ef(0x272)](
                _0x3657ef(0x192),
                _0x557424 - 0x5
              ),
                $(_0x3657ef(0x251))[_0x3657ef(0x272)](
                  "top",
                  _0x4d0f14 * 0xc8 - 0xc8 + 0x1b + 0x1b + "px"
                ),
                $("#altGradient")[_0x3657ef(0x272)](
                  _0x3657ef(0x192),
                  _0x15ebf8 * 0xc8 + 0xf + "px"
                ),
                $(_0x3657ef(0x251))[_0x3657ef(0x272)](
                  "top",
                  _0x4d0f14 * 0xc8 - 0xc8 + "px"
                ),
                _0x4d0f14 == 0x5 &&
                  $(_0x3657ef(0x27d))[_0x3657ef(0x272)](
                    _0x3657ef(0x26d),
                    _0x3657ef(0x1fc)
                  ),
                $(_0x3657ef(0x251))[_0x3657ef(0x17c)]("my-4"),
                (currentIndex = _0x4d0f14);
            }),
            $(_0x43c47d(0x1f0))[_0x43c47d(0x148)]("hidden"),
            $(_0x43c47d(0x1f0))["show"]();
          _0x53495a[_0x43c47d(0x191)]["gender"] == 0x1 &&
            $(_0x43c47d(0x1b2))[_0x43c47d(0x15e)]();
          _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x160)] == 0x0 &&
            $(_0x43c47d(0x21e))[_0x43c47d(0x15e)]();
          registerSavedSkins(_0x53495a["data"][_0x43c47d(0x22e)]),
            apiPost(_0x43c47d(0x1aa), { value: _0x43c47d(0x15d) }),
            $(_0x43c47d(0x14c))[_0x43c47d(0x15e)]();
          break;
        case _0x43c47d(0x145):
          $(_0x43c47d(0x1b3))["show"](),
            $("#categories")[_0x43c47d(0x18d)](),
            $(_0x43c47d(0x23e))[_0x43c47d(0x18d)](),
            (actualCategory = "BARBER"),
            $(_0x43c47d(0x1b7))[_0x43c47d(0x16e)](
              _0x43c47d(0x241) +
                _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x24e)] +
                ")"
            ),
            (currentOpenType = _0x43c47d(0x1bc)),
            _0x13d359(_0x43c47d(0x28a)),
            $(_0x43c47d(0x1ea))[_0x43c47d(0x148)](_0x43c47d(0x21d)),
            $(".category-btn")[_0x43c47d(0x148)](_0x43c47d(0x21b)),
            $(".cam")[_0x43c47d(0x148)](_0x43c47d(0x265)),
            $(_0x43c47d(0x1ea))[_0x43c47d(0x17c)](_0x43c47d(0x24c)),
            $("#firstZa")[_0x43c47d(0x19b)]("click");
          const _0x5953d2 = {
            CABELO: _0x43c47d(0x21f),
            BOCA: _0x43c47d(0x1eb),
            NARIZ: _0x43c47d(0x224),
            OLHOS: _0x43c47d(0x263),
          };
          _0x53495a[_0x43c47d(0x191)]["categories"] &&
            _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x1dc)][_0x43c47d(0x1df)] >
              0x0 &&
            _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x1dc)][_0x43c47d(0x149)](
              (_0x1e7074) => {
                var _0x255da1 = _0x43c47d;
                _0x5953d2[_0x1e7074] &&
                  ($("#" + _0x5953d2[_0x1e7074])[_0x255da1(0x148)](
                    _0x255da1(0x24c)
                  ),
                  $("#" + _0x5953d2[_0x1e7074])[_0x255da1(0x148)](
                    _0x255da1(0x265)
                  ),
                  $("#" + _0x5953d2[_0x1e7074])[_0x255da1(0x17c)](
                    _0x255da1(0x21b)
                  ),
                  $("#" + _0x5953d2[_0x1e7074])["addClass"](_0x255da1(0x156)),
                  $("#" + _0x5953d2[_0x1e7074])["off"](_0x255da1(0x15e)),
                  $("#" + _0x5953d2[_0x1e7074])[_0x255da1(0x15e)](function () {
                    var _0x1b4b3c = _0x255da1;
                    $(".categoryGroup")[_0x1b4b3c(0x1cb)](0x64);
                    var _0x1a77c5 = $(this)[_0x1b4b3c(0x165)]("data-category");
                    (actualCategory = _0x1a77c5),
                      setTimeout(function () {
                        var _0x2a7779 = _0x1b4b3c;
                        $("#" + _0x1a77c5 + _0x2a7779(0x154))[_0x2a7779(0x1da)](
                          0x64
                        ),
                          $("#" + _0x1a77c5 + _0x2a7779(0x154))[
                            _0x2a7779(0x272)
                          ](_0x2a7779(0x26d), _0x2a7779(0x218));
                      }, 0x64),
                      $(".category-btn")[_0x1b4b3c(0x148)](_0x1b4b3c(0x174)),
                      $(_0x1b4b3c(0x1ea))[_0x1b4b3c(0x17c)]("opacity-50"),
                      $(".category-btn")[_0x1b4b3c(0x148)](_0x1b4b3c(0x212)),
                      $(_0x1b4b3c(0x1ea))["addClass"](_0x1b4b3c(0x234)),
                      $(this)[_0x1b4b3c(0x17c)](_0x1b4b3c(0x174)),
                      $(this)[_0x1b4b3c(0x148)](_0x1b4b3c(0x24c)),
                      $(this)["removeClass"](_0x1b4b3c(0x21d)),
                      $(this)[_0x1b4b3c(0x17c)](_0x1b4b3c(0x19a)),
                      $(this)[_0x1b4b3c(0x17c)](_0x1b4b3c(0x212)),
                      $(".my-4")[_0x1b4b3c(0x148)](_0x1b4b3c(0x19a));
                    var _0x4d6c63 = $(this)["index"]() - 0x2;
                    _0x4d6c63 == 0x1
                      ? ($("#ustGradient")[_0x1b4b3c(0x272)](
                          _0x1b4b3c(0x192),
                          _0x1b4b3c(0x167)
                        ),
                        $(_0x1b4b3c(0x1ee))["css"](
                          _0x1b4b3c(0x26d),
                          _0x1b4b3c(0x1fc)
                        ),
                        $(_0x1b4b3c(0x27d))[_0x1b4b3c(0x272)](
                          _0x1b4b3c(0x192),
                          _0x1b4b3c(0x1d5)
                        ),
                        $(_0x1b4b3c(0x251))["css"](
                          _0x1b4b3c(0x22f),
                          _0x4d6c63 * 0xc8 - 0xc8 + "px"
                        ))
                      : $(_0x1b4b3c(0x1ee))[_0x1b4b3c(0x272)](
                          _0x1b4b3c(0x26d),
                          "block"
                        );
                    $(_0x1b4b3c(0x27d))[_0x1b4b3c(0x272)](
                      _0x1b4b3c(0x26d),
                      _0x1b4b3c(0x20c)
                    );
                    var _0x5be612 = 0x5 - _0x4d6c63,
                      _0x2e3cab = 0x5 - _0x5be612 - 0x1,
                      _0xab5a90 = _0x2e3cab * 0xc8 + 0x16;
                    $(_0x1b4b3c(0x1ee))[_0x1b4b3c(0x272)](
                      _0x1b4b3c(0x192),
                      _0xab5a90
                    ),
                      $(_0x1b4b3c(0x27d))[_0x1b4b3c(0x272)](
                        _0x1b4b3c(0x192),
                        _0x5be612 * 0xc8 - 0xf + "px"
                      ),
                      $(_0x1b4b3c(0x251))[_0x1b4b3c(0x272)](
                        _0x1b4b3c(0x22f),
                        _0x4d6c63 * 0xc8 - 0xc8 + 0x1b + "px"
                      ),
                      _0x4d6c63 == 0x5 &&
                        $(_0x1b4b3c(0x27d))[_0x1b4b3c(0x272)](
                          _0x1b4b3c(0x26d),
                          _0x1b4b3c(0x1fc)
                        ),
                      $(_0x1b4b3c(0x251))[_0x1b4b3c(0x17c)](_0x1b4b3c(0x19a)),
                      (currentIndex = _0x4d6c63);
                  }));
              }
            );
          $(_0x43c47d(0x193))[_0x43c47d(0x15e)](),
            $(_0x43c47d(0x1f0))[_0x43c47d(0x148)](_0x43c47d(0x265)),
            $(_0x43c47d(0x1f0))[_0x43c47d(0x18d)](),
            $(_0x43c47d(0x266))[_0x43c47d(0x19b)]("click"),
            $(_0x43c47d(0x266))["click"](function () {
              var _0xcd1d5a = _0x43c47d;
              apiPost("saveSkin"),
                $(_0xcd1d5a(0x1f0))[_0xcd1d5a(0x17c)](_0xcd1d5a(0x265)),
                $(_0xcd1d5a(0x1f0))[_0xcd1d5a(0x166)](),
                $(_0xcd1d5a(0x1ae))[_0xcd1d5a(0x17c)](_0xcd1d5a(0x265));
            }),
            registerSavedSkins(_0x53495a[_0x43c47d(0x191)][_0x43c47d(0x22e)]);
          _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x160)] === 0x1
            ? _0xbe709e[_0x43c47d(0x149)]((_0x4c290d) => {
                var _0x369f11 = _0x43c47d;
                _0x4c290d[_0x369f11(0x1ef)](_0x369f11(0x1a3));
              })
            : _0xbe709e[_0x43c47d(0x149)]((_0xbca9f0) => {
                var _0x35475f = _0x43c47d;
                _0xbca9f0["setSex"](_0x35475f(0x246));
              });
          break;
        case _0x43c47d(0x256):
          $(_0x43c47d(0x1b3))[_0x43c47d(0x18d)](),
            $(_0x43c47d(0x18f))[_0x43c47d(0x18d)](),
            $("#beardFaceSettings")["removeClass"]("hidden"),
            $(_0x43c47d(0x1b8))[_0x43c47d(0x17c)](_0x43c47d(0x265)),
            $(_0x43c47d(0x1b7))[_0x43c47d(0x16e)](
              _0x43c47d(0x1d4) + _0x53495a["data"][_0x43c47d(0x24e)] + ")"
            ),
            (currentOpenType = _0x43c47d(0x259)),
            $(_0x43c47d(0x266))[_0x43c47d(0x19b)](_0x43c47d(0x15e)),
            $(_0x43c47d(0x266))[_0x43c47d(0x15e)](function () {
              var _0x384d98 = _0x43c47d;
              currentOpenType == _0x384d98(0x259) &&
                (apiPost("saveSkin"),
                $(_0x384d98(0x1f0))[_0x384d98(0x17c)](_0x384d98(0x265)),
                $(".bodyBGG")[_0x384d98(0x166)](),
                $(_0x384d98(0x1ae))[_0x384d98(0x17c)](_0x384d98(0x265)));
            }),
            $(".category-btn")[_0x43c47d(0x148)](_0x43c47d(0x24c)),
            $(_0x43c47d(0x1ea))["addClass"](_0x43c47d(0x21d)),
            $(_0x43c47d(0x1ea))[_0x43c47d(0x17c)](_0x43c47d(0x21b)),
            $(_0x43c47d(0x1ea))[_0x43c47d(0x19b)]("click"),
            $(".category-btn")[_0x43c47d(0x15e)](function () {
              var _0x386fd6 = _0x43c47d,
                _0x3c1fa2 = $(this)[_0x386fd6(0x165)]("data-category");
              (actualCategory = _0x3c1fa2),
                $(_0x386fd6(0x25a))[_0x386fd6(0x1cb)](0x64);
              var _0x3972c9 = $(this)[_0x386fd6(0x165)](_0x386fd6(0x1b4));
              _0x13d359(_0x3972c9),
                setTimeout(function () {
                  var _0xa901c4 = _0x386fd6;
                  $("#" + _0x3c1fa2 + _0xa901c4(0x154))[_0xa901c4(0x1da)](0x64),
                    $("#" + _0x3c1fa2 + _0xa901c4(0x154))[_0xa901c4(0x272)](
                      _0xa901c4(0x26d),
                      _0xa901c4(0x218)
                    );
                }, 0x64),
                $(_0x386fd6(0x1ea))[_0x386fd6(0x148)](_0x386fd6(0x174)),
                $(_0x386fd6(0x1ea))[_0x386fd6(0x17c)](_0x386fd6(0x21d)),
                $(".category-btn")[_0x386fd6(0x148)](_0x386fd6(0x212)),
                $(_0x386fd6(0x1ea))["addClass"](_0x386fd6(0x234)),
                $(this)[_0x386fd6(0x17c)](_0x386fd6(0x174)),
                $(this)["removeClass"]("opacity-50"),
                $(_0x386fd6(0x277))["removeClass"](_0x386fd6(0x19a)),
                $(this)[_0x386fd6(0x17c)](_0x386fd6(0x19a)),
                $(this)[_0x386fd6(0x17c)]("h-[227px]");
              var _0x1c002d = $(this)["index"]() - 0x2;
              _0x1c002d == 0x1
                ? ($(_0x386fd6(0x1ee))["css"](
                    _0x386fd6(0x192),
                    _0x386fd6(0x167)
                  ),
                  $(_0x386fd6(0x1ee))[_0x386fd6(0x272)](
                    "display",
                    _0x386fd6(0x1fc)
                  ),
                  $(_0x386fd6(0x27d))[_0x386fd6(0x272)](
                    _0x386fd6(0x192),
                    "686px"
                  ),
                  $(_0x386fd6(0x251))["css"](
                    "top",
                    _0x1c002d * 0xc8 - 0xc8 + "px"
                  ))
                : $(_0x386fd6(0x1ee))[_0x386fd6(0x272)](
                    _0x386fd6(0x26d),
                    _0x386fd6(0x20c)
                  );
              $(_0x386fd6(0x27d))[_0x386fd6(0x272)](
                "display",
                _0x386fd6(0x20c)
              );
              var _0x52b571 = 0x5 - _0x1c002d,
                _0x5b524b = 0x5 - _0x52b571 - 0x1,
                _0x513269 = _0x5b524b * 0xc8;
              $("#ustGradient")[_0x386fd6(0x272)](
                _0x386fd6(0x192),
                _0x513269 - 0x5
              ),
                $(_0x386fd6(0x251))[_0x386fd6(0x272)](
                  "top",
                  _0x1c002d * 0xc8 - 0xc8 + 0x1b + 0x1b + "px"
                ),
                $(_0x386fd6(0x27d))[_0x386fd6(0x272)](
                  _0x386fd6(0x192),
                  _0x52b571 * 0xc8 + 0xf + "px"
                ),
                $(_0x386fd6(0x251))["css"](
                  _0x386fd6(0x22f),
                  _0x1c002d * 0xc8 - 0xc8 + "px"
                ),
                _0x1c002d == 0x5 &&
                  $(_0x386fd6(0x27d))[_0x386fd6(0x272)](
                    _0x386fd6(0x26d),
                    _0x386fd6(0x1fc)
                  ),
                $(_0x386fd6(0x251))[_0x386fd6(0x17c)]("my-4"),
                (currentIndex = _0x1c002d);
            }),
            $(_0x43c47d(0x14c))[_0x43c47d(0x15e)](),
            $(_0x43c47d(0x1f0))["removeClass"](_0x43c47d(0x265)),
            $(".bodyBGG")[_0x43c47d(0x18d)](),
            registerSavedSkins(_0x53495a[_0x43c47d(0x191)]["saved"]);
          break;
        case "openSpawn":
          let _0x52d179 = _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x1c9)];
          for (let _0x37277e = 0x0; _0x37277e < 0x5; _0x37277e++) {
            let _0x59ecb7 = _0x52d179[_0x37277e];
            if (!_0x59ecb7) {
              $(".box-" + (_0x37277e + 0x2))[_0x43c47d(0x17c)]("disabled"),
                $(_0x43c47d(0x243) + (_0x37277e + 0x2))[_0x43c47d(0x165)](
                  "data-camcoordx",
                  ""
                ),
                $(_0x43c47d(0x243) + (_0x37277e + 0x2))[_0x43c47d(0x165)](
                  "data-camcoordy",
                  ""
                ),
                $(".box-" + (_0x37277e + 0x2))[_0x43c47d(0x165)](
                  "data-camcoordz",
                  ""
                ),
                $(".box-" + (_0x37277e + 0x2))[_0x43c47d(0x165)](
                  "data-spawncoordx",
                  ""
                ),
                $(_0x43c47d(0x243) + (_0x37277e + 0x2))[_0x43c47d(0x165)](
                  _0x43c47d(0x23a),
                  ""
                ),
                $(_0x43c47d(0x243) + (_0x37277e + 0x2))["attr"](
                  _0x43c47d(0x1ad),
                  ""
                ),
                $(".box-" + (_0x37277e + 0x2))[_0x43c47d(0x165)](
                  _0x43c47d(0x17d),
                  ""
                ),
                $(".box-" + (_0x37277e + 0x2) + _0x43c47d(0x22a))[
                  _0x43c47d(0x152)
                ](""),
                $(".box-" + (_0x37277e + 0x2) + _0x43c47d(0x163))[
                  _0x43c47d(0x152)
                ](""),
                $(_0x43c47d(0x243) + (_0x37277e + 0x2) + _0x43c47d(0x17b))[
                  _0x43c47d(0x165)
                ](_0x43c47d(0x23d), "");
              continue;
            }
            $(".box-" + (_0x37277e + 0x2))[_0x43c47d(0x148)](_0x43c47d(0x1db)),
              $(".box-" + (_0x37277e + 0x2))[_0x43c47d(0x165)](
                "data-camcoordx",
                _0x59ecb7[_0x43c47d(0x278)]["x"]
              ),
              $(_0x43c47d(0x243) + (_0x37277e + 0x2))[_0x43c47d(0x165)](
                _0x43c47d(0x225),
                _0x59ecb7[_0x43c47d(0x278)]["y"]
              ),
              $(_0x43c47d(0x243) + (_0x37277e + 0x2))[_0x43c47d(0x165)](
                _0x43c47d(0x1ff),
                _0x59ecb7["camcoords"]["z"]
              ),
              $(_0x43c47d(0x243) + (_0x37277e + 0x2))["attr"](
                "data-spawncoordx",
                _0x59ecb7["spawncoords"]["x"]
              ),
              $(_0x43c47d(0x243) + (_0x37277e + 0x2))[_0x43c47d(0x165)](
                _0x43c47d(0x23a),
                _0x59ecb7[_0x43c47d(0x17f)]["y"]
              ),
              $(_0x43c47d(0x243) + (_0x37277e + 0x2))[_0x43c47d(0x165)](
                _0x43c47d(0x1ad),
                _0x59ecb7[_0x43c47d(0x17f)]["z"]
              ),
              $(".box-" + (_0x37277e + 0x2))[_0x43c47d(0x165)](
                _0x43c47d(0x17d),
                _0x37277e
              ),
              $(_0x43c47d(0x243) + (_0x37277e + 0x2) + _0x43c47d(0x22a))[
                "text"
              ](_0x59ecb7[_0x43c47d(0x16a)]),
              $(".box-" + (_0x37277e + 0x2) + _0x43c47d(0x163))[
                _0x43c47d(0x152)
              ](_0x59ecb7["street"]),
              $(_0x43c47d(0x243) + (_0x37277e + 0x2) + _0x43c47d(0x17b))[
                _0x43c47d(0x165)
              ](
                _0x43c47d(0x23d),
                _0x43c47d(0x1e8) + _0x59ecb7[_0x43c47d(0x28b)]
              );
          }
          $(document)["on"]("click", _0x43c47d(0x1f2), function () {
            var _0x22a3cb = _0x43c47d;
            if ($(this)[_0x22a3cb(0x262)](_0x22a3cb(0x1db))) return;
            if (!$(this)[_0x22a3cb(0x262)](_0x22a3cb(0x15f))) {
              let _0x4728c3 = $(this)[_0x22a3cb(0x165)](_0x22a3cb(0x17d));
              _0x4728c3 = parseInt(_0x4728c3);
              let _0x2a5d8b = _0x52d179[_0x4728c3 - 0x2],
                _0x55c342 = _0x52d179[_0x4728c3 - 0x1],
                _0x33c012 = _0x52d179[_0x4728c3],
                _0x143ef7 = _0x52d179[_0x4728c3 + 0x1],
                _0x4f400f = _0x52d179[_0x4728c3 + 0x2];
              $(_0x22a3cb(0x1f2))[_0x22a3cb(0x148)](_0x22a3cb(0x1db)),
                apiPost(_0x22a3cb(0x245), {
                  x: $(this)[_0x22a3cb(0x165)](_0x22a3cb(0x282)),
                  y: $(this)[_0x22a3cb(0x165)]("data-camcoordy"),
                  z: $(this)[_0x22a3cb(0x165)](_0x22a3cb(0x1ff)),
                }),
                _0x2a5d8b
                  ? ($(_0x22a3cb(0x284))["text"](_0x2a5d8b[_0x22a3cb(0x16a)]),
                    $(_0x22a3cb(0x1d3))[_0x22a3cb(0x152)](
                      _0x2a5d8b[_0x22a3cb(0x15b)]
                    ),
                    $(_0x22a3cb(0x1f1))[_0x22a3cb(0x165)](
                      _0x22a3cb(0x23d),
                      _0x22a3cb(0x1e8) + _0x2a5d8b[_0x22a3cb(0x28b)]
                    ),
                    $(_0x22a3cb(0x25b))[_0x22a3cb(0x165)](
                      _0x22a3cb(0x282),
                      _0x2a5d8b["camcoords"]["x"]
                    ),
                    $(".box-1")[_0x22a3cb(0x165)](
                      "data-camcoordy",
                      _0x2a5d8b[_0x22a3cb(0x278)]["y"]
                    ),
                    $(_0x22a3cb(0x25b))[_0x22a3cb(0x165)](
                      _0x22a3cb(0x1ff),
                      _0x2a5d8b[_0x22a3cb(0x278)]["z"]
                    ),
                    $(_0x22a3cb(0x25b))[_0x22a3cb(0x165)](
                      _0x22a3cb(0x219),
                      _0x2a5d8b["spawncoords"]["x"]
                    ),
                    $(".box-1")["attr"](
                      _0x22a3cb(0x23a),
                      _0x2a5d8b["spawncoords"]["y"]
                    ),
                    $(_0x22a3cb(0x25b))[_0x22a3cb(0x165)](
                      "data-spawncoordz",
                      _0x2a5d8b[_0x22a3cb(0x17f)]["z"]
                    ),
                    $(_0x22a3cb(0x25b))["attr"](
                      _0x22a3cb(0x17d),
                      _0x4728c3 - 0x2
                    ))
                  : ($(_0x22a3cb(0x25b))[_0x22a3cb(0x17c)](_0x22a3cb(0x1db)),
                    $(_0x22a3cb(0x284))["text"](""),
                    $(".box-1\x20.box-title")["text"](""),
                    $(_0x22a3cb(0x1f1))[_0x22a3cb(0x165)]("src", ""),
                    $(_0x22a3cb(0x25b))[_0x22a3cb(0x165)]("data-camcoordx", ""),
                    $(_0x22a3cb(0x25b))[_0x22a3cb(0x165)](_0x22a3cb(0x225), ""),
                    $(_0x22a3cb(0x25b))["attr"](_0x22a3cb(0x1ff), ""),
                    $(_0x22a3cb(0x25b))[_0x22a3cb(0x165)](_0x22a3cb(0x219), ""),
                    $(_0x22a3cb(0x25b))["attr"](_0x22a3cb(0x23a), ""),
                    $(_0x22a3cb(0x25b))[_0x22a3cb(0x165)](_0x22a3cb(0x227), ""),
                    $(_0x22a3cb(0x25b))[_0x22a3cb(0x165)](
                      _0x22a3cb(0x17d),
                      ""
                    )),
                _0x55c342
                  ? ($(_0x22a3cb(0x1c6))[_0x22a3cb(0x152)](
                      _0x55c342[_0x22a3cb(0x16a)]
                    ),
                    $(_0x22a3cb(0x26f))[_0x22a3cb(0x152)](
                      _0x55c342[_0x22a3cb(0x15b)]
                    ),
                    $(_0x22a3cb(0x1e4))["attr"](
                      _0x22a3cb(0x23d),
                      _0x22a3cb(0x1e8) + _0x55c342[_0x22a3cb(0x28b)]
                    ),
                    $(".box-2")["attr"](
                      "data-camcoordx",
                      _0x55c342["camcoords"]["x"]
                    ),
                    $(_0x22a3cb(0x209))[_0x22a3cb(0x165)](
                      _0x22a3cb(0x225),
                      _0x55c342[_0x22a3cb(0x278)]["y"]
                    ),
                    $(_0x22a3cb(0x209))[_0x22a3cb(0x165)](
                      _0x22a3cb(0x1ff),
                      _0x55c342[_0x22a3cb(0x278)]["z"]
                    ),
                    $(_0x22a3cb(0x209))[_0x22a3cb(0x165)](
                      "data-spawncoordx",
                      _0x55c342[_0x22a3cb(0x17f)]["x"]
                    ),
                    $(_0x22a3cb(0x209))[_0x22a3cb(0x165)](
                      _0x22a3cb(0x23a),
                      _0x55c342[_0x22a3cb(0x17f)]["y"]
                    ),
                    $(_0x22a3cb(0x209))[_0x22a3cb(0x165)](
                      _0x22a3cb(0x1ad),
                      _0x55c342["spawncoords"]["z"]
                    ),
                    $(_0x22a3cb(0x209))[_0x22a3cb(0x165)](
                      _0x22a3cb(0x17d),
                      _0x4728c3 - 0x1
                    ))
                  : ($(_0x22a3cb(0x209))[_0x22a3cb(0x17c)](_0x22a3cb(0x1db)),
                    $(".box-2\x20.place")[_0x22a3cb(0x152)](""),
                    $(".box-2\x20.box-title")[_0x22a3cb(0x152)](""),
                    $(_0x22a3cb(0x1e4))[_0x22a3cb(0x165)](_0x22a3cb(0x23d), ""),
                    $(_0x22a3cb(0x209))[_0x22a3cb(0x165)](_0x22a3cb(0x282), ""),
                    $(_0x22a3cb(0x209))["attr"](_0x22a3cb(0x225), ""),
                    $(_0x22a3cb(0x209))[_0x22a3cb(0x165)](_0x22a3cb(0x1ff), ""),
                    $(".box-2")["attr"](_0x22a3cb(0x219), ""),
                    $(_0x22a3cb(0x209))[_0x22a3cb(0x165)](_0x22a3cb(0x23a), ""),
                    $(".box-2")[_0x22a3cb(0x165)]("data-spawncoordz", ""),
                    $(".box-2")["attr"](_0x22a3cb(0x17d), "")),
                _0x33c012 &&
                  ($(_0x22a3cb(0x173))[_0x22a3cb(0x152)](_0x33c012["name"]),
                  $(_0x22a3cb(0x159))[_0x22a3cb(0x152)](
                    _0x33c012[_0x22a3cb(0x15b)]
                  ),
                  $(".box-3\x20.box-img\x20img")[_0x22a3cb(0x165)](
                    _0x22a3cb(0x23d),
                    _0x22a3cb(0x1e8) + _0x33c012["img"]
                  ),
                  $(_0x22a3cb(0x18b))[_0x22a3cb(0x165)](
                    "data-camcoordx",
                    _0x33c012[_0x22a3cb(0x278)]["x"]
                  ),
                  $(_0x22a3cb(0x18b))[_0x22a3cb(0x165)](
                    _0x22a3cb(0x225),
                    _0x33c012[_0x22a3cb(0x278)]["y"]
                  ),
                  $(_0x22a3cb(0x18b))["attr"](
                    _0x22a3cb(0x1ff),
                    _0x33c012[_0x22a3cb(0x278)]["z"]
                  ),
                  $(_0x22a3cb(0x18b))["attr"](
                    _0x22a3cb(0x219),
                    _0x33c012[_0x22a3cb(0x17f)]["x"]
                  ),
                  $(".box-3")[_0x22a3cb(0x165)](
                    "data-spawncoordy",
                    _0x33c012[_0x22a3cb(0x17f)]["y"]
                  ),
                  $(".box-3")[_0x22a3cb(0x165)](
                    _0x22a3cb(0x1ad),
                    _0x33c012[_0x22a3cb(0x17f)]["z"]
                  ),
                  $(".box-3")[_0x22a3cb(0x165)](_0x22a3cb(0x17d), _0x4728c3)),
                _0x143ef7
                  ? ($(_0x22a3cb(0x18c))[_0x22a3cb(0x152)](
                      _0x143ef7[_0x22a3cb(0x16a)]
                    ),
                    $(_0x22a3cb(0x1c0))["text"](_0x143ef7[_0x22a3cb(0x15b)]),
                    $(_0x22a3cb(0x21c))[_0x22a3cb(0x165)](
                      _0x22a3cb(0x23d),
                      _0x22a3cb(0x1e8) + _0x143ef7[_0x22a3cb(0x28b)]
                    ),
                    $(_0x22a3cb(0x1a8))["attr"](
                      _0x22a3cb(0x282),
                      _0x143ef7[_0x22a3cb(0x278)]["x"]
                    ),
                    $(_0x22a3cb(0x1a8))[_0x22a3cb(0x165)](
                      _0x22a3cb(0x225),
                      _0x143ef7[_0x22a3cb(0x278)]["y"]
                    ),
                    $(_0x22a3cb(0x1a8))[_0x22a3cb(0x165)](
                      "data-camcoordz",
                      _0x143ef7[_0x22a3cb(0x278)]["z"]
                    ),
                    $(_0x22a3cb(0x1a8))["attr"](
                      _0x22a3cb(0x219),
                      _0x143ef7[_0x22a3cb(0x17f)]["x"]
                    ),
                    $(_0x22a3cb(0x1a8))["attr"](
                      _0x22a3cb(0x23a),
                      _0x143ef7[_0x22a3cb(0x17f)]["y"]
                    ),
                    $(_0x22a3cb(0x1a8))[_0x22a3cb(0x165)](
                      _0x22a3cb(0x1ad),
                      _0x143ef7[_0x22a3cb(0x17f)]["z"]
                    ),
                    $(_0x22a3cb(0x1a8))[_0x22a3cb(0x165)](
                      "data-id",
                      _0x4728c3 + 0x1
                    ))
                  : ($(_0x22a3cb(0x1a8))[_0x22a3cb(0x17c)](_0x22a3cb(0x1db)),
                    $(_0x22a3cb(0x18c))["text"](""),
                    $(".box-4\x20.box-title")[_0x22a3cb(0x152)](""),
                    $(".box-4\x20.box-img\x20img")["attr"](
                      _0x22a3cb(0x23d),
                      ""
                    ),
                    $(_0x22a3cb(0x1a8))[_0x22a3cb(0x165)](_0x22a3cb(0x282), ""),
                    $(_0x22a3cb(0x1a8))[_0x22a3cb(0x165)]("data-camcoordy", ""),
                    $(".box-4")["attr"](_0x22a3cb(0x1ff), ""),
                    $(_0x22a3cb(0x1a8))[_0x22a3cb(0x165)](_0x22a3cb(0x219), ""),
                    $(_0x22a3cb(0x1a8))[_0x22a3cb(0x165)](
                      "data-spawncoordy",
                      ""
                    ),
                    $(_0x22a3cb(0x1a8))[_0x22a3cb(0x165)](_0x22a3cb(0x1ad), ""),
                    $(_0x22a3cb(0x1a8))["attr"]("data-id", "")),
                _0x4f400f
                  ? ($(".box-5\x20.place")[_0x22a3cb(0x152)](
                      _0x4f400f[_0x22a3cb(0x16a)]
                    ),
                    $(_0x22a3cb(0x1e6))[_0x22a3cb(0x152)](
                      _0x4f400f[_0x22a3cb(0x15b)]
                    ),
                    $(".box-5\x20.box-img\x20img")["attr"](
                      _0x22a3cb(0x23d),
                      _0x22a3cb(0x1e8) + _0x4f400f[_0x22a3cb(0x28b)]
                    ),
                    $(_0x22a3cb(0x190))[_0x22a3cb(0x165)](
                      _0x22a3cb(0x282),
                      _0x4f400f[_0x22a3cb(0x278)]["x"]
                    ),
                    $(_0x22a3cb(0x190))[_0x22a3cb(0x165)](
                      "data-camcoordy",
                      _0x4f400f[_0x22a3cb(0x278)]["y"]
                    ),
                    $(_0x22a3cb(0x190))[_0x22a3cb(0x165)](
                      _0x22a3cb(0x1ff),
                      _0x4f400f[_0x22a3cb(0x278)]["z"]
                    ),
                    $(_0x22a3cb(0x190))["attr"](
                      "data-spawncoordx",
                      _0x4f400f[_0x22a3cb(0x17f)]["x"]
                    ),
                    $(_0x22a3cb(0x190))[_0x22a3cb(0x165)](
                      _0x22a3cb(0x23a),
                      _0x4f400f[_0x22a3cb(0x17f)]["y"]
                    ),
                    $(_0x22a3cb(0x190))["attr"](
                      "data-spawncoordz",
                      _0x4f400f[_0x22a3cb(0x17f)]["z"]
                    ),
                    $(".box-5")[_0x22a3cb(0x165)](
                      _0x22a3cb(0x17d),
                      _0x4728c3 + 0x2
                    ))
                  : ($(".box-5")[_0x22a3cb(0x17c)](_0x22a3cb(0x1db)),
                    $(_0x22a3cb(0x1c4))[_0x22a3cb(0x152)](""),
                    $(_0x22a3cb(0x1e6))[_0x22a3cb(0x152)](""),
                    $(".box-5\x20.box-img\x20img")[_0x22a3cb(0x165)]("src", ""),
                    $(_0x22a3cb(0x190))["attr"](_0x22a3cb(0x282), ""),
                    $(".box-5")[_0x22a3cb(0x165)](_0x22a3cb(0x225), ""),
                    $(_0x22a3cb(0x190))["attr"](_0x22a3cb(0x1ff), ""),
                    $(_0x22a3cb(0x190))[_0x22a3cb(0x165)](_0x22a3cb(0x219), ""),
                    $(_0x22a3cb(0x190))[_0x22a3cb(0x165)](_0x22a3cb(0x23a), ""),
                    $(_0x22a3cb(0x190))["attr"](_0x22a3cb(0x1ad), ""),
                    $(".box-5")[_0x22a3cb(0x165)]("data-id", ""));
            } else apiPost(_0x22a3cb(0x168), { camcoords: { x: $(this)[_0x22a3cb(0x165)](_0x22a3cb(0x282)), y: $(this)[_0x22a3cb(0x165)](_0x22a3cb(0x225)), z: $(this)["attr"](_0x22a3cb(0x1ff)) }, spawncoords: { x: $(this)[_0x22a3cb(0x165)](_0x22a3cb(0x219)), y: $(this)[_0x22a3cb(0x165)](_0x22a3cb(0x23a)), z: $(this)[_0x22a3cb(0x165)](_0x22a3cb(0x1ad)) } });
          }),
            $(_0x43c47d(0x244))["fadeIn"](0xc8);
          break;
        case _0x43c47d(0x22b):
          $(_0x43c47d(0x1f0))["addClass"]("hidden"),
            $(_0x43c47d(0x1f0))[_0x43c47d(0x166)](),
            $(_0x43c47d(0x1ae))[_0x43c47d(0x17c)](_0x43c47d(0x265));
          break;
        case _0x43c47d(0x26c):
          $(_0x43c47d(0x244))["fadeOut"](0xc8),
            setTimeout(() => {
              var _0x3e706f = _0x43c47d;
              $(_0x3e706f(0x1f2))[_0x3e706f(0x148)](_0x3e706f(0x1db)),
                $(_0x3e706f(0x1f2))[_0x3e706f(0x165)](_0x3e706f(0x282), ""),
                $(_0x3e706f(0x1f2))[_0x3e706f(0x165)](_0x3e706f(0x225), ""),
                $(_0x3e706f(0x1f2))[_0x3e706f(0x165)](_0x3e706f(0x1ff), ""),
                $(_0x3e706f(0x1f2))[_0x3e706f(0x165)](_0x3e706f(0x219), ""),
                $(_0x3e706f(0x1f2))["attr"](_0x3e706f(0x23a), ""),
                $(_0x3e706f(0x1f2))[_0x3e706f(0x165)](_0x3e706f(0x1ad), ""),
                $(".box")["attr"]("data-id", ""),
                $(_0x3e706f(0x208))[_0x3e706f(0x152)](""),
                $(".box\x20.box-title")[_0x3e706f(0x152)](""),
                $(_0x3e706f(0x238))[_0x3e706f(0x165)](_0x3e706f(0x23d), "");
            }, 0xc8);
          break;
        case _0x43c47d(0x146):
          var _0x5a8c36 = _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x233)];
          if (typeof _0x5a8c36 === _0x43c47d(0x177))
            _0x5a8c36 = JSON[_0x43c47d(0x22c)](_0x5a8c36);
          for (let _0x141558 in _0x5a8c36) {
            _0x1378dc[_0x141558] &&
              ((_0x1378dc[_0x141558][_0x43c47d(0x24a)] =
                _0x5a8c36[_0x141558][_0x43c47d(0x215)]),
              $("#" + _0x141558 + _0x43c47d(0x1ac))[_0x43c47d(0x258)](
                _0x1378dc[_0x141558][_0x43c47d(0x24a)]
              ),
              $("#" + _0x141558)[_0x43c47d(0x288)](
                _0x43c47d(0x24a),
                _0x1378dc[_0x141558]["value"]
              ),
              _0xbe709e[_0x43c47d(0x149)]((_0x5746b1) => {
                var _0x46e2b1 = _0x43c47d;
                const _0x11bc0f =
                  _0x5746b1[_0x46e2b1(0x16a)] === _0x46e2b1(0x20d)
                    ? "eye_color"
                    : _0x5746b1[_0x46e2b1(0x16a)];
                _0x11bc0f === _0x141558 &&
                  (_0x5746b1[_0x46e2b1(0x223)]({
                    currentTarget: {
                      id:
                        _0x5746b1["name"] +
                        "-" +
                        _0x1378dc[_0x141558][_0x46e2b1(0x24a)],
                    },
                  }),
                  $("." + _0x11bc0f + _0x46e2b1(0x202))[_0x46e2b1(0x148)](
                    _0x46e2b1(0x226)
                  ),
                  $(
                    "#" +
                      _0x11bc0f +
                      _0x46e2b1(0x1c7) +
                      _0x5a8c36[_0x141558][_0x46e2b1(0x285)]
                  )[_0x46e2b1(0x17c)]("colorSelected"));
              }),
              _0x5a8c36[_0x141558][_0x43c47d(0x285)] &&
                ((_0x1378dc[_0x141558]["hasTexture"][
                  _0x1378dc[_0x141558][_0x43c47d(0x24a)]
                ] = { value: 0x0, max: 0x0 }),
                (_0x1378dc[_0x141558][_0x43c47d(0x24b)][
                  _0x1378dc[_0x141558][_0x43c47d(0x24a)]
                ][_0x43c47d(0x24a)] = _0x5a8c36[_0x141558]["texture"]),
                $("#" + _0x141558 + _0x43c47d(0x271))[_0x43c47d(0x258)](
                  _0x5a8c36[_0x141558]["texture"]
                ),
                $("#" + _0x141558 + _0x43c47d(0x1d1))[_0x43c47d(0x288)](
                  "value",
                  _0x5a8c36[_0x141558]["texture"]
                )));
          }
          break;
        case _0x43c47d(0x283):
          maxValues = _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x203)];
          for (let _0xa25cfa in maxValues) {
            if (_0x1378dc[_0xa25cfa]) {
              (_0x1378dc[_0xa25cfa][_0x43c47d(0x232)] =
                maxValues[_0xa25cfa][_0x43c47d(0x215)]),
                $("#" + _0xa25cfa + _0x43c47d(0x1ac))[_0x43c47d(0x258)](
                  _0x1378dc[_0xa25cfa][_0x43c47d(0x24a)]
                    ? _0x1378dc[_0xa25cfa]["value"]
                    : "0"
                ),
                $("#" + _0xa25cfa + _0x43c47d(0x23b))[_0x43c47d(0x16e)](
                  "/" + maxValues[_0xa25cfa][_0x43c47d(0x215)]
                );
              let _0x5aca14 = _0xa25cfa;
              $("#" + _0x5aca14)[_0x43c47d(0x288)]({
                range: _0x43c47d(0x201),
                min: _0x1378dc[_0x5aca14][_0x43c47d(0x201)]
                  ? _0x1378dc[_0x5aca14][_0x43c47d(0x201)]
                  : 0x0,
                max: _0x1378dc[_0x5aca14][_0x43c47d(0x232)],
                value: _0x1378dc[_0x5aca14][_0x43c47d(0x24a)],
                slide: function (_0x4458f9, _0x408a48) {
                  var _0x9db40d = _0x43c47d,
                    _0x500d20 = _0x408a48[_0x9db40d(0x24a)];
                  (_0x1378dc[_0x5aca14][_0x9db40d(0x24a)] = _0x500d20),
                    $("#" + _0x5aca14 + _0x9db40d(0x1ac))[_0x9db40d(0x258)](
                      _0x1378dc[_0x5aca14]["value"]
                    ),
                    apiPost(_0x9db40d(0x1cc), {
                      clothingType: _0x5aca14,
                      articleNumber: _0x1378dc[_0x5aca14][_0x9db40d(0x24a)],
                      type: _0x9db40d(0x215),
                    });
                },
              }),
                $("#" + _0x5aca14 + _0x43c47d(0x1ac))["on"](
                  _0x43c47d(0x175),
                  function (_0x516d19) {
                    var _0xbc735b = _0x43c47d,
                      _0x5406c9 = parseInt($(this)[_0xbc735b(0x258)]());
                    _0x5406c9 > _0x1378dc[_0x5aca14]["max"] &&
                      (_0x5406c9 = _0x1378dc[_0x5aca14][_0xbc735b(0x232)]),
                      _0x5406c9 < _0x1378dc[_0x5aca14]["min"] &&
                        (_0x5406c9 = _0x1378dc[_0x5aca14][_0xbc735b(0x201)]),
                      (_0x1378dc[_0x5aca14]["value"] = _0x5406c9),
                      $("#" + _0x5aca14 + _0xbc735b(0x1ac))[_0xbc735b(0x258)](
                        _0x1378dc[_0x5aca14]["value"]
                      ),
                      apiPost("updateSkin", {
                        clothingType: _0x5aca14,
                        articleNumber: _0x1378dc[_0x5aca14][_0xbc735b(0x24a)],
                        type: _0xbc735b(0x215),
                      });
                  }
                ),
                _0x1378dc[_0xa25cfa][_0x43c47d(0x24b)] !== ![] &&
                  (_0x1378dc[_0x5aca14]["hasTexture"][
                    _0x1378dc[_0x5aca14][_0x43c47d(0x24a)]
                  ] == undefined
                    ? (_0x1378dc[_0x5aca14][_0x43c47d(0x24b)][
                        _0x1378dc[_0x5aca14][_0x43c47d(0x24a)]
                      ] = {
                        value: 0x0,
                        max: maxValues[_0xa25cfa][_0x43c47d(0x285)],
                      })
                    : (_0x1378dc[_0x5aca14][_0x43c47d(0x24b)][
                        _0x1378dc[_0x5aca14][_0x43c47d(0x24a)]
                      ] = {
                        value:
                          _0x1378dc[_0x5aca14][_0x43c47d(0x24b)][
                            _0x1378dc[_0x5aca14]["value"]
                          ][_0x43c47d(0x24a)],
                        max: maxValues[_0x5aca14][_0x43c47d(0x285)],
                      }),
                  $("#" + _0x5aca14 + "TextureValue")[_0x43c47d(0x258)](
                    _0x1378dc[_0x5aca14]["hasTexture"][
                      _0x1378dc[_0x5aca14][_0x43c47d(0x24a)]
                    ][_0x43c47d(0x24a)]
                  ),
                  $("#" + _0x5aca14 + _0x43c47d(0x210))["html"](
                    "/" +
                      _0x1378dc[_0x5aca14][_0x43c47d(0x24b)][
                        _0x1378dc[_0x5aca14][_0x43c47d(0x24a)]
                      ][_0x43c47d(0x232)]
                  ),
                  $("#" + _0x5aca14 + _0x43c47d(0x1d1))[_0x43c47d(0x288)]({
                    range: _0x43c47d(0x201),
                    min: 0x0,
                    max: _0x1378dc[_0x5aca14][_0x43c47d(0x24b)][
                      _0x1378dc[_0x5aca14][_0x43c47d(0x24a)]
                    ][_0x43c47d(0x232)],
                    value:
                      _0x1378dc[_0x5aca14][_0x43c47d(0x24b)][
                        _0x1378dc[_0x5aca14][_0x43c47d(0x24a)]
                      ][_0x43c47d(0x24a)],
                    slide: function (_0xc2d0c7, _0x1765d5) {
                      var _0x5c4da7 = _0x43c47d,
                        _0x4dc6cb = _0x1765d5[_0x5c4da7(0x24a)];
                      (_0x1378dc[_0x5aca14]["hasTexture"][
                        _0x1378dc[_0x5aca14][_0x5c4da7(0x24a)]
                      ]["value"] = _0x4dc6cb),
                        $("#" + _0x5aca14 + _0x5c4da7(0x271))[_0x5c4da7(0x258)](
                          _0x1378dc[_0x5aca14][_0x5c4da7(0x24b)][
                            _0x1378dc[_0x5aca14][_0x5c4da7(0x24a)]
                          ][_0x5c4da7(0x24a)]
                        ),
                        apiPost(_0x5c4da7(0x1cc), {
                          clothingType: _0x5aca14,
                          articleNumber:
                            _0x1378dc[_0x5aca14]["hasTexture"][
                              _0x1378dc[_0x5aca14][_0x5c4da7(0x24a)]
                            ]["value"],
                          type: _0x5c4da7(0x285),
                        });
                    },
                  }),
                  $("#" + _0x5aca14 + "TextureValue")["on"](
                    _0x43c47d(0x175),
                    function (_0x10ce8d) {
                      var _0x25c450 = _0x43c47d,
                        _0x4bad06 = parseInt($(this)[_0x25c450(0x258)]());
                      _0x4bad06 >
                        _0x1378dc[_0x5aca14][_0x25c450(0x24b)][
                          _0x1378dc[_0x5aca14][_0x25c450(0x24a)]
                        ][_0x25c450(0x232)] &&
                        (_0x4bad06 =
                          _0x1378dc[_0x5aca14][_0x25c450(0x24b)][
                            _0x1378dc[_0x5aca14][_0x25c450(0x24a)]
                          ]["max"]),
                        _0x4bad06 < 0x0 && (_0x4bad06 = 0x0),
                        (_0x1378dc[_0x5aca14]["hasTexture"][
                          _0x1378dc[_0x5aca14][_0x25c450(0x24a)]
                        ]["value"] = _0x4bad06),
                        $("#" + _0x5aca14 + "TextureValue")[_0x25c450(0x258)](
                          _0x1378dc[_0x5aca14][_0x25c450(0x24b)][
                            _0x1378dc[_0x5aca14][_0x25c450(0x24a)]
                          ][_0x25c450(0x24a)]
                        ),
                        apiPost(_0x25c450(0x1cc), {
                          clothingType: _0x5aca14,
                          articleNumber:
                            _0x1378dc[_0x5aca14][_0x25c450(0x24b)][
                              _0x1378dc[_0x5aca14]["value"]
                            ][_0x25c450(0x24a)],
                          type: _0x25c450(0x285),
                        });
                    }
                  )),
                _0x1378dc[_0xa25cfa][_0x43c47d(0x1de)] &&
                  (_0x1378dc[_0x5aca14][_0x43c47d(0x1de)] == undefined
                    ? (_0x1378dc[_0x5aca14][_0x43c47d(0x1de)] = 0xa)
                    : (_0x1378dc[_0x5aca14][_0x43c47d(0x1de)] = 0xa),
                  $("#" + _0x5aca14 + _0x43c47d(0x1dd))[_0x43c47d(0x258)](
                    _0x1378dc[_0x5aca14][_0x43c47d(0x1de)]
                  ),
                  $("#" + _0x5aca14 + _0x43c47d(0x260))["html"](
                    _0x43c47d(0x186)
                  ),
                  $("#" + _0x5aca14 + _0x43c47d(0x1ed))[_0x43c47d(0x288)]({
                    range: "min",
                    min: 0x0,
                    max: 0xa,
                    value: _0x1378dc[_0x5aca14][_0x43c47d(0x1de)],
                    slide: function (_0x163ab5, _0x144a36) {
                      var _0x19cfb0 = _0x43c47d,
                        _0x363ff1 = _0x144a36["value"];
                      (_0x1378dc[_0x5aca14][_0x19cfb0(0x1de)] = _0x363ff1),
                        $("#" + _0x5aca14 + _0x19cfb0(0x1dd))["val"](
                          _0x1378dc[_0x5aca14][_0x19cfb0(0x1de)]
                        ),
                        apiPost(_0x19cfb0(0x1cc), {
                          clothingType: _0x5aca14,
                          articleNumber: _0x1378dc[_0x5aca14][_0x19cfb0(0x1de)],
                          type: _0x19cfb0(0x1de),
                        });
                    },
                  }),
                  $("#" + _0x5aca14 + "OpacityValue")["on"](
                    _0x43c47d(0x175),
                    function (_0x26c06b) {
                      var _0x1b0838 = _0x43c47d,
                        _0x31bada = parseInt($(this)["val"]());
                      _0x31bada > 0xa && (_0x31bada = 0xa),
                        _0x31bada < 0x0 && (_0x31bada = 0x0),
                        (_0x1378dc[_0x5aca14][_0x1b0838(0x1de)] = _0x31bada),
                        $("#" + _0x5aca14 + _0x1b0838(0x1dd))[_0x1b0838(0x258)](
                          _0x1378dc[_0x5aca14][_0x1b0838(0x1de)]
                        ),
                        apiPost(_0x1b0838(0x1cc), {
                          clothingType: _0x5aca14,
                          articleNumber: _0x1378dc[_0x5aca14][_0x1b0838(0x1de)],
                          type: "opacity",
                        });
                    }
                  ));
            }
          }
          break;
        case _0x43c47d(0x24d):
          maxValues = _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x203)];
          let _0x5cf1af = _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x1e5)];
          for (var _0x675702 in maxValues) {
            if (_0x675702 == _0x5cf1af) {
              if (_0x1378dc[_0x675702]) {
                (_0x1378dc[_0x675702]["max"] =
                  maxValues[_0x675702][_0x43c47d(0x215)]),
                  $("#" + _0x675702 + _0x43c47d(0x1ac))["val"](
                    _0x1378dc[_0x675702][_0x43c47d(0x24a)]
                      ? _0x1378dc[_0x675702]["value"]
                      : "0"
                  ),
                  $("#" + _0x675702 + _0x43c47d(0x23b))[_0x43c47d(0x16e)](
                    "/" + maxValues[_0x675702][_0x43c47d(0x215)]
                  );
                let _0x15c19b = _0x675702;
                $("#" + _0x15c19b)["slider"]({
                  range: "min",
                  min: _0x1378dc[_0x15c19b]["min"]
                    ? _0x1378dc[_0x15c19b][_0x43c47d(0x201)]
                    : 0x0,
                  max: _0x1378dc[_0x15c19b]["max"],
                  value: _0x1378dc[_0x15c19b][_0x43c47d(0x24a)],
                  slide: function (_0x49afa5, _0x2a969c) {
                    var _0x1e80be = _0x43c47d,
                      _0x109d04 = _0x2a969c["value"];
                    (_0x1378dc[_0x15c19b]["value"] = _0x109d04),
                      $("#" + _0x15c19b + _0x1e80be(0x1ac))[_0x1e80be(0x258)](
                        _0x1378dc[_0x15c19b][_0x1e80be(0x24a)]
                      ),
                      apiPost(_0x1e80be(0x1cc), {
                        clothingType: _0x15c19b,
                        articleNumber: _0x1378dc[_0x15c19b][_0x1e80be(0x24a)],
                        type: "item",
                      });
                  },
                }),
                  _0x1378dc[_0x15c19b]["hasTexture"] !== ![] &&
                    ((_0x1378dc[_0x15c19b][_0x43c47d(0x24b)][
                      _0x1378dc[_0x15c19b][_0x43c47d(0x24a)]
                    ] = {
                      value: 0x0,
                      max: maxValues[_0x15c19b][_0x43c47d(0x285)],
                    }),
                    $("#" + _0x15c19b + "TextureValue")[_0x43c47d(0x258)](
                      _0x1378dc[_0x15c19b][_0x43c47d(0x24b)][
                        _0x1378dc[_0x15c19b][_0x43c47d(0x24a)]
                      ]["value"]
                    ),
                    $("#" + _0x15c19b + _0x43c47d(0x210))[_0x43c47d(0x16e)](
                      "/" +
                        _0x1378dc[_0x15c19b]["hasTexture"][
                          _0x1378dc[_0x15c19b][_0x43c47d(0x24a)]
                        ][_0x43c47d(0x232)]
                    ),
                    $("#" + _0x15c19b + "Texture")[_0x43c47d(0x288)]({
                      range: _0x43c47d(0x201),
                      min: 0x0,
                      max: _0x1378dc[_0x15c19b][_0x43c47d(0x24b)][
                        _0x1378dc[_0x15c19b]["value"]
                      ]["max"],
                      value:
                        _0x1378dc[_0x15c19b][_0x43c47d(0x24b)][
                          _0x1378dc[_0x15c19b][_0x43c47d(0x24a)]
                        ][_0x43c47d(0x24a)],
                      slide: function (_0x1a117f, _0x21c91b) {
                        var _0x25d605 = _0x43c47d,
                          _0x3442de = _0x21c91b["value"];
                        (_0x1378dc[_0x15c19b][_0x25d605(0x24b)][
                          _0x1378dc[_0x15c19b][_0x25d605(0x24a)]
                        ]["value"] = _0x3442de),
                          $("#" + _0x15c19b + _0x25d605(0x271))[
                            _0x25d605(0x258)
                          ](
                            _0x1378dc[_0x15c19b][_0x25d605(0x24b)][
                              _0x1378dc[_0x15c19b]["value"]
                            ]["value"]
                          ),
                          apiPost(_0x25d605(0x1cc), {
                            clothingType: _0x15c19b,
                            articleNumber:
                              _0x1378dc[_0x15c19b]["hasTexture"][
                                _0x1378dc[_0x15c19b]["value"]
                              ]["value"],
                            type: _0x25d605(0x285),
                          });
                      },
                    }));
              }
            }
          }
          break;
        case _0x43c47d(0x239):
          $(_0x43c47d(0x267))["removeClass"](_0x43c47d(0x265)),
            $(_0x43c47d(0x267))[_0x43c47d(0x18d)](),
            loadChars(
              _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x1ba)],
              _0x53495a[_0x43c47d(0x191)]["maxValues"],
              _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x247)],
              _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x20e)]
            ),
            $(_0x43c47d(0x197))[_0x43c47d(0x19b)](_0x43c47d(0x15e)),
            $(_0x43c47d(0x197))["on"](_0x43c47d(0x15e), function () {
              var _0xa8a863 = _0x43c47d;
              $(_0xa8a863(0x1bb))[_0xa8a863(0x148)](_0xa8a863(0x236)),
                $(_0xa8a863(0x197))["removeClass"]("opacity-100"),
                $(_0xa8a863(0x1bb))["addClass"](_0xa8a863(0x21d)),
                $(".createCharacterBtn")[_0xa8a863(0x17c)](_0xa8a863(0x21d)),
                $(this)["removeClass"](_0xa8a863(0x21d)),
                $(this)[_0xa8a863(0x17c)](_0xa8a863(0x236)),
                openCreateMenu();
            }),
            $(_0x43c47d(0x1bb))[_0x43c47d(0x19b)](_0x43c47d(0x15e)),
            $(_0x43c47d(0x1bb))["on"](_0x43c47d(0x15e), function () {
              var _0x4dd887 = _0x43c47d,
                _0x4ff997 = $(this)[_0x4dd887(0x165)](_0x4dd887(0x155));
              $(_0x4dd887(0x1bb))["removeClass"](_0x4dd887(0x21d)),
                $(_0x4dd887(0x1bb))[_0x4dd887(0x148)](_0x4dd887(0x236)),
                $(_0x4dd887(0x1bb))[_0x4dd887(0x17c)](_0x4dd887(0x21d)),
                $(this)[_0x4dd887(0x148)](_0x4dd887(0x21d)),
                $(this)[_0x4dd887(0x17c)](_0x4dd887(0x236)),
                openSelectMenu(_0x4ff997);
            }),
            $(".charUnlockItem")["off"](_0x43c47d(0x15e)),
            $(_0x43c47d(0x1be))["on"](_0x43c47d(0x15e), function () {
              openKeycodeMenu();
            });
          _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x1bd)] &&
            $(_0x43c47d(0x196))["text"](
              _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x1bd)]
            );
          _0x53495a[_0x43c47d(0x191)]["serverDescription"] &&
            $(_0x43c47d(0x1fb))["text"](
              _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x252)]
            );
          _0x53495a[_0x43c47d(0x191)]["serverLogo"] &&
            $(_0x43c47d(0x206))[_0x43c47d(0x165)](
              _0x43c47d(0x23d),
              _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x1cf)]
            );
          _0x53495a[_0x43c47d(0x191)]["tebexStore"] &&
            ($(_0x43c47d(0x18a))[_0x43c47d(0x19b)]("click"),
            $(_0x43c47d(0x18a))["on"]("click", function () {
              var _0x124803 = _0x43c47d;
              window[_0x124803(0x1d6)](
                _0x124803(0x237),
                _0x53495a[_0x124803(0x191)][_0x124803(0x18e)]
              );
            }));
          _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x19d)] != null
            ? $(
                _0x43c47d(0x26a) +
                  _0x53495a[_0x43c47d(0x191)][_0x43c47d(0x19d)] +
                  "\x22]"
              )[_0x43c47d(0x286)]("click")
            : $(_0x43c47d(0x1bb))
                [_0x43c47d(0x22d)]()
                [_0x43c47d(0x286)](_0x43c47d(0x15e));
          break;
        case _0x43c47d(0x1e0):
          $(".multichar")["addClass"](_0x43c47d(0x265)),
            $(".multichar")[_0x43c47d(0x166)]();
          break;
      }
    }),
    $("#redeemBtn")["on"](_0x1395c2(0x15e), function () {
      var _0x23b527 = _0x1395c2,
        _0x271704 = $(_0x23b527(0x257))["val"]();
      apiPost(_0x23b527(0x20f), { keycode: _0x271704 }, function (_0x568a28) {
        var _0x367cbf = _0x23b527;
        _0x568a28 == ![] ? errorNotify(_0x367cbf(0x1a0)) : closeKeycodeMenu();
      });
    }),
    $(_0x1395c2(0x19c))["on"](_0x1395c2(0x15e), function () {
      closeKeycodeMenu();
    }),
    $(_0x1395c2(0x1b9))["slider"]({
      range: _0x1395c2(0x201),
      min: 0x0,
      max: 0x64,
      value: 0x32,
      slide: function (_0x4bc0ba, _0x458078) {},
    }),
    $(_0x1395c2(0x1ea))["click"](function () {
      var _0x5ac93c = _0x1395c2;
      $(_0x5ac93c(0x25a))[_0x5ac93c(0x1cb)](0x64);
      var _0x58db73 = $(this)[_0x5ac93c(0x165)](_0x5ac93c(0x26b));
      actualCategory = _0x58db73;
      var _0x3d3391 = $(this)[_0x5ac93c(0x165)]("data-cam");
      _0x13d359(_0x3d3391),
        setTimeout(function () {
          var _0xb0c788 = _0x5ac93c;
          $("#" + _0x58db73 + _0xb0c788(0x154))[_0xb0c788(0x1da)](0x64),
            $("#" + _0x58db73 + "Category")[_0xb0c788(0x272)](
              _0xb0c788(0x26d),
              _0xb0c788(0x218)
            );
        }, 0x64),
        $(_0x5ac93c(0x1ea))[_0x5ac93c(0x148)](_0x5ac93c(0x174)),
        $(_0x5ac93c(0x1ea))[_0x5ac93c(0x17c)](_0x5ac93c(0x21d)),
        $(_0x5ac93c(0x1ea))[_0x5ac93c(0x148)](_0x5ac93c(0x212)),
        $(".category-btn")[_0x5ac93c(0x17c)](_0x5ac93c(0x234)),
        $(this)["addClass"](_0x5ac93c(0x174)),
        $(this)[_0x5ac93c(0x148)](_0x5ac93c(0x21d)),
        $(".my-4")[_0x5ac93c(0x148)](_0x5ac93c(0x19a)),
        $(this)["addClass"](_0x5ac93c(0x19a)),
        $(this)[_0x5ac93c(0x17c)](_0x5ac93c(0x212));
      var _0x2c52fc = $(this)["index"]() - 0x2;
      _0x2c52fc == 0x1
        ? ($(_0x5ac93c(0x1ee))["css"](_0x5ac93c(0x192), _0x5ac93c(0x167)),
          $("#ustGradient")[_0x5ac93c(0x272)](
            _0x5ac93c(0x26d),
            _0x5ac93c(0x1fc)
          ),
          $("#altGradient")[_0x5ac93c(0x272)](
            _0x5ac93c(0x192),
            _0x5ac93c(0x1d5)
          ),
          $(_0x5ac93c(0x251))[_0x5ac93c(0x272)](
            _0x5ac93c(0x22f),
            _0x2c52fc * 0xc8 - 0xc8 + "px"
          ))
        : $("#ustGradient")["css"](_0x5ac93c(0x26d), _0x5ac93c(0x20c));
      $(_0x5ac93c(0x27d))["css"](_0x5ac93c(0x26d), _0x5ac93c(0x20c));
      var _0x2e214d = 0x5 - _0x2c52fc,
        _0x18c979 = 0x5 - _0x2e214d - 0x1,
        _0x3da5aa = _0x18c979 * 0xc8;
      $(_0x5ac93c(0x1ee))[_0x5ac93c(0x272)](_0x5ac93c(0x192), _0x3da5aa - 0x5),
        $(_0x5ac93c(0x251))[_0x5ac93c(0x272)](
          "top",
          _0x2c52fc * 0xc8 - 0xc8 + 0x1b + 0x1b + "px"
        ),
        $(_0x5ac93c(0x27d))["css"](
          _0x5ac93c(0x192),
          _0x2e214d * 0xc8 + 0xf + "px"
        ),
        $(_0x5ac93c(0x251))["css"](
          _0x5ac93c(0x22f),
          _0x2c52fc * 0xc8 - 0xc8 + "px"
        ),
        _0x2c52fc == 0x5 &&
          $(_0x5ac93c(0x27d))[_0x5ac93c(0x272)](
            _0x5ac93c(0x26d),
            _0x5ac93c(0x1fc)
          ),
        $(_0x5ac93c(0x251))[_0x5ac93c(0x17c)](_0x5ac93c(0x19a)),
        (currentIndex = _0x2c52fc);
    });
  function _0x5cf5df(_0x57b8fc) {
    apiPost("setGender", { gender: _0x57b8fc }), _0xee5b2();
  }
  $("#maleBtn")[_0x1395c2(0x15e)](function () {
    var _0x37cf68 = _0x1395c2;
    $(_0x37cf68(0x21e))[_0x37cf68(0x17c)](_0x37cf68(0x170)),
      $(_0x37cf68(0x1b2))["removeClass"](_0x37cf68(0x213)),
      (_0x8c7945 = _0x37cf68(0x246)),
      _0xbe709e[_0x37cf68(0x149)]((_0x2a0c36) => {
        var _0x427795 = _0x37cf68;
        _0x2a0c36[_0x427795(0x1ef)](_0x8c7945);
      }),
      _0x5cf5df(0x0);
  }),
    $("#femaleBtn")[_0x1395c2(0x15e)](function () {
      var _0x231e6a = _0x1395c2;
      $(_0x231e6a(0x1b2))[_0x231e6a(0x17c)](_0x231e6a(0x213)),
        $(_0x231e6a(0x21e))[_0x231e6a(0x148)](_0x231e6a(0x170)),
        (_0x8c7945 = _0x231e6a(0x1a3)),
        _0xbe709e[_0x231e6a(0x149)]((_0x1483ff) => {
          _0x1483ff["setSex"](_0x8c7945);
        }),
        _0x5cf5df(0x1);
    }),
    $(document)["on"]("click", "#last-loc", function () {
      var _0x4dc68c = _0x1395c2;
      apiPost(_0x4dc68c(0x168), { camcoords: {}, spawncoords: {} });
    });
  var _0x4c8d55 = _0x1395c2(0x15a),
    _0x5d24b7 = "";
  for (var _0x51b71f = 0x0; _0x51b71f < 0x2e; _0x51b71f++) {
    var _0x304f08 = "";
    _0x51b71f == _0x5930dc && (_0x304f08 = _0x1395c2(0x14d)),
      (_0x5d24b7 +=
        _0x1395c2(0x195) +
        _0x304f08 +
        _0x1395c2(0x1f3) +
        _0x51b71f +
        ".png\x22\x20alt=\x22\x22>\x0a\x20\x20\x20\x20\x20\x20</div>\x0a\x20\x20\x20\x20\x20\x20");
  }
  $(_0x1395c2(0x19f))[_0x1395c2(0x16e)](_0x5d24b7),
    $(_0x1395c2(0x289))[_0x1395c2(0x15e)](function () {
      var _0x4e8444 = _0x1395c2;
      $(_0x4e8444(0x289))[_0x4e8444(0x17c)](_0x4e8444(0x261)),
        $(_0x4e8444(0x269))[_0x4e8444(0x148)](_0x4e8444(0x25f)),
        (_0x4c8d55 = "dads");
      var _0x4f2baf = "";
      for (var _0x316cc9 = 0x0; _0x316cc9 < 0x2e; _0x316cc9++) {
        var _0xe130d8 = "";
        _0x316cc9 == _0x5930dc && (_0xe130d8 = _0x4e8444(0x14d)),
          (_0x4f2baf +=
            _0x4e8444(0x14f) +
            _0xe130d8 +
            _0x4e8444(0x188) +
            _0x316cc9 +
            _0x4e8444(0x268));
      }
      $("#parentsDiv")[_0x4e8444(0x16e)](_0x4f2baf),
        $(".parentItem")[_0x4e8444(0x19b)]("click"),
        $(".parentItem")[_0x4e8444(0x15e)](function () {
          var _0x410c5f = _0x4e8444;
          $(_0x410c5f(0x28c))[_0x410c5f(0x148)]("parentItemActive"),
            $(this)[_0x410c5f(0x17c)](_0x410c5f(0x14d)),
            _0x4c8d55 == "dads" &&
              ((_0x5930dc = $(this)[_0x410c5f(0x231)]()),
              apiPost(_0x410c5f(0x1cc), {
                clothingType: _0x410c5f(0x183),
                articleNumber: _0x5930dc,
                type: _0x410c5f(0x215),
              }),
              apiPost(_0x410c5f(0x1cc), {
                clothingType: _0x410c5f(0x183),
                articleNumber: 0xf,
                type: _0x410c5f(0x285),
              }));
        });
    }),
    $(_0x1395c2(0x269))[_0x1395c2(0x15e)](function () {
      var _0xac15ad = _0x1395c2;
      $(_0xac15ad(0x269))[_0xac15ad(0x17c)](_0xac15ad(0x25f)),
        $("#dadsBtn")["removeClass"]("parentBtnLeftActive"),
        (_0x4c8d55 = _0xac15ad(0x187));
      var _0x20c11f = "";
      const _0x118419 = [];
      for (var _0x105019 = 0x0; _0x105019 < 0x2e; _0x105019++) {
        var _0x4d6a2a = "";
        let _0x27d7ba =
          _0xac15ad(0x20a) +
          _0x105019 +
          _0xac15ad(0x178) +
          (_0x105019 > 0x14 && _0x105019 < 0x2a
            ? _0xac15ad(0x1a3)
            : _0xac15ad(0x246)) +
          "\x22\x20class=\x22cursor-pointer\x20uppercase\x20parentItem\x20" +
          _0x4d6a2a +
          _0xac15ad(0x188) +
          _0x105019 +
          ".png\x22\x20alt=\x22\x22>\x0a\x20\x20\x20\x20\x20\x20\x20\x20</div>\x0a\x20\x20\x20\x20\x20\x20";
        (_0x20c11f += _0x27d7ba), _0x118419["push"](_0x27d7ba);
      }
      $("#parentsDiv")[_0xac15ad(0x16e)](""),
        _0x118419[_0xac15ad(0x1a7)]((_0x3f01fb, _0x9430c3) => {
          var _0x3d648a = _0xac15ad;
          if (_0x3f01fb[_0x3d648a(0x211)](_0x3d648a(0x1a1))) return -0x1;
          return 0x1;
        }),
        _0x118419[_0xac15ad(0x149)]((_0x463bd1) =>
          $(_0xac15ad(0x19f))[_0xac15ad(0x287)](_0x463bd1)
        ),
        _0x4f1b41
          ? $("#" + _0x4f1b41)[_0xac15ad(0x17c)](_0xac15ad(0x14d))
          : $("#mom-21")[_0xac15ad(0x17c)](_0xac15ad(0x14d)),
        $(_0xac15ad(0x28c))[_0xac15ad(0x19b)](_0xac15ad(0x15e)),
        $(_0xac15ad(0x28c))[_0xac15ad(0x15e)](function (_0x202636) {
          var _0x27b3eb = _0xac15ad;
          $(_0x27b3eb(0x28c))[_0x27b3eb(0x148)](_0x27b3eb(0x14d)),
            $(this)[_0x27b3eb(0x17c)](_0x27b3eb(0x14d)),
            _0x4c8d55 == _0x27b3eb(0x15a) &&
              ((_0x5930dc = $(this)[_0x27b3eb(0x231)]()),
              apiPost(_0x27b3eb(0x1cc), {
                clothingType: _0x27b3eb(0x183),
                articleNumber: _0x5930dc,
                type: _0x27b3eb(0x215),
              }),
              apiPost(_0x27b3eb(0x1cc), {
                clothingType: "face2",
                articleNumber: 0xf,
                type: _0x27b3eb(0x285),
              })),
            _0x4c8d55 == _0x27b3eb(0x187) &&
              ((_0x4f1b41 = _0x202636?.[_0x27b3eb(0x199)]["id"]),
              apiPost(_0x27b3eb(0x1cc), {
                clothingType: "face",
                articleNumber: _0x4f1b41[_0x27b3eb(0x205)]("-")[0x1],
                type: _0x27b3eb(0x215),
              }),
              apiPost(_0x27b3eb(0x1cc), {
                clothingType: _0x27b3eb(0x240),
                articleNumber: 0x15,
                type: "texture",
              }));
        });
    }),
    $(_0x1395c2(0x28c))[_0x1395c2(0x19b)]("click"),
    $(_0x1395c2(0x28c))["click"](function (_0x26d5b9) {
      var _0x35a5fd = _0x1395c2;
      $(_0x35a5fd(0x28c))["removeClass"](_0x35a5fd(0x14d)),
        $(this)[_0x35a5fd(0x17c)]("parentItemActive"),
        _0x4c8d55 == "dads" && (_0x5930dc = $(this)[_0x35a5fd(0x231)]()),
        _0x4c8d55 == _0x35a5fd(0x187) &&
          (_0x4f1b41 = _0x26d5b9?.[_0x35a5fd(0x199)]["id"]);
    }),
    $(_0x1395c2(0x1a9))["on"](_0x1395c2(0x169), function () {
      var _0x57a22c = _0x1395c2,
        _0x3e42fa = $(this)[_0x57a22c(0x288)]("option", _0x57a22c(0x24a));
      (_0xf7b62f = _0x3e42fa / 0x64),
        apiPost(_0x57a22c(0x1cc), {
          clothingType: _0x57a22c(0x242),
          articleNumber: _0xf7b62f,
          type: "skinMix",
        });
    }),
    $(_0x1395c2(0x27c))["on"](_0x1395c2(0x169), function () {
      var _0x544284 = _0x1395c2,
        _0x442ca6 = $(this)["slider"]("option", "value");
      (_0x2cb60f = _0x442ca6 / 0x64),
        apiPost(_0x544284(0x1cc), {
          clothingType: _0x544284(0x242),
          articleNumber: _0x2cb60f,
          type: "shapeMix",
        });
    }),
    $(_0x1395c2(0x185))[_0x1395c2(0x15e)](function () {
      var _0x1dab7a = _0x1395c2,
        _0x4447d9 = $(this)["attr"]("data-slider");
      (_0x1378dc[_0x4447d9]["value"] = _0x1378dc[_0x4447d9]["value"] - 0x1),
        _0x1378dc[_0x4447d9][_0x1dab7a(0x24a)] <
          _0x1378dc[_0x4447d9][_0x1dab7a(0x201)] &&
          (_0x1378dc[_0x4447d9][_0x1dab7a(0x24a)] =
            _0x1378dc[_0x4447d9]["min"]),
        $("#" + _0x4447d9 + _0x1dab7a(0x1ac))[_0x1dab7a(0x258)](
          _0x1378dc[_0x4447d9][_0x1dab7a(0x24a)]
        ),
        $("#" + _0x4447d9)[_0x1dab7a(0x288)](
          _0x1dab7a(0x24a),
          _0x1378dc[_0x4447d9][_0x1dab7a(0x24a)]
        ),
        apiPost(_0x1dab7a(0x1cc), {
          clothingType: _0x4447d9,
          articleNumber: _0x1378dc[_0x4447d9]["value"],
          type: _0x1dab7a(0x215),
        });
    }),
    $(_0x1395c2(0x1b1))[_0x1395c2(0x15e)](function () {
      var _0x6c8d94 = _0x1395c2,
        _0x5c5282 = $(this)[_0x6c8d94(0x165)](_0x6c8d94(0x171));
      (_0x1378dc[_0x5c5282][_0x6c8d94(0x24a)] =
        _0x1378dc[_0x5c5282][_0x6c8d94(0x24a)] + 0x1),
        _0x1378dc[_0x5c5282]["value"] >
          _0x1378dc[_0x5c5282][_0x6c8d94(0x232)] &&
          (_0x1378dc[_0x5c5282][_0x6c8d94(0x24a)] =
            _0x1378dc[_0x5c5282][_0x6c8d94(0x232)]),
        $("#" + _0x5c5282 + _0x6c8d94(0x1ac))["val"](
          _0x1378dc[_0x5c5282]["value"]
        ),
        $("#" + _0x5c5282)[_0x6c8d94(0x288)](
          _0x6c8d94(0x24a),
          _0x1378dc[_0x5c5282]["value"]
        ),
        apiPost(_0x6c8d94(0x1cc), {
          clothingType: _0x5c5282,
          articleNumber: _0x1378dc[_0x5c5282][_0x6c8d94(0x24a)],
          type: _0x6c8d94(0x215),
        });
    }),
    $(_0x1395c2(0x1b0))[_0x1395c2(0x15e)](function () {
      var _0x7b843c = _0x1395c2,
        _0x37f9e0 = $(this)[_0x7b843c(0x165)]("data-slider");
      (_0x1378dc[_0x37f9e0][_0x7b843c(0x24b)][
        _0x1378dc[_0x37f9e0][_0x7b843c(0x24a)]
      ][_0x7b843c(0x24a)] =
        _0x1378dc[_0x37f9e0]["hasTexture"][
          _0x1378dc[_0x37f9e0][_0x7b843c(0x24a)]
        ][_0x7b843c(0x24a)] - 0x1),
        _0x1378dc[_0x37f9e0]["hasTexture"][_0x1378dc[_0x37f9e0]["value"]][
          _0x7b843c(0x24a)
        ] < 0x0 &&
          (_0x1378dc[_0x37f9e0]["hasTexture"][
            _0x1378dc[_0x37f9e0][_0x7b843c(0x24a)]
          ]["value"] = 0x0),
        $("#" + _0x37f9e0 + _0x7b843c(0x271))["val"](
          _0x1378dc[_0x37f9e0][_0x7b843c(0x24b)][_0x1378dc[_0x37f9e0]["value"]][
            _0x7b843c(0x24a)
          ]
        ),
        $("#" + _0x37f9e0 + "Texture")[_0x7b843c(0x288)](
          _0x7b843c(0x24a),
          _0x1378dc[_0x37f9e0][_0x7b843c(0x24b)][
            _0x1378dc[_0x37f9e0][_0x7b843c(0x24a)]
          ][_0x7b843c(0x24a)]
        ),
        apiPost(_0x7b843c(0x1cc), {
          clothingType: _0x37f9e0,
          articleNumber:
            _0x1378dc[_0x37f9e0][_0x7b843c(0x24b)][
              _0x1378dc[_0x37f9e0][_0x7b843c(0x24a)]
            ][_0x7b843c(0x24a)],
          type: _0x7b843c(0x285),
        });
    }),
    $(_0x1395c2(0x229))[_0x1395c2(0x15e)](function () {
      var _0x3c7c52 = _0x1395c2,
        _0x2cd80f = $(this)["attr"](_0x3c7c52(0x171));
      _0x1378dc[_0x2cd80f][_0x3c7c52(0x24b)][
        _0x1378dc[_0x2cd80f][_0x3c7c52(0x24a)]
      ][_0x3c7c52(0x24a)] >=
      _0x1378dc[_0x2cd80f][_0x3c7c52(0x24b)][_0x1378dc[_0x2cd80f]["value"]][
        _0x3c7c52(0x232)
      ]
        ? (_0x1378dc[_0x2cd80f][_0x3c7c52(0x24b)][
            _0x1378dc[_0x2cd80f][_0x3c7c52(0x24a)]
          ][_0x3c7c52(0x24a)] =
            _0x1378dc[_0x2cd80f][_0x3c7c52(0x24b)][
              _0x1378dc[_0x2cd80f][_0x3c7c52(0x24a)]
            ]["max"])
        : (_0x1378dc[_0x2cd80f][_0x3c7c52(0x24b)][
            _0x1378dc[_0x2cd80f][_0x3c7c52(0x24a)]
          ][_0x3c7c52(0x24a)] =
            _0x1378dc[_0x2cd80f]["hasTexture"][
              _0x1378dc[_0x2cd80f][_0x3c7c52(0x24a)]
            ][_0x3c7c52(0x24a)] + 0x1),
        $("#" + _0x2cd80f + _0x3c7c52(0x271))[_0x3c7c52(0x258)](
          _0x1378dc[_0x2cd80f]["hasTexture"][_0x1378dc[_0x2cd80f]["value"]][
            _0x3c7c52(0x24a)
          ]
        ),
        $("#" + _0x2cd80f + _0x3c7c52(0x1d1))[_0x3c7c52(0x288)](
          _0x3c7c52(0x24a),
          _0x1378dc[_0x2cd80f]["hasTexture"][
            _0x1378dc[_0x2cd80f][_0x3c7c52(0x24a)]
          ]["value"]
        ),
        apiPost("updateSkin", {
          clothingType: _0x2cd80f,
          articleNumber:
            _0x1378dc[_0x2cd80f][_0x3c7c52(0x24b)][
              _0x1378dc[_0x2cd80f]["value"]
            ][_0x3c7c52(0x24a)],
          type: _0x3c7c52(0x285),
        });
    }),
    $(_0x1395c2(0x26e))[_0x1395c2(0x15e)](function () {
      var _0x3c93e9 = _0x1395c2,
        _0x58e441 = $(this)["attr"]("data-slider");
      (_0x1378dc[_0x58e441][_0x3c93e9(0x1de)] =
        _0x1378dc[_0x58e441]["opacity"] - 0x1),
        _0x1378dc[_0x58e441][_0x3c93e9(0x1de)] < 0x0 &&
          (_0x1378dc[_0x58e441][_0x3c93e9(0x1de)] = 0x0),
        $("#" + _0x58e441 + _0x3c93e9(0x1dd))[_0x3c93e9(0x258)](
          _0x1378dc[_0x58e441][_0x3c93e9(0x1de)]
        ),
        $("#" + _0x58e441 + _0x3c93e9(0x1ed))[_0x3c93e9(0x288)](
          _0x3c93e9(0x24a),
          _0x1378dc[_0x58e441]["opacity"]
        ),
        apiPost(_0x3c93e9(0x1cc), {
          clothingType: _0x58e441,
          articleNumber: _0x1378dc[_0x58e441][_0x3c93e9(0x1de)],
          type: _0x3c93e9(0x1de),
        });
    }),
    $(_0x1395c2(0x1af))[_0x1395c2(0x15e)](function () {
      var _0x54c264 = _0x1395c2,
        _0x42fda9 = $(this)["attr"](_0x54c264(0x171));
      (_0x1378dc[_0x42fda9][_0x54c264(0x1de)] =
        _0x1378dc[_0x42fda9][_0x54c264(0x1de)] + 0x1),
        _0x1378dc[_0x42fda9][_0x54c264(0x1de)] >= 0xa &&
          (_0x1378dc[_0x42fda9][_0x54c264(0x1de)] = 0xa),
        $("#" + _0x42fda9 + _0x54c264(0x1dd))[_0x54c264(0x258)](
          _0x1378dc[_0x42fda9][_0x54c264(0x1de)]
        ),
        $("#" + _0x42fda9 + _0x54c264(0x1ed))[_0x54c264(0x288)](
          _0x54c264(0x24a),
          _0x1378dc[_0x42fda9][_0x54c264(0x1de)]
        ),
        apiPost("updateSkin", {
          clothingType: _0x42fda9,
          articleNumber: _0x1378dc[_0x42fda9][_0x54c264(0x1de)],
          type: _0x54c264(0x1de),
        });
    });
});
