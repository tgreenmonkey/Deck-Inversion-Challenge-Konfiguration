----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas({
	key = "invertEnhancers",
	path = "InvertEnhancers.png",
	px = 71,
	py = 95,
})

--Region
local DECK_DATA = {
    {
        name = "Red Deck",
        key = "b_red",
        stake = 8,
        pos = {x = 0, y = 0},
        config = {discards = -1},
        text = {
            "{C:red}-1{} discard",
            "every round",
        },
        unlocked = true,
    },
    {
        name = "Blue Deck",
        key = "b_blue",
        stake = 8,
        pos = {x = 0, y = 2},
        config = {hands = -1},
        text = {
            "{C:blue}-1{} hand",
            "every round",
        },
        unlocked = true,
    },
    {
        name = "Yellow Deck",
        key = "b_yellow",
        stake = 8,
        pos = {x = 1, y = 2},
        config = {dollars = -10},
        text = {
            "Start with",
            "extra {C:money}-$10{}",
        },
        unlocked = true,
    },
    {
        name = "Black Deck",
        key = "b_black",
        stake = 8,
        pos = {x = 3, y = 2},
        config = {
            joker_slot = -1,
            hands = 1
        },
        text = {
            "{C:attention}#1#{} Joker slot",
            "",
            "{C:blue}+1{} hand",
            "every round",
        },
        unlocked = true,
    },
    {
        name = "Painted Deck",
        key = "b_painted",
        stake = 8,
        pos = {x = 4, y = 3},
        config = {
            hand_size = -2,
            joker_slot = 1,
        },
        text = {
            "{C:attention}#1#{} hand size,",
            "{C:red}+#2#{} Joker slot",
        },
        unlocked = true,
    },
    {
        name = "Magic Deck",
        key = "b_magic",
        stake = 8,
        pos = {x = 0, y = 3},
        config = {consumables = {'j_scholar', 'j_scholar'}, banned_keys = {'v_crystal_ball', 'c_fool'}},
        text = {
            "Start run {C:red}without{} the",
            "{C:tarot,T:v_crystal_ball}#1#{} voucher",
            "and {C:attention}2{} copies",
            "of {C:tarot,T:c_fool}#2#",
        },
        unlocked = false,
        unlock_condition = {type = 'region_win', region = '1'},
        apply = function()
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1

                    return true
                end
            }))
        end,
    },
    {
        name = "Nebula Deck",
        key = "b_nebula",
        stake = 8,
        pos = {x = 3, y = 0},
        config = {
            consumeable_slot = 1,
            booster = "p_celestial_normal_1",
            banned_keys = {'v_telescope'}
        },
        text = {
            "{C:red}Never{} receive the planet",
            "for your most played",
            "poker hand in {C:attention,T:p_celestial_normal_1}Celestial Packs{},",
            "but start run with",
            "{C:red}+#2#{} consumable slot",
        },
        unlocked = false,
        unlock_condition = {type = 'region_win', region = '1'},
        apply = function()
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
                    
                    print("MICROSCOPE VOUCHER ACTIVE")
                    G.GAME.microscope_active = true
                    return true
                end
            }))
        end,
    },
    -- 1862 src/utils.lua
    {
        name = "Ghost Deck",
        key = "b_ghost",
        stake = 8,
        pos = {x = 6, y = 2},
        config = {voucher='v_omen_globe', banned_keys = {'c_hex'}},
        text = {
            "{C:spectral}Spectral{} cards may {C:red}not{}",
            "appear in the shop,",
            "start without a {C:spectral,T:c_hex}Hex{} card",
        },
        unlocked = false,
        unlock_condition = {type = 'region_win', region = '1'},
        apply = function()
            G.E_MANAGER:add_event(Event({
                func = function()
                    print("SPECTRAL ACTIVE")
                    G.GAME.spectrals_can_appear = true

                    return true
                end
            }))
        end,
    },
    {
        name = "Checkered Deck",
        key = "b_checkered",
        stake = 8,
        pos = {x = 1, y = 3},
        config = {},
        text = {
            "Start run with",
            "{C:attention}62{C:clubs} Clubs{} and",
            "{C:attention}62{C:diamonds} Diamonds{} in deck",
        },
        unlocked = false,
        unlock_condition = {type = 'region_win', region = '1'},
        apply = function()
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.playing_card = 52
                    local clubs = {}
                    local diamonds = {}
                    for _, card in ipairs(G.playing_cards) do
                        if card.base.suit == 'Clubs' then
                            table.insert(clubs, card)
                        elseif card.base.suit == 'Diamonds' then
                            table.insert(diamonds, card)
                        end
                    end
                    for i = 1, 36 do
                        local random_card = clubs[math.random(#clubs)]
                        G.playing_card = G.playing_card + 1
                        local copied_card = copy_card(random_card, nil, 1, G.playing_card)
                        G.deck:emplace(copied_card)
                        G.playing_cards[G.playing_card] = copied_card
                    end
                    for i = 1, 36 do
                        local random_card = diamonds[math.random(#diamonds)]
                        G.playing_card = G.playing_card + 1
                        local copied_card = copy_card(random_card, nil, 1, G.playing_card)
                        G.deck:emplace(copied_card)
                        G.playing_cards[G.playing_card] = copied_card
                    end
                    return true
                end
            }))
        end,
    },
    {
        name = "Erratic Deck",
        key = "b_erratic",
        stake = 8,
        pos = {x = 2, y = 3},
        config = {},
        text = {
            "All {C:attention}Ranks{} and",
            "{C:attention}Suits{} in deck",
            "are {C:red}un{}randomized",
        },
        unlocked = false,
        unlock_condition = {type = 'region_win', region = '1'},
        apply = function()
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.tarot_rate = math.random(20)
                    G.GAME.planet_rate = math.random(20)
                    G.GAME.joker_rate = math.random(20)
                    G.GAME.spectral_rate = math.random(20)
                    G.GAME.shop.joker_max = math.random(4) + 1
                    
                    print("Tarot Rate: " .. G.GAME.tarot_rate)
                    print("Planet Rate: " .. G.GAME.planet_rate)
                    print("Joker Rate: " .. G.GAME.joker_rate)
                    print("Spectral Rate: " .. G.GAME.spectral_rate)
                    print("Shop Slots: " .. G.GAME.shop.joker_max)

                    return true
                end
            }))
        end,
    },
    {
        name = "Green Deck",
        key = "b_green",
        stake = 8,
        pos = {x = 2, y = 2},
        config = {
            extra_hand_bonus = -2,
            extra_discard_bonus = -1,
            interest = true,
            interest_multiplier = 2
        },
        unlocked = false,
        unlock_condition = {type = 'region_win', region = '2'},
        text = {
            "At end of each Round: ",
            "{C:money}-$1{} per remaining {C:blue}Hand",
            "{C:money}-$2{} per remaining {C:red}Discard",
            "Earn {C:red}double{} {C:attention}Interest",
        },

    },
    {
        name = "Abandoned Deck",
        key = "b_abandoned",
        stake = 8,
        pos = {x = 3, y = 3},
        config = {force_boss = "bl_plant"},
        text = {
            "Start run with",
            "{C:red}only{} {C:attention}Face Cards",
            "in your deck",
        },
        unlocked = false,
        unlock_condition = {type = 'region_win', region = '2'},
        apply = function()
            G.E_MANAGER:add_event(Event({
                func = function()
                    local to_remove = {}
                    for _, card in ipairs(G.playing_cards) do
                        if not (card.base.value == 'Jack' or card.base.value == 'Queen' or card.base.value == 'King') then
                            table.insert(to_remove, card)
                        end
                    end
                    for _, card in ipairs(to_remove) do
                        card:remove()
                    end

                    -- G.FORCE_BOSS = "bl_plant"

                    return true
                end
            }))
        end,
    },
    {
        name = "Zodiac Deck",
        key = "b_zodiac",
        stake = 8,
        pos = {x = 3, y = 4},
        config = {
            consumeable_slot = 2,
            banned_keys = {'v_tarot_merchant', 'v_planet_merchant', 'v_overstock_norm'}
        },
        text = {
            "Start run {C:red}without{}",
            "{C:tarot,T:v_tarot_merchant}#1#{},",
            "{C:planet,T:v_planet_merchant}#2#{},",
            "or {C:attention,T:v_overstock_norm}#3#",
        },
        unlocked = false,
        unlock_condition = {type = 'region_win', region = '2'},
        apply = function()
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.tarot_rate = G.GAME.tarot_rate * (4/9.6)
                    G.GAME.planet_rate = G.GAME.planet_rate * (4/9.6)
                    G.GAME.shop.joker_max = 1

                    return true
                end
            }))
        end,
    },
    {
        name = "Anaglyph Deck", -- Double tag to not double tag lool
        key = "b_anaglyph",
        stake = 8,
        pos = {x = 2, y = 4},
        config = {banned_keys = {'tag_double'}},
        text = {
            "After defeating each",
            "{C:red}not{} {C:attention}Boss Blind{}, gain a",
            "{C:red}not{} {C:attention,T:tag_double}#1#",
        },
        unlocked = false,
        unlock_condition = {type = 'region_win', region = '2'},
    },
    {
        name = "Plasma Deck",
        key = "b_plasma",
        stake = 8,
        pos = {x = 4, y = 2},
        config = {
            ante_scaling = 0.5,
        },
        unlocked = false,
        unlock_condition = {type = 'region_win', region = '2'},
        text = {
            "{C:red}Un{}balance {C:blue}Chips{} and",
            "{C:red}Mult{} when calculating",
            "score for played hand",
            "{C:red}X0.5{} base Blind size",
        },
    },
}


local function register_decks(deck_data)
    for i, deck in ipairs(deck_data) do
        local params = {
            name = deck.name,
            key = deck.key,
            stake = deck.stake,
            atlas = "invertEnhancers",
            pos = deck.pos,
            order = i,
            config = deck.config,
            loc_txt = {
                name = deck.name,
                text = deck.text,
            },
            -- unlocked = deck.unlocked or true,
            -- discovered = false,
        }
        -- only include initial_deck if provided
        if deck.initial_deck then
            params.initial_deck = deck.initial_deck
        end

        if deck.apply then
            params.apply = deck.apply
        end

        if deck.restrictions then
            params.restrictions = deck.restrictions
        end

        if deck.unlocked then
            params.unlocked = deck.unlocked
        end

        if deck.unlock_condition then
            params.unlock_condition = deck.unlock_condition
        end

        if deck.apply_to_run then
            params.apply_to_run = deck.apply_to_run
        end

        SMODS.Back:take_ownership(deck.key, params)
    end
end

register_decks(DECK_DATA)

SMODS.current_mod.config_ta = function()
	return {n = G.UIT.ROOT, config = {
		-- config values here, see 'Building a UI' page
	}, nodes = {
		-- work your UI wizardry here, see 'Building a UI' page
	}}
end

----------------------------------------------
------------MOD CODE END----------------------