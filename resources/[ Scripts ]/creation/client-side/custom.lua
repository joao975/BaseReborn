local function f(n)
	n = parseInt(n) + 0.00000
	return n
end

function setBarbershop(ped,data)
	if not data then
		return
	end
	
	SetPedHeadBlendData(ped,data.fathersID,data.mothersID,0,data.skinColor,0,0,f(data.shapeMix),0,0,false)
	-- Olhos
	SetPedEyeColor(ped,data.eyesColor)
	-- Sobrancelha
	SetPedFaceFeature(ped,6,data.eyebrowsHeight)
	SetPedFaceFeature(ped,7,data.eyebrowsWidth)
	-- Nariz
	SetPedFaceFeature(ped,0,data.noseWidth)
	SetPedFaceFeature(ped,1,data.noseHeight)
	SetPedFaceFeature(ped,2,data.noseLength)
	SetPedFaceFeature(ped,3,data.noseBridge)
	SetPedFaceFeature(ped,4,data.noseTip)
	SetPedFaceFeature(ped,5,data.noseShift)
	-- Bochechas
	SetPedFaceFeature(ped,8,data.cheekboneHeight)
	SetPedFaceFeature(ped,9,data.cheekboneWidth)
	SetPedFaceFeature(ped,10,data.cheeksWidth)
	-- Boca/Mandibula
	SetPedFaceFeature(ped,12,data.lips)
	SetPedFaceFeature(ped,13,data.jawWidth)
	SetPedFaceFeature(ped,14,data.jawHeight)
	-- Queixo
	SetPedFaceFeature(ped,15,data.chinLength)
	SetPedFaceFeature(ped,16,data.chinPosition)
	SetPedFaceFeature(ped,17,data.chinWidth)
	SetPedFaceFeature(ped,18,data.chinShape)
	-- Pescoço
	SetPedFaceFeature(ped,19,data.neckWidth)

	SetPedComponentVariation(ped,2,data.hairModel,0,0)
	SetPedHairColor(ped,data.firstHairColor,data.secondHairColor)

	-- Sobrancelha
	SetPedHeadOverlay(ped,2,data.eyebrowsModel, 0.99)
	SetPedHeadOverlayColor(ped,2,1,data.eyebrowsColor,data.eyebrowsColor)

	-- Barba
	SetPedHeadOverlay(ped,1,data.beardModel,0.99)
	SetPedHeadOverlayColor(ped,1,1,data.beardColor,data.beardColor)

	-- Pelo Corporal
	SetPedHeadOverlay(ped,10,data.chestModel,0.99)
	SetPedHeadOverlayColor(ped,10,1,data.chestColor,data.chestColor)

	-- Blush
	SetPedHeadOverlay(ped,5,data.blushModel,0.99)
	SetPedHeadOverlayColor(ped,5,2,data.blushColor,data.blushColor)

	-- Battom
	SetPedHeadOverlay(ped,8,data.lipstickModel,0.99)
	SetPedHeadOverlayColor(ped,8,2,data.lipstickColor,data.lipstickColor)
	

	-- Manchas
	SetPedHeadOverlay(ped,0,data.blemishesModel,0.99)
	SetPedHeadOverlayColor(ped,0,0,0,0)

	-- Envelhecimento
	SetPedHeadOverlay(ped,3,data.ageingModel,0.99)
	SetPedHeadOverlayColor(ped,3,0,0,0)

	-- Aspecto
	SetPedHeadOverlay(ped,6,data.complexionModel,0.99)
	SetPedHeadOverlayColor(ped,6,0,0,0)

	-- Pele
	SetPedHeadOverlay(ped,7,data.sundamageModel,0.99)
	SetPedHeadOverlayColor(ped,7,0,0,0)

	-- Sardas
	SetPedHeadOverlay(ped,9,data.frecklesModel,0.99)
	SetPedHeadOverlayColor(ped,9,0,0,0)

	-- Maquiagem
	SetPedHeadOverlay(ped,4,data.makeupModel,0.99)
	SetPedHeadOverlayColor(ped,4,0,data.makeupcolor,data.makeupcolor)
end


local parts = {
    mascara = 1,
    mao = 3,
    calca = 4,
    mochila = 5,
    sapato = 6,
    gravata = 7,
    camisa = 8,
    jaqueta = 11,
    bone = "p0",
    oculos = "p1",
    brinco = "p2",
    relogio = "p6",
    bracelete = "p7"
}

function setClothing(ped,data)
	
end