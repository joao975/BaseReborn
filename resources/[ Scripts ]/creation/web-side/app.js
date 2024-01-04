// const teste = {
//   open: () => {
//     $('body').show();
//     $('#form').fadeIn();
//   },
//   selectedSex: (sex) => {
//     let options = {
//       method: 'POST',
//       body: JSON.stringify({ sex: sex })
//     }
//     fetch('http://characters/createSimplePed', options) // Quando o sexo do personagem é selecionado
//   },
//   confirmForm: () => {
//     let inputsValues = $('.input-content input').val();
    
//     if (inputsValues == '') return;
//     if (!$('.sexOption').hasClass('active')) return;
//     if ($('#name').val() == "" || $('#lastname').val() == "" || $('#surname').val() == "") return;

//     let formResult = {
//       name: $('#name').val(),
//       name2: $('#lastname').val(),
//       surname: $('#surname').val(),
//       gender: $('.sexs .active').attr('data-id'),
//       where: $('.option-select .active').attr('data-id'),
//     }
//     userCreateCharacter = true
//     let options = {
//       method: 'POST',
//       body: JSON.stringify({ result: formResult })
//     }
    
//     fetch('http://characters/createCharacter', options).then(resp => resp.json().then(data => {
//       if (data.sucess)  {
//         $("body").hide();
//       }
//     }))
//   },
//   cancelForm: () => {
//     $('main').hide();
//     $('#play').show();
//     $('.input input').val('');
//     $(".sexOption").removeClass('active');
//     $(".whereOption").removeClass('active');
//     $("#whereText").html('Como nos achou?');
//     $('.characterItem:nth-child(1)').click();
//   }
// }

// function cancelForm(){
//   $('body').hide();
//   $('#play').show();
//   $('.input input').val('');
//   $(".sexOption").removeClass('active');
//   $(".whereOption").removeClass('active');
//   $("#whereText").html('Como nos achou?');
//   $('.characterItem:nth-child(1)').click();
// }



// const appspawn = new Vue({
//   el: '#app0',
//   data: {
//     spawn: false,
//     choice: null,
//   },
//   methods: {
//     OpenSpawnMode: function() {
//       $('body').show();
//       $('header').hide();
//       this.spawn = true
//     },
//     CloseSpawnMode: function() {
//       $('header').show();
//       this.spawn = false
//     },
//     spawnCharacter: function(choice) {
//       this.choice = choice

//       this.CloseSpawnMode();
//       $.post('http://creation/spawnCharacter', JSON.stringify({choice: choice}));
//     },
//   }
// });

const app0 = new Vue({
  el: '#app0',
  data: {
    CharacterMode0: false,
    age: null,
    gender: null,
    name: null,
    lastname: null,
    valorDecrement: 0,
    where: null,

  },
  methods: {
    OpenCharacterMode: function() {
      $('body').show();
      $('header').hide();
      this.CharacterMode0 = true
    },
    CloseCharacterMode: function() {
      $('header').show();
      this.CharacterMode0 = false
    },
    done: function() {
      /* if (this.name == null) {
        shake(nameshake);
        return
      };
      if (this.lastname == null) {
        shake(lastnameshake);
        return
      };
      if (this.age == null) {
        shake(ageshake);
        return
      }; */
      if (this.gender == null) {
        shake(shakeg);
        return
      };
      if (this.where == null) {
        shake(shakewhere);
        return
      };

      const arr = {
        name: this.name,
        lastname: this.lastname,
        gender: this.gender,
        age: this.age,
        where: this.where,
      };
      this.CloseCharacterMode();
      $.post('http://creation/cDone0', JSON.stringify(arr));
    },
    selectedSex: function(sex) {
      this.gender = sex;
      let options = {
        method: 'POST',
        body: JSON.stringify({ sex: sex })
      }
      fetch('http://creation/createSimplePed', options) // Quando o sexo do personagem é selecionado
    },
    selectedWhere: function(type) {
      this.where = type;// Quando o sexo do personagem é selecionado
    },

  }
});

$(document).on("click","#reset-cam",function(){
  $.post('http://creation/resetCam', JSON.stringify({}));
});

const app = new Vue({
  el: '#app',
  data: {
    CharacterMode: false,
    gender: 0,
    father: 0,
    mother: 0,
    camRotation: 180,
    valorDecrement: 0,
    genderNames: ["Homem", "Mulher"],
    fatherNames: ["Benjamin", "Daniel", "Joshua", "Noah", "Andrew", "Juan", "Alex", "Isaac", "Evan", "Ethan", "Vincent", "Angel", "Diego", "Adrian", "Gabriel", "Michael", "Santiago", "Kevin", "Louis", "Samuel", "Anthony", "Claude", "Niko", "John"],
    motherNames: ["Hannah", "Aubrey", "Jasmine", "Gisele", "Amelia", "Isabella", "Zoe", "Ava", "Camila", "Violet", "Sophia", "Evelyn", "Nicole", "Ashley", "Gracie", "Brianna", "Natalie", "Olivia", "Elizabeth", "Charlotte", "Emma", "Misty"],
    fathersID: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 42, 43, 44],
    mothersID: [21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 45],
    skinColor: 6,
    shapeMix: 0.5,
    i18n: {
      gender: "Gênero",
      father: "Pai",
      mother: "Mãe",
      back: "Voltar",
      skinCol: "Cor da Pele",
      rot: "Rotação",
      next: "Próximo",
    },
  },
  methods: {
    OpenCharacterMode: function(gender) {
      this.CharacterMode = true
    },
    CloseCharacterMode: function() {
      this.CharacterMode = false
    },
    decrement: function() {
      if (this.shapeMix - 0.1 < 0) return
      this.shapeMix = this.shapeMix - 1
      this.changeAppearance();
    },
    increment: function() {
      if (this.shapeMix + 0.1 > 1) return
      this.shapeMix = this.shapeMix + 1
      this.changeAppearance();
    },
    prevFather: function() {
      if (this.father === 0) this.father = 23;
      else this.father--;
      this.changeAppearance();
    },
    nextFather: function() {
      if (this.father === 23) this.father = 0;
      else this.father++;
      this.changeAppearance();
    },
    prevMother: function() {
      if (this.mother === 0) this.mother = 21;
      else this.mother--;
      this.changeAppearance();
    },
    nextMother: function() {
      if (this.mother === 21) this.mother = 0;
      else this.mother++;
      this.changeAppearance();
    },
    changeAppearance: function() {
      const arr = {
        fathersID: this.fathersID[this.father],
        mothersID: this.mothersID[this.mother],
        skinColor: this.skinColor,
        shapeMix: this.shapeMix,
      };
      $.post('http://creation/UpdateSkinOptions', JSON.stringify(arr));
    },
    changeGender: function() {
        if (this.gender === 1) this.gender = 0;
        else this.gender = 1;
        $.post('http://creation/ChangeGender', JSON.stringify({
            gender: this.gender
        }));
        this.changeAppearance();
    },
    changeCamRotation: function() {
      $.post('http://creation/cChangeHeading', JSON.stringify({
        camRotation: this.camRotation
      }));
    },
    back: function() {
      this.CloseCharacterMode();
      app.OpenCharacterMode();
      $.post('http://creation/BackPart0');
    },
    done: function() {
      const arr = [
        this.fathersID[this.father],
        this.mothersID[this.mother],
        this.skinColor,
        this.shapeMix,
      ];
      this.CloseCharacterMode();
      $.post('http://creation/cDone');
    },
    inputDecrement: function(e,item) {
      if (this[e] <= this.$refs[item].getAttribute('min')) return;
      this[e] -= 1
      app.changeAppearance();
    },
    inputIncrement: function(e,item) {
      if (this[e] >= this.$refs[item].getAttribute('max')) return;
      this[e] += 1
      app3.changeAppearance();
    },
  }
});

const app2 = new Vue({
  el: '#app2',
  data: {
    CharacterMode2: false,
    camRotation: 180,
    eyesColor: 0,
    eyebrowsHeight: 0.0,
    eyebrowsWidth: 0.0,
    noseWidth: 0.0,
    noseHeight: 0.0,
    noseLength: 0.0,
    noseBridge: 0.0,
    noseTip: 0.0,
    noseShift: 0.0,
    cheekboneHeight: 0.0,
    cheekboneWidth: 0.0,
    cheeksWidth: 0.0,
    lips: 0.0,
    jawWidth: 0.0,
    jawHeight: 0.0,
    chinLength: 0.0,
    chinPosition: 0.0,
    chinWidth: 0.0,
    chinShape: 0.0,
    neckWidth: 0.0,
    i18n: {
      rot: "Rotação",
      next: "Próximo",
      back: "Voltar",
    },
  },
  methods: {
    OpenCharacterMode: function() {
      this.CharacterMode2 = true
    },
    CloseCharacterMode: function() {
      this.CharacterMode2 = false
    },
    changeAppearance: function() {
      const arr = {
        eyesColor: this.eyesColor,
        eyebrowsHeight: this.eyebrowsHeight,
        eyebrowsWidth: this.eyebrowsWidth,
        noseWidth: this.noseWidth,
        noseHeight: this.noseHeight,
        noseLength: this.noseLength,
        noseBridge: this.noseBridge,
        noseTip: this.noseTip,
        noseShift: this.noseShift,
        cheekboneHeight: this.cheekboneHeight,
        cheekboneWidth: this.cheekboneWidth,
        cheeksWidth: this.cheeksWidth,
        lips: this.lips,
        jawWidth: this.jawWidth,
        jawHeight: this.jawHeight,
        chinLength: this.chinLength,
        chinPosition: this.chinPosition,
        chinWidth: this.chinWidth,
        chinShape: this.chinShape,
        neckWidth: this.neckWidth,
      };
      $.post('http://creation/UpdateFaceOptions', JSON.stringify(arr));
    },
    changeCamRotation: function() {
      $.post('http://creation/cChangeHeading', JSON.stringify({
        camRotation: this.camRotation
      }));
    },
    back: function() {
      this.CloseCharacterMode();
      app.OpenCharacterMode();
      $.post('http://creation/BackPart1');
    },
    done: function() {
      this.CloseCharacterMode();
      $.post('http://creation/cDonePart2');
    },

    inputDecrement: function(e,item) {
      if (this[e] <= this.$refs[item].getAttribute('min')) return;
      this[e] -= 1
      app2.changeAppearance();
    },
    inputIncrement: function(e,item) {
      if (this[e] >= this.$refs[item].getAttribute('max')) return;
      this[e] += 1
      app2.changeAppearance();
    },
  }
});

const app3 = new Vue({
  el: '#app3',
  data: {
    CharacterMode3: false,
    camRotation: 180,
    hairModel: 4,
    firstHairColor: 0,
    secondHairColor: 0,
    eyebrowsModel: 0,
    eyebrowsColor: 0,
    beardModel: -1,
    beardColor: 0,
    chestModel: -1,
    chestColor: 0,
    blushModel: -1,
    blushColor: 0,
    lipstickModel: -1,
    lipstickColor: 0,
    blemishesModel: -1,
    ageingModel: -1,
    complexionModel: -1,
    sundamageModel: -1,
    frecklesModel: -1,
    makeupModel: -1,
    i18n: {
      rot: "Rotação",
      save: "Salvar",
      back: "Voltar",
    },
  },
  methods: {
    inputDecrement: function(e,item) {
      if (this[e] <= this.$refs[item].getAttribute('min')) return;
      this[e] -= 1
      app3.changeAppearance();
    },
    inputIncrement: function(e,item) {
      if (this[e] >= this.$refs[item].getAttribute('max')) return;
      this[e] += 1
      app3.changeAppearance();
    },
    OpenCharacterMode: function() {
      this.CharacterMode3 = true
    },
    CloseCharacterMode: function() {
      this.CharacterMode3 = false
    },
    changeAppearance: function() {
      const arr = {
        hairModel: this.hairModel,
        firstHairColor: this.firstHairColor,
        secondHairColor: this.secondHairColor,
        eyebrowsModel: this.eyebrowsModel,
        eyebrowsColor: this.eyebrowsColor,
        beardModel: this.beardModel,
        beardColor: this.beardColor,
        chestModel: this.chestModel,
        chestColor: this.chestColor,
        blushModel: this.blushModel,
        blushColor: this.blushColor,
        lipstickModel: this.lipstickModel,
        lipstickColor: this.lipstickColor,
        blemishesModel: this.blemishesModel,
        ageingModel: this.ageingModel,
        complexionModel: this.complexionModel,
        sundamageModel: this.sundamageModel,
        frecklesModel: this.frecklesModel,
        makeupModel: this.makeupModel,
        makeupColor: this.makeupColor,
      };
      $.post('http://creation/UpdateHeadOptions', JSON.stringify(arr));
    },
    changeCamRotation: function() {
      $.post('http://creation/cChangeHeading', JSON.stringify({
        camRotation: this.camRotation
      }));
    },
    back: function() {
      this.CloseCharacterMode();
      app3.OpenCharacterMode();
      $.post('http://creation/BackPart2');
    },
    exit: function() {
      $('body').hide();
      $.post('http://creation/cDoneSave');
    },
  }
});


window.addEventListener("load", function(event) {
  app.changeAppearance();
  app.changeAppearance();
  app2.changeAppearance();
  app3.changeAppearance();
  window.addEventListener('message', function(event){
    var item = event.data;

      // item.spawn?appspawn.OpenSpawnMode() : appspawn.CloseSpawnMode();
      item.CharacterMode0?app0.OpenCharacterMode() : app0.CloseCharacterMode();
      item.CharacterMode?app.OpenCharacterMode(item.gender) : app.CloseCharacterMode();
      item.CharacterMode2?app2.OpenCharacterMode():app2.CloseCharacterMode();
      item.CharacterMode3?app3.OpenCharacterMode():app3.CloseCharacterMode();

  });
});



function shake(el) {
  var ang = -2;
  var prefix = (function () {
      var styles = window.getComputedStyle(document.documentElement, ''),
      pre = (Array.prototype.slice.call(styles).join('').match(/-(moz|webkit|ms)-/) || (styles.OLink === '' && ['', 'o']))[1];
      if (pre == 'moz')
      return '';
      return '-' + pre + '-';
  })();
  var qtd = 0;
  var shakeInterval = setInterval(function () {
      ang = -ang;
      el.style[prefix + 'transform'] = 'rotate(' + ang + 'deg)';
      qtd++;
      if (qtd > 5) {
          el.style[prefix + 'transform'] = 'rotate(0deg)';
          clearInterval(shakeInterval);
      }
  }, 100);
}