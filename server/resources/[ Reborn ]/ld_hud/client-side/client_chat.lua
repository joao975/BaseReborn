
local isRDR = not TerraingridActivate and true or false

local chatInputActive = false
local chatInputActivating = false
local chatLoaded = false

RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:addSuggestions')
RegisterNetEvent('chat:addMode')
RegisterNetEvent('chat:removeMode')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('chat:clear')

-- internal events
RegisterNetEvent('__cfx_internal:serverPrint')

RegisterNetEvent('_chat:messageEntered')

--deprecated, use chat:addMessage
AddEventHandler('chatMessage', function(author, color, text)
  local args = { text }
  if author ~= "" then
    table.insert(args, 1, author)
  end

  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      color = color,
      multiline = true,
      args = args
    }
  })
end)

AddEventHandler('__cfx_internal:serverPrint', function(msg)
  return
end)

local chatEnabled = true

RegisterCommand('togglechat',function(source,args,rawCommand)
	if chatEnabled then
		TriggerEvent("Notify","importante","Você desativou o chat! Não receberá mais mensagens.",5000)
		chatEnabled = false
	else
		TriggerEvent("Notify","sucesso","Você ativou o chat! Agora você receberá as mensagens novamente.",5000)
		chatEnabled = true
	end
end)

-- addMessage
local addMessage = function(message)
  if not chatEnabled then return end
  if type(message) == 'string' then
	
    message = {
      args = { message }
    }
  end
  
  for i = 1, #emoji do
      for k = 1, #emoji[i][1] do
		if string.find(message["args"][2], emoji[i][1][k]) then
			message["args"][2] = string.gsub(message["args"][2], emoji[i][1][k], emoji[i][2])
		end
      end
    end
  
	
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = message
  })
end

exports('addMessage', addMessage)
AddEventHandler('chat:addMessage', addMessage)

AddEventHandler('chat:removeSuggestion', function(name)
  SendNUIMessage({
    type = 'ON_SUGGESTION_REMOVE',
    name = name
  })
end)

AddEventHandler('chat:addMode', function(mode)
  SendNUIMessage({
    type = 'ON_MODE_ADD',
    mode = mode
  })
end)

AddEventHandler('chat:removeMode', function(name)
  SendNUIMessage({
    type = 'ON_MODE_REMOVE',
    name = name
  })
end)

AddEventHandler('chat:addTemplate', function(id, html)
  SendNUIMessage({
    type = 'ON_TEMPLATE_ADD',
    template = {
      id = id,
      html = html
    }
  })
end)

AddEventHandler('chat:clear', function(name)
  SendNUIMessage({
    type = 'ON_CLEAR'
  })
end)

RegisterNUICallback('chatResult', function(data, cb)
  chatInputActive = false
  SetNuiFocus(false)

  if not data.canceled then
    local id = PlayerId()
    local r, g, b = 0, 0x99, 255
    if data.message:sub(1, 1) == '/' then
      ExecuteCommand(data.message:sub(2))
    else
      TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message, data.mode)
    end
  end

  cb('ok')
end)

local function refreshCommands()
  if GetRegisteredCommands then
    local registeredCommands = GetRegisteredCommands()
    local suggestions = {}

    for _, command in ipairs(registeredCommands) do
      if IsAceAllowed(('command.%s'):format(command.name)) and command.name ~= 'toggleChat' then
        table.insert(suggestions, {
          name = '/' .. command.name,
          help = ''
        })
      end
    end

    TriggerEvent('chat:addSuggestions', suggestions)
  end
end

local function refreshThemes()
  local themes = {}

  for resIdx = 0, GetNumResources() - 1 do
    local resource = GetResourceByFindIndex(resIdx)

    if GetResourceState(resource) == 'started' then
      local numThemes = GetNumResourceMetadata(resource, 'chat_theme')

      if numThemes > 0 then
        local themeName = GetResourceMetadata(resource, 'chat_theme')
        local themeData = json.decode(GetResourceMetadata(resource, 'chat_theme_extra') or 'null')

        if themeName and themeData then
          themeData.baseUrl = 'nui://' .. resource .. '/'
          themes[themeName] = themeData
        end
      end
    end
  end

  SendNUIMessage({
    type = 'ON_UPDATE_THEMES',
    themes = themes
  })
end

AddEventHandler('onClientResourceStart', function(resName)
  Wait(500)

  refreshCommands()
  refreshThemes()
end)

AddEventHandler('onClientResourceStop', function(resName)
  Wait(500)

  refreshCommands()
  refreshThemes()
end)

RegisterNUICallback('loaded', function(data, cb)
  TriggerServerEvent('chat:init')

  refreshCommands()
  refreshThemes()

  chatLoaded = true

  cb('ok')
end)

local CHAT_HIDE_STATES = {
  SHOW_WHEN_ACTIVE = 0,
  ALWAYS_SHOW = 1,
  ALWAYS_HIDE = 2
}

local kvpEntry = GetResourceKvpString('hideState')
local chatHideState = kvpEntry ~= nil and tonumber(kvpEntry) or CHAT_HIDE_STATES.SHOW_WHEN_ACTIVE
local isFirstHide = true




if not isRDR then
   RegisterCommand('chat', function()
    if chatHideState == CHAT_HIDE_STATES.SHOW_WHEN_ACTIVE then
      chatHideState = CHAT_HIDE_STATES.ALWAYS_SHOW
    elseif chatHideState == CHAT_HIDE_STATES.ALWAYS_SHOW then
      chatHideState = CHAT_HIDE_STATES.ALWAYS_HIDE
    elseif chatHideState == CHAT_HIDE_STATES.ALWAYS_HIDE then
      chatHideState = CHAT_HIDE_STATES.SHOW_WHEN_ACTIVE
    end

    isFirstHide = false

    SetResourceKvp('hideState', tostring(chatHideState))
  end, false)
end

Citizen.CreateThread(function()
  SetTextChatEnabled(false)
  SetNuiFocus(false)
  local lastChatHideState = -1
  local origChatHideState = -1

  while true do
    local splyphe = 500

    if not chatInputActive then
      splyphe = 0
      if IsControlPressed(0, isRDR and `INPUT_MP_TEXT_CHAT_ALL` or 245) then
        chatInputActive = true
        chatInputActivating = true

        SendNUIMessage({
          type = 'ON_OPEN'
        })
        
      end
      if IsControlPressed(0, 344) then
        SendNUIMessage({
          type = 'ON_CLOSE'
        })
      end
    end

    --[[ SendNUIMessage({
      type = 'ON_CLOSE'
    }) ]]

    if chatInputActivating then
      splyphe = 0
      if not IsControlPressed(0, isRDR and `INPUT_MP_TEXT_CHAT_ALL` or 245) then
        SetNuiFocus(true)
        chatInputActivating = false
      end
    end

    if chatLoaded then
      splyphe = 0
      local forceHide = false

      if forceHide then
        origChatHideState = chatHideState
        chatHideState = CHAT_HIDE_STATES.ALWAYS_HIDE
      elseif origChatHideState ~= -1 then
        chatHideState = origChatHideState
        origChatHideState = -1
      end

      if chatHideState ~= lastChatHideState then
        lastChatHideState = chatHideState

        SendNUIMessage({
          type = 'ON_SCREEN_STATE_CHANGE',
          hideState = chatHideState,
          fromUserInteraction = not forceHide and not isFirstHide
        })

        isFirstHide = false
      end
    end
    Wait(splyphe)
  end
end)
