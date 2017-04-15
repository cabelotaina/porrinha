
-- Imagens

local background = display.newImageRect ("background.png", 1200, 800)
background.x = display.contentCenterX
background.y = display.contentCenterY

local handJogador1 = display.newImageRect( "hand.png", 112, 112)
handJogador1.x = display.contentCenterX - 350
handJogador1.y = display.contentCenterY

local handJogador2 = display.newImageRect( "hand.png", 112, 112)
handJogador2.x = display.contentCenterX - 100
handJogador2.y = display.contentCenterY

local handJogador3 = display.newImageRect( "hand.png", 112, 112)
handJogador3.x = display.contentCenterX + 150
handJogador3.y = display.contentCenterY

local handJogador4 = display.newImageRect( "handred.png", 112, 112)
handJogador4.x = display.contentCenterX + 400
handJogador4.y = display.contentCenterY

-- Descrição em Texto

local tapText = display.newText(
"Diga qual o número total de palitos \n que você acredita que tem nas mãos",
  display.contentCenterX, 500,
  native.systemFont, 25 )
tapText:setFillColor( 0, 0, 0 )

-- palitos de 0 - 12
local chute = 0
local chuteDisplay = display.newText( chute, 590, 580, native.systemFont, 50 )
chuteDisplay:setFillColor( 0, 0 , 0 )

-- palitos de 0 - 3 (poeNaRoda4) Esta é a quantidade de palitos selecionada pelo jogador 4
local meuspalitos = 3
local quantidadePalitos = display.newText( meuspalitos, 960, 430, native.systemFont, 50 )
quantidadePalitos:setFillColor( 0, 0 , 0 )

-- debug
local poeNaRoda4 = math.random(3)
local  poeNaRoda4Display = display.newText( poeNaRoda4, 960, 100, native.systemFont, 40 )
poeNaRoda4Display:setFillColor( 0, 0 , 0 )

-- palitos jogador1
local palitosJogador1 = 3
local quantidadePalitosJogador1 = display.newText( "Total: " .. palitosJogador1, 200, 200, native.systemFont, 40 )
quantidadePalitosJogador1:setFillColor( 0, 0 , 0 )

-- debug
local  poeNaRoda1 = math.random(3)
local poeNaRoda1Display = display.newText( poeNaRoda1, 200, 100, native.systemFont, 40 )
poeNaRoda1Display:setFillColor( 0, 0 , 0 )

-- palitos jogador2
local palitosJogador2 = 3
local quantidadePalitosJogador2 = display.newText( "Total: " .. palitosJogador2, 450, 200, native.systemFont, 40 )
quantidadePalitosJogador2:setFillColor( 0, 0 , 0 )

-- debug
local poeNaRoda2 = math.random(3)
local poeNaRoda2Display = display.newText( poeNaRoda2, 450, 100, native.systemFont, 40 )
poeNaRoda2Display:setFillColor( 0, 0 , 0 )

-- palitos jogador3
local palitosJogador3 = 3
local quantidadePalitosJogador3 = display.newText( "Total: " .. palitosJogador3, 700, 200, native.systemFont, 40 )
quantidadePalitosJogador3:setFillColor( 0, 0 , 0 )

-- debug
local poeNaRoda3 = math.random(3)
local poeNaRoda3Display = display.newText( poeNaRoda3, 700, 100, native.systemFont, 40 )
poeNaRoda3Display:setFillColor( 0, 0 , 0 )

-- palitos jogador4
local palitosJogador4 = 3
local quantidadePalitosJogador4 = display.newText( "Total: " .. palitosJogador4, 950, 200, native.systemFont, 40 )
quantidadePalitosJogador4:setFillColor( 1, 0 , 0 )

-- botões

local widget = require( "widget" )

-- palitos de 0 - 3

local function incrementaPoeNaRodaJogador4( event )
  if ( "ended" == event.phase ) then
    meuspalitos = meuspalitos + 1
    quantidadePalitos.text = meuspalitos%(palitosJogador4+1)
    poeNaRoda4Display.text = meuspalitos%(palitosJogador4+1)
    print("Quantidade de palitos na variavel meuspalitos: " .. palitosJogador4+1)
  end
end

local function decrementaPoeNaRodaJogador4( event )

    if ( "ended" == event.phase ) then
        meuspalitos = meuspalitos - 1
        quantidadePalitos.text = meuspalitos%(palitosJogador4+1)
        poeNaRoda4Display.text = meuspalitos%(palitosJogador4+1)
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


-- palitos de 0 - 12


local function incrementaChute( event )
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


-- iniciar uma nova jogada

local rodada = 1

-- rodadas

local rodadaLabel = display.newText( "Rodada: " .. rodada, 200, 600, native.systemFont, 40 )
rodadaLabel:setFillColor( 0, 0 , 0 )

local function jogar( event )
    rodada = rodada + 1
    rodadaLabel.text = "Rodada: " .. rodada

    poeNaRoda1 = math.random(palitosJogador1)
    --print("chute jogador 1 total: " .. poeNaRoda1)
    poeNaRoda1Display.text = poeNaRoda1
    poeNaRoda2 = math.random(palitosJogador2)
    poeNaRoda2Display.text = poeNaRoda2
    poeNaRoda3 = math.random(palitosJogador3)
    poeNaRoda3Display.text =  poeNaRoda3
    --poeNaRoda4 = math.random(palitosJogador4)
    --poeNaRoda4Display.text = poeNaRoda4

    -- print("palitos: " .. palitos)
    -- print("Meus Palitos: " .. obterPalitos())
    print("Rodada: " .. rodada)
    if ( "ended" == event.phase ) then

      jogoPalitos(chuteResto(), poeNaRoda1, poeNaRoda2, poeNaRoda3, poeNaRoda4, rodada)
      -- %4 para pegar o valor de zero a quatro
      proximaJogada(poeNaRoda1, poeNaRoda2, poeNaRoda3, poeNaRoda4, palitosJogador1)
      proximaJogada(poeNaRoda1, poeNaRoda2, poeNaRoda3, poeNaRoda4, palitosJogador2)
      proximaJogada(poeNaRoda1, poeNaRoda2, poeNaRoda3, poeNaRoda4, palitosJogador3)

      quantidadePalitosJogador1.text = "Total: " .. palitosJogador1
      quantidadePalitosJogador2.text = "Total: " .. palitosJogador2
      quantidadePalitosJogador3.text = "Total: " .. palitosJogador3

      if palitosJogador1 == 0 then
        native.showAlert( "Joga da Porrinha!!!", "O ganhador foi o jogador 1 :(", { "OK", "Learn More" }, onComplete )
      end
      if palitosJogador2 == 0 then
        native.showAlert( "Joga da Porrinha!!!", "O ganhador foi o jogador 2 :(", { "OK", "Learn More" }, onComplete )
      end
      if palitosJogador3 == 0 then
        native.showAlert( "Joga da Porrinha!!!", "O ganhador foi o jogador 3 :(", { "OK", "Learn More" }, onComplete )
      end
      if palitosJogador4 == 0 then
        native.showAlert( "Joga da Porrinha!!!", "Parabéns campeão você ganhou na porrinha!!!", { "OK", "Learn about corona and Lua" }, onComplete )
      end

    end
end

-- Handler that gets notified when the alert closes
function onComplete( event )
    if ( event.action == "clicked" ) then
        local i = event.index
        if ( i == 1 ) then
          os.exit()
        elseif ( i == 2 ) then
            -- Open URL if "Learn More" (second button) was clicked
            system.openURL( "http://www.coronalabs.com" )
        end
    end
end

obterPalitos = function()
  return meuspalitos % 4
end

chuteResto = function()
  return chute % 13
end

local jogar = widget.newButton(
    {
        left = 900,
        top = 500,
        id = "button5",
        label = "Jogar",
        fontSize = 50,
        onEvent = jogar
    }
)

-- funções de jogo

jogoPalitos = function(chute, _poeNaRoda1, _poeNaRoda2, _poeNaRoda3, _poeNaRoda4, rodada)

 local jogador1, jogador2, jogador3, jogador4

 jogador1 = poeNaRoda1
 jogador2 = poeNaRoda2
 jogador3 = poeNaRoda3
 jogador4 = poeNaRoda4


 quantidadePalitos.text = poeNaRoda4

 local total = jogador1+jogador2+jogador3+jogador4
 --[[ print("Total de palitos na jogada " .. total)
 print("Jogador 1 " .. jogador1)
 print("Jogador 2 " .. jogador2)
 print("jogador 3 " .. jogador3)
 print("jogador 4 (você) " .. jogador4)
 print("Seu chute: " .. chute)
 --if(rodada == 1) then total = total + 4 end
 ]]

 print("Numero de palitos que o jogador 4 pôs na roda: " .. _poeNaRoda4)


 if (chute == total) then
   print("Muito bem")
   palitosJogador4 = palitosJogador4 - 1
   quantidadePalitosJogador4.text = "Total: " .. palitosJogador4
   quantidadePalitos.text = palitosJogador4
   poeNaRoda4Display.text = palitosJogador4
   --print("Quantidade de palitos do jogador 4: " .. palitosJogador4)
 else
   print("Você errou")
 end

end

proximaJogada = function(_poeNaRoda1, _poeNaRoda2, _poeNaRoda3, _poeNaRoda4, jogador)

  jogador1 = _poeNaRoda1
  jogador2 = _poeNaRoda2
  jogador3 = _poeNaRoda3
  jogador4 = _poeNaRoda4

  --print("Numero de palitos que o jogador 4 pôs na roda: " .. _poeNaRoda4)

  local chuteJogador = math.random(12)

  -- if (rodada == 1) then total = total + 4 end

  local total = jogador1 + jogador2 + jogador3 + jogador4

  if (chuteJogador == total) then
    if (jogador == 1 ) then
      palitosJogador1 = palitosJogador1 - 1
      quantidadePalitosJogador1.text = "Total: " .. palitosJogador1
    end
    if (jogador == 2 ) then
      palitosJogador2 = palitosJogador2 - 1
      quantidadePalitosJogador2.text = "Total: " .. palitosJogador2
    end
    if (jogador == 3 ) then
      palitosJogador3 = palitosJogador3 - 1
      quantidadePalitosJogador3.text = "Total: " .. palitosJogador3
    end
  end


end
