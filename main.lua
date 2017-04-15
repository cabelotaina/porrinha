-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Imagens

local background = display.newImageRect ("background.png", 1200, 800)
background.x = display.contentCenterX
background.y = display.contentCenterY

local handJogador1 = display.newImageRect( "hand.png", 112, 112)
handJogador1.x = 200
handJogador1.y = display.contentCenterY

-- palitos jogador1
local palitosJogador1 = 3
local quantidadePalitosJogador1 = display.newText( "Total: " .. palitosJogador1, 200, 200, native.systemFont, 40 )
quantidadePalitosJogador1:setFillColor( 0, 0 , 0 )

-- debug
local  poeNaRoda1 = math.random(3)
local poeNaRoda1Display = display.newText( poeNaRoda1, 200, 100, native.systemFont, 40 )
poeNaRoda1Display:setFillColor( 0, 0 , 0 )

local handJogador2 = display.newImageRect( "hand.png", 112, 112)
handJogador2.x = 400
handJogador2.y = display.contentCenterY

-- palitos jogador2
local palitosJogador2 = 3
local quantidadePalitosJogador2 = display.newText( "Total: " .. palitosJogador2, 400, 200, native.systemFont, 40 )
quantidadePalitosJogador2:setFillColor( 0, 0 , 0 )

-- debug
local poeNaRoda2 = math.random(3)
local poeNaRoda2Display = display.newText( poeNaRoda2, 400, 100, native.systemFont, 40 )
poeNaRoda2Display:setFillColor( 0, 0 , 0 )

local handJogador3 = display.newImageRect( "hand.png", 112, 112)
handJogador3.x = 600
handJogador3.y = display.contentCenterY

-- Apresenta na interface a quantidade de palitos que o jogador 3 possui no inicio do programa (jogo)
local palitosJogador3 = 3
local quantidadePalitosJogador3 = display.newText( "Total: " .. palitosJogador3, 600, 200, native.systemFont, 40 )
quantidadePalitosJogador3:setFillColor( 0, 0 , 0 )

-- Numero de palitos jogados pelo jogador 3 na rodada passada
local poeNaRoda3 = math.random(3)
local poeNaRoda3Display = display.newText( poeNaRoda3, 600, 100, native.systemFont, 40 )
poeNaRoda3Display:setFillColor( 0, 0 , 0 )

local handJogador4 = display.newImageRect( "hand.png", 112, 112)
handJogador4.x = 800
handJogador4.y = display.contentCenterY

-- Apresenta na interface a quantidade de palitos que o jogador 4 possui no inicio do programa (jogo)
local palitosJogador4 = 3
local quantidadePalitosJogador4 = display.newText( "Total: " .. palitosJogador4, 800, 200, native.systemFont, 40 )
quantidadePalitosJogador4:setFillColor( 0, 0 , 0 )

-- Numero de palitos jogados pelo jogador 4 na rodada passada
local poeNaRoda4 = math.random(3)
local poeNaRoda4Display = display.newText( poeNaRoda4, 800, 100, native.systemFont, 40 )
poeNaRoda4Display:setFillColor( 0, 0 , 0 )

local handJogador5 = display.newImageRect( "handred.png", 112, 112)
handJogador5.x = 1000
handJogador5.y = display.contentCenterY

-- numero de palitos do jogador 5

local palitosJogador5 = 3
local quantidadePalitosJogador5 = display.newText( "Total: " .. palitosJogador5, 1000, 200, native.systemFont, 40 )
quantidadePalitosJogador5:setFillColor( 1, 0 , 0 )

-- Chute do jogador 5 na rodada pasada
local poeNaRoda5 = math.random(3)
local  poeNaRoda5Display = display.newText( poeNaRoda5, 1000, 100, native.systemFont, 40 )
poeNaRoda5Display:setFillColor( 0, 0 , 0 )

-- interface para definir o chute do jogador 5
local meuspalitos = 3
local quantidadePalitos = display.newText( meuspalitos, 960, 430, native.systemFont, 50 )
quantidadePalitos:setFillColor( 0, 0 , 0 )

-- Descrição em Texto

-- local tapText = display.newText(
-- "Diga qual o número total de palitos \n que você acredita que tem nas mãos",
--  display.contentCenterX, 500,
--  native.systemFont, 25 )
--tapText:setFillColor( 0, 0, 0 )

-- palitos de 0 - 12
--local chute = 0
--local chuteDisplay = display.newText( chute, 100, 100, native.systemFont, 50 )
--chuteDisplay:setFillColor( 0, 0 , 0 )

-- O widget é necessário para gerar botões na interface

local widget = require( "widget" )

-- Descrição interface:
-- Botão (decrementaPoeNaRodaJogador4button) e funções (incrementaPoeNaRodaJogador4
-- e decrementaPoeNaRodaJogador4) que permitem selecionar o numero de palitos do chute

local function incrementaPoeNaRodaJogador4( event )
  if ( "ended" == event.phase ) then
    meuspalitos = meuspalitos + 1
    quantidadePalitos.text = meuspalitos%(palitosJogador5+1)
    poeNaRoda5Display.text = meuspalitos%(palitosJogador5+1)
    print("Quantidade de palitos na variavel meuspalitos: " .. palitosJogador5+1)
  end
end

local function decrementaPoeNaRodaJogador4( event )

    if ( "ended" == event.phase ) then
        meuspalitos = meuspalitos - 1
        quantidadePalitos.text = meuspalitos%(palitosJogador5+1)
        poeNaRoda5Display.text = meuspalitos%(palitosJogador5+1)
        --print("Quantidade de palitos na variavel meuspalitos: " .. palitosJogador4+1)
    end
end

local incrementaPoeNaRodaJogador4Button = widget.newButton(
    {
        left = 825,
        top = 400,
        fontSize = 50,
        id = "incrementaPoeNaRodaJogador4Button",
        label = "+",
        onEvent = incrementaPoeNaRodaJogador4

    }
)

local decrementaPoeNaRodaJogador4button = widget.newButton(
    {
        left = 925,
        top = 400,
        fontSize = 50,
        id = "decrementaPoeNaRodaJogador4button",
        label = "-",
        onEvent = decrementaPoeNaRodaJogador4
    }
)

-- Interface que permite ao Humano selecionar um valor de chute no jogo com 4 pessoas
-- Botões (incrementaChuteButton e decrementaChuteButton) e etiquetas
-- (incrementaChute e decrementaChute) do jogador 4

--[[local function incrementaChute( event )
  if ( "ended" == event.phase ) then
       chute = chute + 1
       chuteDisplay.text = chute%13
  end
end

local function decrementaChute( event )

    if ( "ended" == event.phase ) then
        chute = chute - 1
        chuteDisplay.text = chute%13
    end
end

local incrementaChuteButton = widget.newButton(
    {
        left = 400,
        top = 550,
        fontSize = 50,
        id = "incrementaChuteButton",
        label = "+",
        onEvent = incrementaChute
    }
)

local decrementaChuteButton = widget.newButton(
    {
        left = 600,
        top = 550,
        fontSize = 50,
        id = "decrementaChuteButton",
        label = "-",
        onEvent = decrementaChute
    }
)
]]--

-- Setando a Rodada inicial

local rodada = 1
local rodadaLabel = display.newText( "Rodada: " .. rodada, 200, 600, native.systemFont, 40 )
rodadaLabel:setFillColor( 0, 0 , 0 )

-- Parte do software contruida pelo Julião que eu integrei

local Jogador = require "Jogador"

local palitos_jogados = {}
local jogadores = {}
local palpites = {}
local n_jogadores = 5
local acertou = 0
local total_palitos = 0
local ganhador = 0

for i = 1, n_jogadores do
	jogadores[i] = Jogador(3)
end

local function gameLoop()
	ganhador = 0
	for i = 1, n_jogadores do
		palitos_jogados[i] = jogadores[i]:jogar()
		palpites[i] = jogadores[i]:palpite()
		total_palitos = total_palitos + palitos_jogados[i]
	end

	for i = 1, n_jogadores do
		if palpites[i] == total_palitos then
			acertou = i
		end
	end

	if acertou ~= 0 then
		print("Jogador " .. acertou .. " acertou")
		jogadores[acertou]:decPalitos()
	else
		print("Ninguém acertou")
	end

	print("Total palitos: " .. total_palitos)
	print("Random: " .. math.random(0, 3))

	for i = 1, n_jogadores do
		local palitos = jogadores[i]:getPalitos()
		if palitos == 0 then
			print("O Jogador " .. i .. " ganhou")
			ganhador = i
			--timer.cancel(gameLoopTimer)
		end
	end

	-- atualiza os valores de chute nas jogadas passadas
	poeNaRoda1Display.text = tostring(palitos_jogados[1])
	poeNaRoda2Display.text = tostring(palitos_jogados[2])
	poeNaRoda3Display.text = tostring(palitos_jogados[3])
	poeNaRoda4Display.text = tostring(palitos_jogados[4])
	poeNaRoda5Display.text = tostring(palitos_jogados[5])

	quantidadePalitosJogador1.text = tostring( "Total: " .. jogadores[1]["palitos"] )
	quantidadePalitosJogador2.text = tostring( "Total: " .. jogadores[2]["palitos"] )
	quantidadePalitosJogador3.text = tostring( "Total: " .. jogadores[3]["palitos"] )
	quantidadePalitosJogador4.text = tostring( "Total: " .. jogadores[4]["palitos"] )
	quantidadePalitosJogador5.text = tostring( "Total: " .. jogadores[5]["palitos"] )

	total_palitos = 0
	acertou = 0

	print("palitos Jogados")
	print_r(palitos_jogados)
	print("Jogadores")
	print_r(jogadores)
end


--gameLoopTimer = timer.performWithDelay(1000, gameLoop, 0)

-- botão que chama a função de jogoPalitos
local jogar = widget.newButton(
    {
        left = 900,
        top = 500,
        id = "jogar",
        label = "Jogar",
        fontSize = 50,
        onEvent = gameLoop
    }
)


function print_r ( t )
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end
