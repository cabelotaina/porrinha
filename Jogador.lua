local Jogador = {}
Jogador.__index = Jogador

setmetatable(Jogador, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Jogador.new(palitos)
  local self = setmetatable({}, Jogador)
  self.palitos = palitos
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
  return math.random(0, self.palitos)
end

function Jogador:palpite()
  return math.random(0, 10)
end

function Jogador:decPalitos()
  self.palitos = self.palitos - 1
end

return Jogador