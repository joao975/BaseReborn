Config = {}

Config.admCommand = "admenu"

Config.permissions = {
    "Admin",
    "admin.permissao"
}

Config.base = "vrpex"

Config.debug = false

Config.AdminMenus = {
    {
        ['Id'] = 'player',
        ['Name'] = 'Player',
        ['Items'] = {
            {
                ['Id'] = 'changeModel',
                ['Name'] = 'Mudar Model',
                ['Event'] = 'Admin:Change:Model',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                    {
                        ['Id'] = 'model',
                        ['Name'] = 'Model',
                        ['Type'] = 'input',
                        ['Value'] = '',
                    },
                },
            },
            {
                ['Id'] = 'rmodel',
                ['Name'] = 'Resetar Model',
                ['Event'] = 'Admin:Reset:Model',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'clothing',
                ['Name'] = 'Roupas',
                ['Event'] = 'Admin:Open:Clothing',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'barber',
                ['Name'] = 'BarberShop',
                ['Event'] = 'Admin:Open:BarberShop',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'armor',
                ['Name'] = 'Colete',
                ['Event'] = 'will_admin/client/armor-up',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'food-drink',
                ['Name'] = 'Comida & Bebida',
                ['Event'] = 'Admin:Food:Drink',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'godmode',
                ['Name'] = 'Godmode',
                ['Event'] = 'Admin:Godmode',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'opinventory',
                ['Name'] = 'Abrir Inventario',
                ['Event'] = 'Admin:OpenInv',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'revive',
                ['Name'] = 'Reviver',
                ['Event'] = 'Admin:Revive',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'reviveRadius',
                ['Name'] = 'Reviver por perto',
                ['Event'] = 'will_admin:ReviveInDistance',
                ['EventType'] = 'Client',
                ['Collapse'] = false,
            },
        }
    },
    {
        ['Id'] = 'utility',
        ['Name'] = 'Utility',
        ['Items'] = {
            {
                ['Id'] = 'playerblips',
                ['Name'] = 'Blips dos players',
                ['Event'] = 'Admin:Toggle:PlayerBlips',
                ['EventType'] = 'Client',
                ['Collapse'] = false,
            },
			{
                ['Id'] = 'DebugMode',
                ['Name'] = 'DebugMode',
                ['Event'] = 'will_admin/client/toggle-debug',
                ['EventType'] = 'Client',
                ['Collapse'] = false,
            },
            {
                ['Id'] = 'playernames',
                ['Name'] = 'Nomes dos players',
                ['Event'] = 'Admin:Toggle:PlayerNames',
                ['EventType'] = 'Client',
                ['Collapse'] = false,
            },
            {
                ['Id'] = 'deleteVehicle',
                ['Name'] = 'Deletar veiculo',
                ['Event'] = 'Admin:Delete:Vehicle',
                ['Collapse'] = false,
            },
            {
                ['Id'] = 'spawnVehicle',
                ['Name'] = 'Spawnar veiculo',
                ['Event'] = 'Admin:Spawn:Vehicle',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'model',
                        ['Name'] = 'Model',
                        ['Type'] = 'text-choice',
                    },
                },
            },
            {
                ['Id'] = 'fixVehicle',
                ['Name'] = 'Fix',
                ['Event'] = 'Admin:Fix:Vehicle',
                ['EventType'] = 'Client',
                ['Collapse'] = false,
            },
            {
                ['Id'] = 'bennysMenu',
                ['Name'] = 'Bennys',
                ['Event'] = 'will_admin:openBennys',
                ['EventType'] = 'Client',
                ['Collapse'] = false,
            },
            {
                ['Id'] = 'teleport',
                ['Name'] = 'Teleport',
                ['Event'] = 'Admin:Teleport',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                    {
                        ['Id'] = 'type',
                        ['Name'] = 'Type',
                        ['Type'] = 'input-choice',
                        ['Choices'] = {
                            {
                                Text = 'Goto'
                            },
                            {
                                Text = 'Bring'
                            }
                        }
                    },
                },
            },
            {
                ['Id'] = 'teleportCoords',
                ['Name'] = 'Teleport Coords',
                ['Event'] = 'Admin:Teleport:Coords',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'x-coord',
                        ['Name'] = 'X Coord',
                        ['Type'] = 'input',
                        ['InputType'] = 'number',
                    },
                    {
                        ['Id'] = 'y-coord',
                        ['Name'] = 'Y Coord',
                        ['Type'] = 'input',
                        ['InputType'] = 'number',
                    },
                    {
                        ['Id'] = 'z-coord',
                        ['Name'] = 'Z Coord',
                        ['Type'] = 'input',
                        ['InputType'] = 'number',
                    },
                },
            },
            {
                ['Id'] = 'teleportMarker',
                ['Name'] = 'Teleport Marker',
                ['Event'] = 'Admin:Teleport:Marker',
                ['EventType'] = 'Client',
                ['Collapse'] = false,
            },
            {
                ['Id'] = 'chatSay',
                ['Name'] = 'cSay',
                ['Event'] = 'Admin:Chat:Say',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'message',
                        ['Name'] = 'Message',
                        ['Type'] = 'input',
                        ['InputType'] = 'text',
                    }
                }
            },
            {
                ['Id'] = 'copyCoords',
                ['Name'] = 'Copiar Coords',
                ['Event'] = 'Admin:Copy:Coords',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'type',
                        ['Name'] = 'Type',
                        ['Type'] = 'input-choice',             
                        ['Choices'] = {
                            {
                                Text = 'vector3(0.0, 0.0, 0.0)'
                            },
                            {
                                Text = 'vector4(0.0, 0.0, 0.0, 0.0)'
                            },
                            {
                                Text = '0.0, 0.0, 0.0'
                            },
                            {
                                Text = '0.0, 0.0, 0.0, 0.0'
                            },
                            {
                                Text = 'X = 0.0, Y = 0.0, Z = 0.0'
                            },
                            {
                                Text = 'x = 0.0, y = 0.0, z = 0.0'
                            },
                            {
                                Text = 'X = 0.0, Y = 0.0, Z = 0.0, H = 0.0'
                            },
                            {
                                Text = 'x = 0.0, y = 0.0, z = 0.0, h = 0.0'
                            },
                            {
                                Text = '["X"] = 0.0, ["Y"] = 0.0, ["Z"] = 0.0'
                            },
                            {
                                Text = '["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0'
                            },
                            {
                                Text = '["X"] = 0.0, ["Y"] = 0.0, ["Z"] = 0.0, ["H"] = 0.0'
                            },
                            {
                                Text = '["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0, ["h"] = 0.0'
                            }
                        }
                    },
                },
            },
        }
    },
    
    {
        ['Id'] = 'fun',
        ['Name'] = 'Fun',
        ['Items'] = {
            {
                ['Id'] = 'flingPlayer',
                ['Name'] = 'Arremessar player',
                ['Event'] = 'Admin:Fling:Player',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'drunkPlayer',
                ['Name'] = 'Deixar player bêbado',
                ['Event'] = 'Admin:Drunk',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'animalattackPlayer',
                ['Name'] = 'Ataque de animal',
                ['Event'] = 'Admin:Animal:Attack',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'setfirePlayer',
                ['Name'] = 'Pegar fogo',
                ['Event'] = 'Admin:Set:Fire',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
        }
    },
    {
        ['Id'] = 'user',
        ['Name'] = 'Users',
        ['Items'] = {
            {
                ['Id'] = 'setjob',
                ['Name'] = 'Setar grupo',
                ['Event'] = 'Admin:Request:Job',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                    {
                        ['Id'] = 'job',
                        ['Name'] = 'Job',
                        ['Type'] = 'text-choice',
                        ['Choices'] = {}
                    },
                },
            },
            {
                ['Id'] = 'giveItem',
                ['Name'] = 'Dar item',
                ['Event'] = 'Admin:GiveItem',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                    {
                        ['Id'] = 'item',
                        ['Name'] = 'Item',
                        ['Type'] = 'text-choice',
                        -- ['Choices'] = GetInventoryItems()
                    },
                    {
                        ['Id'] = 'amount',
                        ['Name'] = 'Amount',
                        ['Type'] = 'input',
                        ['InputType'] = 'number',
                    },
                },
            },
            {
                ['Id'] = 'banPlayer',
                ['Name'] = 'Banir player',
                ['Event'] = 'Admin:Ban',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                    {
                        ['Id'] = 'expire',
                        ['Name'] = 'Expire',
                        ['Type'] = 'input-choice',
                        ['Choices'] = {
                            {
                                Text = '1 Hora'
                            },
                            {
                                Text = '6 Horas'
                            },
                            {
                                Text = '12 Horas'
                            },
                            {
                                Text = '1 Dia'
                            },
                            {
                                Text = '3 Dias'
                            },
                            {
                                Text = '1 Semana'
                            },
                            {
                                Text = 'Permanente'
                            }
                        }
                    },
                    {
                        ['Id'] = 'reason',
                        ['Name'] = 'Razão',
                        ['Type'] = 'input',
                        ['InputType'] = 'text',
                    },
                },
            },
            {
                ['Id'] = 'kickPlayer',
                ['Name'] = 'Kickar player',
                ['Event'] = 'Admin:Kick',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                    {
                        ['Id'] = 'reason',
                        ['Name'] = 'Razão',
                        ['Type'] = 'input',
                        ['InputType'] = 'text',
                    },
                },
            },
            {
                ['Id'] = 'spectate',
                ['Name'] = 'Visualizar player',
                ['Event'] = 'Admin:Toggle:Spectate',
                ['EventType'] = 'Client',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                }
            },

            
        }
    },
}