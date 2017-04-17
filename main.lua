-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
require("Ordered")
local Jogador = require("Jogador")
local widget = require("widget")  -- O widget é necessário para gerar botões na interface

local n_jogadores = 5
local jogador_humano = false
local id_jogador_humano = 1
local jogadores = nil
local palitos_max = 3
local palitos_humano = 0
local palpite_humano = 0
local jogador_venceu = {}
local partida = 0

local background = display.newImageRect ("background.png", 1200, 800)
background.x = display.contentCenterX
background.y = display.contentCenterY

local ui_nova_partida = nil
local ui_distancia = 220
local ui_label = {}
local ui_jogador_img = {}
local ui_jogador_qtd_palitos = {}
local ui_palitos_jogados = {}  -- debug
local ui_palpite = {}
local ui_resultado = nil
local ui_rodada = nil
local ui_palitos_humano = nil
local ui_palpite_humano = nil
local ui_palitos_label = nil
local ui_palpite_label = nil
local ui_jogar = nil
local ui_incrementa_palitos_humano = nil
local ui_decrementa_palitos_humano = nil
local ui_incrementa_palpite_humano = nil
local ui_decrementa_palpite_humano = nil

-- Retorna um vetor com o número máximo atual de palitos de cada jogador
function getMaxPalitosJogadores()
  local max_palitos = {}
  for i = 1, n_jogadores do
    max_palitos[i] = jogadores[i]:getPalitos()
  end

  return max_palitos
end

-- Retorna um vetor com o número máximo atual de palitos de cada jogador
function getMaxPalitosTotal()
  local max_palitos_jogadores = getMaxPalitosJogadores()
  local total_max_palitos = 0

  for id = 1, #max_palitos_jogadores do
    total_max_palitos = total_max_palitos + max_palitos_jogadores[id]
  end

  return total_max_palitos
end

function atualizarControlesHumanos()
  print("Atualizando Ui, jogador_humano: " ..  tostring(jogador_humano))
  ui_jogar:setEnabled(jogador_humano)
  ui_incrementa_palitos_humano:setEnabled(jogador_humano)
  ui_decrementa_palitos_humano:setEnabled(jogador_humano)
  ui_incrementa_palpite_humano:setEnabled(jogador_humano)
  ui_decrementa_palpite_humano:setEnabled(jogador_humano)
end

local function ativarJogadorHumano(event)
    local switch = event.target
    jogador_humano = switch.isOn
    atualizarControlesHumanos()

    -- Iniciar nova partida
    local nova_partida_event = event
    nova_partida_event.phase = "ended"
    novaPartida(nova_partida_event)
end

local function incrementaPalitosHumano(event)
  if "ended" == event.phase then
    if (palitos_humano + 1) <= jogadores[id_jogador_humano]:getPalitos() then
      palitos_humano = palitos_humano + 1
      ui_palitos_humano.text = palitos_humano
    end
  end
end

local function decrementaPalitosHumano(event)
    if "ended" == event.phase then
      if (palitos_humano - 1) >= 0 then
          palitos_humano = palitos_humano - 1
          ui_palitos_humano.text = palitos_humano
        end
    end
end

local function incrementaPalpiteHumano(event)
  if "ended" == event.phase then
    if (palpite_humano + 1) <= getMaxPalitosTotal() then
      palpite_humano = palpite_humano + 1
      ui_palpite_humano.text = palpite_humano
    end
  end
end

local function decrementaPalpiteHumano(event)
    if "ended" == event.phase then
      if (palpite_humano - 1) >= 0 then
          palpite_humano = palpite_humano - 1
          ui_palpite_humano.text = palpite_humano
        end
    end
end

local function jogarHumano(event)
  if "ended" == event.phase then
    timer.resume(rodadaTimer)
  end
end

function inicializarUi()
  for id = 1, n_jogadores do
    -- Inicializa a quantidade de partidas vencidas por cada jogador
    jogador_venceu[id] = 0

    local imagem = "hand.png"
    local cor_vermelho = 0
    if jogador_humano and id == 1 then
      imagem = "handred.png"
      cor_vermelho = 1
    end

    -- Apresenta na interface a imagem de uma mão para cada jogador
    ui_jogador_img[id] = display.newImageRect(imagem, 112, 112)
    ui_jogador_img[id].x = id * ui_distancia
    ui_jogador_img[id].y = display.contentCenterY

      -- Apresenta na interface o nome do jogador no formato J1, J2, etc.
    ui_label[id] = display.newText("J" .. id, id * ui_distancia, 60, native.systemFontBold, 40)
    ui_label[id]:setFillColor(cor_vermelho, 0, 0)

    -- Apresenta na interface a quantidade de palitos que cada jogador possui no inicio do programa (jogo)
    ui_jogador_qtd_palitos[id] = display.newText("Total: 3", id * ui_distancia, 130, native.systemFont, 40)
    ui_jogador_qtd_palitos[id]:setFillColor(cor_vermelho, 0, 0)

    -- Palitos jogados por cada jogador, apenas para conferência -- debug
    ui_palitos_jogados[id] = display.newText("Jogou: -", id * ui_distancia, 190, native.systemFont, 40)
    ui_palitos_jogados[id]:setFillColor(cor_vermelho, 0, 0)

    -- Palpites jogados por cada jogador
    ui_palpite[id] = display.newText("Palpite: -", id * ui_distancia, 250, native.systemFont, 40)
    ui_palpite[id]:setFillColor(cor_vermelho, 0, 0)
  end

  ui_rodada = display.newText("Rodada: 0", ui_distancia, 680, native.systemFont, 40)
  ui_rodada:setFillColor(0, 0, 0)

  ui_resultado = display.newText("Clique para iniciar um novo jogo", 950, 680, native.systemFont, 40)
  ui_resultado:setFillColor(0, 0, 0)

  ui_incrementa_palitos_humano = widget.newButton(
      {
          left = 225,
          top = 420,
          fontSize = 50,
          id = "incrementaPalitosHumano",
          label = "+",
          onEvent = incrementaPalitosHumano
      }
  )

  ui_decrementa_palitos_humano = widget.newButton(
      {
          left = 115,
          top = 420,
          fontSize = 50,
          id = "decrementaPalitosHumano",
          label = "-",
          onEvent = decrementaPalitosHumano
      }
  )

  ui_palitos_label = display.newText("Palitos: ", 125, 450, native.systemFont, 40)
  ui_palitos_label:setFillColor(0, 0, 0)

  -- Número de palitos que o humano jogará
  ui_palitos_humano = display.newText(palitos_humano, 260, 450, native.systemFont, 50)
  ui_palitos_humano:setFillColor(0, 0, 0)

  ui_incrementa_palpite_humano = widget.newButton(
      {
          left = 225,
          top = 495,
          fontSize = 50,
          id = "incrementaPalpiteHumano",
          label = "+",
          onEvent = incrementaPalpiteHumano
      }
  )

  ui_decrementa_palpite_humano = widget.newButton(
      {
          left = 115,
          top = 495,
          fontSize = 50,
          id = "decrementaPalpiteHumano",
          label = "-",
          onEvent = decrementaPalpiteHumano
      }
  )

  ui_palpite_label = display.newText("Palpite: ", 125, 520, native.systemFont, 40)
  ui_palpite_label:setFillColor(0, 0, 0)

  -- Palpite que o humano jogará
  ui_palpite_humano = display.newText(palpite_humano, 260, 520, native.systemFont, 50)
  ui_palpite_humano:setFillColor(0, 0, 0)

  -- botão que chama a função de jogoPalitos
  ui_jogar = widget.newButton(
      {
          left = 120,
          top = 575,
          id = "jogar",
          label = "Jogar",
          fontSize = 40,
          onEvent = jogarHumano,
          emboss = false,
          -- Properties for a rounded rectangle button
          shape = "roundedRect",
          width = 210,
          height = 70,
          cornerRadius = 2,
          labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
          fillColor = { default={0.5,0.5,0.5,1}, over={0,0.1,0.7,0.4} },
          strokeColor = { default={0,0.4,0,1}, over={0.8,0.8,1,1} },
          strokeWidth = 4
      }
  )

  local ui_ativar_humano = widget.newSwitch(
      {
          left = 730,
          top = 460,
          style = "checkbox",
          id = "ui_ativar_humano",
          width = 70,
          height = 70,
          onPress = ativarJogadorHumano
      }
  )

  ui_ativar_humano_label = display.newText("Ativar jogador humano", 1010, 500, native.systemFont, 40)
  ui_ativar_humano_label:setFillColor(0, 0, 0)
end

function resetUi()
  ui_resultado:setFillColor(0, 0, 0)
  for id = 1, n_jogadores do
    ui_palitos_humano.text = 0
    ui_palpite_humano.text = 0
    ui_label[id].text = "J" .. id
    ui_jogador_qtd_palitos[id].text = "Total: 3"
    ui_palitos_jogados[id].text = "Jogou: -1"
    ui_palpite[id].text = "Palpite: -1"

    local imagem = "hand.png"
    local cor_vermelho = 0
    if jogador_humano and id == 1 then
      imagem = "handred.png"
      cor_vermelho = 1
    end

    ui_jogador_img[id] = display.newImageRect(imagem, 112, 112)
    ui_jogador_img[id].x = id * ui_distancia
    ui_jogador_img[id].y = display.contentCenterY

    ui_label[id]:setFillColor(cor_vermelho, 0, 0)
    ui_jogador_qtd_palitos[id]:setFillColor(cor_vermelho, 0, 0)
    ui_palitos_jogados[id]:setFillColor(cor_vermelho, 0, 0)
    ui_palpite[id]:setFillColor(cor_vermelho, 0, 0)
  end

  -- Desabilita o botão de nova partida para não ocorrerem erros se alguém clicar no meio de uma partida
  ui_nova_partida:setEnabled(false)
end

inicializarUi()
atualizarControlesHumanos()

function novaPartida(event)
  if "ended" == event.phase then
    partida = partida + 1
    print("Iniciando nova partida #" .. partida)
    resetUi()
    local palitos_jogados = {}
    jogadores = {}
    local palpites = Ordered()
    local jogador_acertou = 0
    local total_palitos = 0
    local ganhador = 0
    local primeiro_jogador = 1
    local rodadas = 0
    palitos_humano = 0
    palpite_humano = 0

    -- Inicializa jogadores com o id e o número máximo de palitos
    for id = 1, n_jogadores do
      -- O último jogador usará IA, os demais serão RANDOM
      if id == n_jogadores then
        jogadores[id] = Jogador(id, palitos_max, false)
      else
        jogadores[id] = Jogador(id, palitos_max, true)
      end
    end


    function updateUi()
      palitos_humano = 0
      palpite_humano = 0
      ui_palitos_humano.text = 0
      ui_palpite_humano.text = 0
      ui_rodada.text = "Rodada: " .. tostring(rodadas)
      for id = 1, n_jogadores do
        ui_jogador_qtd_palitos[id].text = "Total: " .. tostring(jogadores[id]:getPalitos())
        ui_palitos_jogados[id].text = "Jogou: " .. tostring(palitos_jogados[id])
        ui_palpite[id].text = "Palpite: " .. tostring(palpites[id])
      end
    end

    -- Executa uma rodada do jogo
    function rodadaLoop()
      rodadas = rodadas + 1
      ganhador = 0

      --print("Primeiro a jogar: Jogador " .. primeiro_jogador)

      -- Os jogadores selecionam seus palitos e fazem suas apostas (palpites)
      -- Os dois for's simulam uma lista circular que inicia no primeiro_jogador da rodada
      for i = primeiro_jogador, n_jogadores do
        if jogador_humano and i == id_jogador_humano then
          palitos_jogados[i] = palitos_humano
          palpites[i] = palpite_humano
        else
          palitos_jogados[i] = jogadores[i]:jogar()
          palpites[i] = jogadores[i]:palpite(palpites, getMaxPalitosJogadores())
        end
        --print("Palitos jogados: " .. palitos_jogados[i])
        --print("Palpite: " .. palpites[i])
        total_palitos = total_palitos + palitos_jogados[i]
      end
      for i = 1, primeiro_jogador do
        if jogador_humano and i == id_jogador_humano then
          palitos_jogados[i] = palitos_humano
          palpites[i] = palpite_humano
        else
          palitos_jogados[i] = jogadores[i]:jogar()
          palpites[i] = jogadores[i]:palpite(palpites, getMaxPalitosJogadores())
        end
        --print("Palitos jogados: " .. palitos_jogados[i])
        --print("Palpite: " .. palpites[i])
        total_palitos = total_palitos + palitos_jogados[i]
      end
      --print("----------------------------")

      -- Verifica se algum jogador acertou a quantidade total de palitos
      for i = 1, n_jogadores do
        if palpites[i] == total_palitos then
          jogador_acertou = i
        end
      end

      -- Se alguém acertou, decrementa 1 palito e ele inicia a próxima rodada
      if jogador_acertou ~= 0 then
        ui_resultado.text = "O Jogador " .. jogador_acertou .. " acertou"
        jogadores[jogador_acertou]:decPalitos()
        primeiro_jogador = jogador_acertou
      else
        ui_resultado.text = "Ninguém acertou"
      end

      updateUi()

      -- Verifica se algum jogador venceu o jogo
      for id = 1, n_jogadores do
        local palitos = jogadores[id]:getPalitos()
        if palitos == 0 then
          updateUi()
          ui_resultado.text = "O Jogador " .. id .. " ganhou"
          ui_resultado:setFillColor(1, 0, 0)
          ganhador = id
          timer.cancel(rodadaTimer)
          print("---------- Resumo das partidas ----------")
          jogador_venceu[id] = jogador_venceu[id] + 1
          for i = 1, #jogador_venceu do
            print("O Jogador " .. i .. " venceu: " .. jogador_venceu[i] .. " partidas até agora")
          end
          print("-----------------------------------------")

          -- Reabilita o botão de nova partida
          ui_nova_partida:setEnabled(true)
        end
      end

      -- Reinicializa as variáveis para a próxima rodada
      total_palitos = 0
      jogador_acertou = 0
      palpites = Ordered()

      if jogador_humano then
        timer.pause(rodadaTimer)
      end
    end

    -- Repete cada rodada até que alguém ganhe
    if not jogador_humano then
      rodadaTimer = timer.performWithDelay(50, rodadaLoop, 0)
    else
      rodadaTimer = timer.performWithDelay(50, rodadaLoop, 0)
      timer.pause(rodadaTimer)
    end
  end
end

-- Botão que inicia uma nova partida
ui_nova_partida = widget.newButton(
    {
        left = 730,
        top = 550,
        id = "jogar",
        label = "Nova Partida",
        fontSize = 50,
        onEvent = novaPartida,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 480,
        height = 70,
        cornerRadius = 2,
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        fillColor = { default={0,0,0,1}, over={0,0.1,0.7,0.4} },
        strokeColor = { default={0,0.4,0,1}, over={0.8,0.8,1,1} },
        strokeWidth = 4
    }
)
