local Jogador = {}
Jogador.__index = Jogador

setmetatable(Jogador, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Jogador.new(id, palitos, random)
  local self = setmetatable({}, Jogador)
  self.id = id
  self.palitos = palitos
  self.random = random
  return self
end

-- the : syntax here causes a "self" arg to be implicitly added before any other args
function Jogador:setPalitos(palitos)
  self.palitos = palitos
end

function Jogador:getPalitos()
  return self.palitos
end

function Jogador:jogar()
  self.palitos_jogados = math.random(0, self.palitos)

  return self.palitos_jogados
end

function Jogador:palpite(palpites, max_palitos_jogadores)
  -- Artigo sobre a distribuição de probabilidades do jogo:
  -- https://periodicos.unifap.br/index.php/estacao/article/download/1322/paulov4n1.pdf
  -- Basicamente significa que um jogador pode jogar um valor médio e ter maiores chances de acertar.

  print("Palitos jogados (self.palitos_jogados): " .. self.palitos_jogados)
  local meu_palpite = 0
  local min_palitos_jogadores = Ordered()
  local total_max_palitos = 0
  for i = 1, #max_palitos_jogadores do
    total_max_palitos = total_max_palitos + max_palitos_jogadores[i]
  end

  -- Se a estratégia do jogador for RANDOM ou IA
  if self.random then
    meu_palpite = calcValorDistinto(0, total_max_palitos, palpites)
  else
    for id, palpite in palpites:opairs() do
      local total_palitos_demais_jogadores = total_max_palitos - max_palitos_jogadores[id]
      -- Se o palpite de um jogador é maior do que a soma do valor máximo de palitos dos demais jogadores,
      -- significa que a diferença é a quantidade mínima de palitos que o jogador jogou na rodada.
      if palpite > total_palitos_demais_jogadores then
        min_palitos_jogadores[id] = palpite - total_palitos_demais_jogadores
      else
        min_palitos_jogadores[id] = 0
      end
    end
    print("**********")

    local total_min_palitos = 0
    for id, min_palitos in min_palitos_jogadores:opairs() do
      total_min_palitos = total_min_palitos + min_palitos
    end
    total_min_palitos = total_min_palitos + self.palitos_jogados
    print("total_min_palitos = " .. total_min_palitos)
    print("total_max_palitos = " .. total_max_palitos)

    -- Faz o jogador dar um palpite que ninguém tenha dado ainda
    local palpite_distinto = false

    if total_min_palitos < (total_max_palitos/3) then
      total_min_palitos = math.ceil(total_min_palitos + total_max_palitos/#max_palitos_jogadores)
      total_max_palitos = math.ceil(total_max_palitos - total_max_palitos/#max_palitos_jogadores)
    end
    print("total_min_palitos (new) = " .. total_min_palitos)
    print("total_max_palitos (new) = " .. total_max_palitos)

    meu_palpite = calcValorDistinto(total_min_palitos, total_max_palitos, palpites)
  end

  return meu_palpite
end

function Jogador:decPalitos()
  self.palitos = self.palitos - 1
end

function calcValorDistinto(min, max, palpites)
  local meu_palpite = 0
  local palpite_distinto = false

  --while true do  -- bloqueia o corona sdk se for ativado
  for i = 1, max*10 do
    meu_palpite = math.random(min, max)
    for id, palpite in palpites:opairs() do
      if meu_palpite ~= palpite then
        palpite_distinto = true
      else
        palpite_distinto = false
        break
      end
    end
    if palpite_distinto then
      break
    end
  end

  return meu_palpite
end

return Jogador