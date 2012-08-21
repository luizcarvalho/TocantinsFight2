dofile("xml_load_grid.lua")

-- ginga --ncl  RUN /misc/ncl30/TocantinsFight/main.ncl  
local largura_canvas,altura_canvas = canvas:attrSize()
global_middle = largura_canvas/2 -- meio da tela
global_space = 1 -- espaço entre cada componente
global_header_altura = 0 -- altura da imagem do header

-- método responsável por carregar o Header do Campeonato
function load_header()
	local header = canvas:new("../images/header.png")
	--centralizar
	local largura_header,altura_header = header:attrSize()
	
	local x_header = global_middle-largura_header/2 -- posicionar o Header no centro da tela
	local y_header = 0 --esquerda
	global_header_altura = altura_header	--pega o tamanho Y do Header
	canvas:compose(x_header,y_header,header) -- cerrega a imagem no canvas
end

function write_names(x_luta,y_luta,altura_luta,largura_luta,lutador_esquerda,lutador_direita,horario)
	canvas:attrFont("vera",24)	
	canvas:attrColor(255,255,255,255)
	local ajuste = 40
	local largText, altText = canvas:measureText(lutador_direita)
	local x_l1 = x_luta+ajuste
	local y = y_luta+(altura_luta/2)-(altText)
	local x_l2 = x_luta+largura_luta-ajuste-largText
	local hy = y+40
	local hx = x_luta+(largura_luta/2)-22
	
	
	canvas:drawText(x_l1,y,lutador_esquerda)
	canvas:drawText(x_l2,y,lutador_direita)
	canvas:attrFont("vera",18)
	canvas:drawText(hx,hy,horario)
end


-- Método responsável por carregar cada luta do campeonato
--@POSICAO: posição na ordem de exibição de cima para baixo da luta
--@lutador_esquerda: String - Nome do lutador da Esquerda
--@lutador_direita: String - Nome do Lutador da Direita
--@horario - String - Horário de exibição da luta
function load_luta(posicao,lutador_esquerda,lutador_direita,horario)
	local luta_base = canvas:new("../images/luta.png")
	local largura_luta,altura_luta = luta_base:attrSize()
	local x_luta = global_middle-largura_luta/2
	local y_luta  = posicao*global_space+posicao*altura_luta
	print("DRAW LUTA AREA")
	canvas:compose(x_luta,y_luta,luta_base)
	write_names(x_luta,y_luta,altura_luta,largura_luta,lutador_esquerda,lutador_direita,horario);
		
end





function show_grid()
	local grid = load_grid();	local largura,altura = canvas:attrSize()
	load_header()
	print("XMLH: ",grid)
	for k,p in pairs(grid) do
	load_luta(p.contador,p.lutador1,p.lutador2,p.horario)
	--load_luta(1,"Luiz Carvalho","Anderson Silva","08:00")
	--load_luta(2,"Barão","Mike Taison","09:00")
	--load_luta(3,"Evander Hollifield","Vicktor Belford","10:00")
	--load_luta(4,"Marcos","Belucci","11:00")
	end
	canvas:flush();
end


function remove_grid()
	canvas:clear();
end



function handler(evt)	
	--[
print("CLASS: ",evt.class,"; TYPE: ",evt.type,"ACTION: ",evt.action)
	if(evt.class=="ncl" and evt.type=="presentation" and evt.action=="start") then
		show_grid()
	end
	--]]
end	




event.register(handler)