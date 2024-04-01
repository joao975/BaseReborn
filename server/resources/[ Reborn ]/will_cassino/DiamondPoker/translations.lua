Translations = {}

function translat(str, ...) -- Translate string
    if Translations[Config.TranslationSelected] ~= nil then
        if Translations[Config.TranslationSelected][str] ~= nil then
            return string.format(Translations[Config.TranslationSelected][str], ...)
        else
            return 'Translation [' .. Config.TranslationSelected .. '][' .. str .. '] does not exist'
        end
    else
        return 'Locale [' .. Config.TranslationSelected .. '] does not exist'
    end
end

function translate(str, ...) -- Translate string first char uppercase
    return tostring(translat(str, ...):gsub('^%l', string.upper))
end

Translations['br'] = {
    -- notifications
    ['chair_occupied'] = 'Essa cadeira está ocupada.',
    ['no_react'] = 'Você não respondeu ao Dealer no tempo, sua mão passou.',
    ['no_bet_input'] = 'Você não colocou uma aposta.',
    ['not_enough_chips'] = 'Você não possui fichas suficientes.',
    ['not_enough_chips_next'] = 'Você não possui fichas suficientes para apostar no Pair Plus.',
    ['not_enough_chips_third'] = 'Você não possui fichas suficientes para apostar.',
    ['not_enough_chips_toplay'] = 'Você não possui fichas suficientes para apostar!',
    ['already_betted'] = 'Você já apostou.',
    ['lose'] = 'Você perdeu!',
    -- formatted notif
    ['dealer_not_qual'] = 'Empate.\nVocê ganhou %s fichas de volta.',
    ['dealer_not_qual_ante'] = 'Empate.\nVocê ganhou %s fichas de volta. (Ante multiplicador: x%s)',
    ['player_won_ante'] = 'Você ganhou!\n%s fichas. (Ante multiplicador: x%s)',
    ['player_won'] = 'Você ganhou %s fichas.',
    ['pair_won'] = 'Você ganhou %s fichas. Pair Plus! (Pair multiplicador: x%s)',
    -- hud
    ['current_bet_input'] = 'APOSTA:',
    ['current_player_chips'] = 'FICHAS:',
    ['table_min_max'] = 'MIN/MAX:',
    ['remaining_time'] = 'TEMPO:',
    -- top left
    ['waiting_for_players'] = 'Esperando por ~b~jogadores~w~...\n',
    ['clearing_table'] = 'Limpando a mesa.\n~b~Proximo jogo começa em breve.\n',
    ['dealer_showing_hand'] = 'O ~r~Dealer~w~ está mostrando sua mão.\n',
    ['players_showing_hands'] = 'Revelando mão dos jogadores.\n',
    ['dealing_cards'] = 'Entregando cartas.\n',
    -- inputs
    ['fold_cards'] = 'Correr',
    ['play_cards'] = 'Jogar',
    ['leave_game'] = 'Deixar jogo',
    ['raise_bet'] = 'Aumentar aposta',
    ['reduce_bet'] = 'Reduzir aposta',
    ['custom_bet'] = 'Aposta personalizada',
    ['place_bet'] = 'Colocar aposta',
    ['place_pair_bet'] = 'Colocar Pair Plus aposta',
    -- gtao ui
    ['tcp'] = '~b~Three Card Poker',
    ['sit_down_table'] = '~h~<C>Jogar</C> ~b~Three Card Poker',
    ['description'] = 'Game Description',
    ['desc_1'] = 'TCP_DIS1', -- this is Rockstar Setuped default, this will automaticly change if you are using german language etc.
    ['desc_2'] = 'TCP_DIS2',
    ['desc_3'] = 'TCP_DIS3',
    ['description_info'] = 'Como o jogo funciona?',
    ['rule_1'] = 'TCP_RULE_1',
    ['rule_2'] = 'TCP_RULE_2',
    ['rule_3'] = 'TCP_RULE_3',
    ['rule_4'] = 'TCP_RULE_4',
    ['rule_5'] = 'TCP_RULE_5',
    ['rule_header_1'] = 'TCP_RULE_1T',
    ['rule_header_2'] = 'TCP_RULE_2T',
    ['rule_header_3'] = 'TCP_RULE_3T',
    ['rule_header_4'] = 'TCP_RULE_4T',
    ['rule_header_5'] = 'TCP_RULE_5T',
    ['rules'] = 'Regras do jogo',
    ['rules_info'] = 'Regras do jogo.',
    ['limit_exceed'] = 'Sua aposta é muito pequena, ou muito grande para essa mesa.',
    ['invalid_bet'] = 'Quantidade invalida.',
    ['chair_used'] = 'Essa cadeira está ocupada.',
    ['can_not_bet_because_started'] = 'O jogo já começou, você não pode apostar no momento.',
    ['input_place_bet'] = 'Quantas fichas deseja apostar?',
    -- help msg
    ['help_sit_rulett'] = '~INPUT_CONTEXT~ Sentar na mesa.',
    ['help_rulett_all'] = '~INPUT_CELLPHONE_CANCEL~ Levantar-se\n~INPUT_CONTEXT~ Mudar camera\n~INPUT_LOOK_LR~ Selecionar numero\n~INPUT_ATTACK~ Apostar numero\n~INPUT_CELLPHONE_UP~ Aumentar aposta\n~INPUT_CELLPHONE_DOWN~ Diminuir aposta\n~INPUT_JUMP~ Aposta personalizada',
    -- nui
    ['starting_soon'] = 'O jogo começa em instantes..',
    ['game_going_on'] = 'O jogo está em progresso..',
    ['seconds'] = 'segundos.',
    -- formatted msg
    ['won_chips'] = 'Você ganhou %s fichas. Multiplicador: x%s',
    ['placed_bet'] = 'Aposta de %s fichas feita.'
}

Translations['en'] = {
    -- notifications
    ['chair_occupied'] = 'This seat is occupied.',
    ['no_react'] = 'You did not respond for the dealer ask in time, you have folded your hand.',
    ['no_bet_input'] = 'You did not set up a bet value.',
    ['not_enough_chips'] = 'You do not have enough chips.',
    ['not_enough_chips_next'] = 'You do not have enough chips to bet on the Pair Plus, because you would not have enough chips for the playing.',
    ['not_enough_chips_third'] = 'You can not put that amount of chips because you would not have enough for playing your hand.',
    ['not_enough_chips_toplay'] = 'You do not have enough chips to play!',
    ['already_betted'] = 'You already betted.',
    ['lose'] = 'You lose!',
    -- formatted notif
    ['dealer_not_qual'] = 'Draw.\nThe Dealer did not qualify for the game.\nYou got %s chips back.',
    ['dealer_not_qual_ante'] = 'Draw.\nThe Dealer did not qualify for the game.\nYou got %s chips back. (Ante multiplier: x%s)',
    ['player_won_ante'] = 'Your hand won!\nYou got %s chips. (Ante multiplier: x%s)',
    ['player_won'] = 'Your hand won!\nYou got %s chips.',
    ['pair_won'] = 'You won %s chips with your Pair Plus bet! (Pair multiplier: x%s)',
    -- hud
    ['current_bet_input'] = 'BET:',
    ['current_player_chips'] = 'CHIPS:',
    ['table_min_max'] = 'MIN/MAX:',
    ['remaining_time'] = 'TIME:',
    -- top left
    ['waiting_for_players'] = 'Waiting for ~b~players~w~...\n',
    ['clearing_table'] = 'Clearing the table..\n~b~Next game starting soon.\n',
    ['dealer_showing_hand'] = 'The ~r~Dealer~w~ is showing his hand.\n',
    ['players_showing_hands'] = 'Revealing player hands..\n',
    ['dealing_cards'] = 'Dealing cards to players..\n',
    -- inputs
    ['fold_cards'] = 'Fold',
    ['play_cards'] = 'Play',
    ['leave_game'] = 'Leave game',
    ['raise_bet'] = 'Raise bet',
    ['reduce_bet'] = 'Reduce bet',
    ['custom_bet'] = 'Custom bet',
    ['place_bet'] = 'Place bet',
    ['place_pair_bet'] = 'Place Pair Plus bet',
    -- gtao ui
    ['tcp'] = '<C>[Aquiver]</C> ~b~Three Card Poker',
    ['sit_down_table'] = '~h~<C>Play</C> ~b~Three Card Poker',
    ['description'] = 'Game Description',
    ['desc_1'] = 'TCP_DIS1', -- this is Rockstar Setuped default, this will automaticly change if you are using german language etc.
    ['desc_2'] = 'TCP_DIS2',
    ['desc_3'] = 'TCP_DIS3',
    ['description_info'] = 'How is the game working?',
    ['rule_1'] = 'TCP_RULE_1',
    ['rule_2'] = 'TCP_RULE_2',
    ['rule_3'] = 'TCP_RULE_3',
    ['rule_4'] = 'TCP_RULE_4',
    ['rule_5'] = 'TCP_RULE_5',
    ['rule_header_1'] = 'TCP_RULE_1T',
    ['rule_header_2'] = 'TCP_RULE_2T',
    ['rule_header_3'] = 'TCP_RULE_3T',
    ['rule_header_4'] = 'TCP_RULE_4T',
    ['rule_header_5'] = 'TCP_RULE_5T',
    ['rules'] = 'Game Rules',
    ['rules_info'] = 'Game rules or anything you should know.'
}

Translations['hu'] = {
    -- notifications
    ['chair_occupied'] = 'Ez a hely foglalt!',
    ['no_react'] = 'Nem reagáltál időben a Díler kérdésére ezért automatikusan bedobtad.',
    ['no_bet_input'] = 'Nem adtál meg tétet!',
    ['not_enough_chips'] = 'Nincs elég chipsed!',
    ['not_enough_chips_next'] = 'Nincs elég chipsed hogy fogadj a Pair Plus-ra, mivel a rendszer úgy érzékelte hogy nem maradna elég chipsed hogy megjátszd a kezed.',
    ['not_enough_chips_third'] = 'Nem tehetsz meg ekkora tétet, mert nem maradna elég chipsed hogy játssz a végjátékban.',
    ['not_enough_chips_toplay'] = 'Nincs elég chipsed hogy játssz!',
    ['already_betted'] = 'Már tettél tétet!',
    ['lose'] = 'Vesztettél!',
    -- formatted notif
    ['dealer_not_qual'] = 'Döntetlen.\nA Díler nem kvalifikált a játékra a kezével.\nVisszakaptál %s chipset!',
    ['dealer_not_qual_ante'] = 'Döntetlen.\nA Díler nem kvalifikált a játékra.\nVisszakaptál %s chipset! (Ante szorzó: x%s)',
    ['player_won_ante'] = 'Nyertél!\nKaptál %s chipset! (Ante szorzó: x%s)',
    ['player_won'] = 'Nyertél!\nKaptál %s chipset.',
    ['pair_won'] = 'Nyertél %s chipset a Pair Plus fogadásoddal. (Pair szorzó: x%s)',
    -- hud
    ['current_bet_input'] = 'TÉT:',
    ['current_player_chips'] = 'CHIPS:',
    ['table_min_max'] = 'MIN/MAX:',
    ['remaining_time'] = 'IDÖ:',
    -- top left
    ['waiting_for_players'] = 'Várakozás a ~b~játékosokra~w~...\n',
    ['clearing_table'] = 'Asztal letakarítása...\n~b~Következö játszma hamarosan kezdetét veszi!\n',
    ['dealer_showing_hand'] = 'A ~r~Díler~w~ mutatja a lapjait!\n',
    ['players_showing_hands'] = 'Játékosok kártyái leleplezése...\n',
    ['dealing_cards'] = 'Kezek leosztása a játékosoknak...\n',
    -- inputs
    ['fold_cards'] = 'Bedob',
    ['play_cards'] = 'Játék',
    ['leave_game'] = 'Játék elhagyása',
    ['raise_bet'] = 'Tét emelése',
    ['reduce_bet'] = 'Tét csökkentése',
    ['custom_bet'] = 'Egyedi tét',
    ['place_bet'] = 'Tét megrakása',
    ['place_pair_bet'] = 'Pair Plus tét megrakása',
    -- gtao ui
    ['tcp'] = '<C>[Aquiver]</C> ~b~Three Card Poker',
    ['sit_down_table'] = '~h~Játék elkezdése',
    ['description'] = 'Játék leírás',
    ['desc_1'] = 'TCP_DIS1', -- this is Rockstar Setuped default, this will automaticly change if you are using german language etc.
    ['desc_2'] = 'TCP_DIS2',
    ['desc_3'] = 'TCP_DIS3',
    ['description_info'] = 'Hogy müködik a játék?',
    ['rule_1'] = 'TCP_RULE_1',
    ['rule_2'] = 'TCP_RULE_2',
    ['rule_3'] = 'TCP_RULE_3',
    ['rule_4'] = 'TCP_RULE_4',
    ['rule_5'] = 'TCP_RULE_5',
    ['rule_header_1'] = 'TCP_RULE_1T',
    ['rule_header_2'] = 'TCP_RULE_2T',
    ['rule_header_3'] = 'TCP_RULE_3T',
    ['rule_header_4'] = 'TCP_RULE_4T',
    ['rule_header_5'] = 'TCP_RULE_5T',
    ['rules'] = 'Játékszabályok',
    ['rules_info'] = 'Játékszabályok és egyéb dolgok amiket tudnod kellhet.'
}
