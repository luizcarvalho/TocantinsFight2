dofile("luaxml/xml.lua")
dofile("luaxml/handler.lua")

function load_grid()
	local grid = {}

	local filename = "../data/grid.xml"
	local xmltext=""
	print("XML LOADED")
	-- e é o erro
	local f,e = io.open(filename,"r")
	
	if f then
		-- lê todo o conteúdo do arquivo
		-- *a = all (todo o arquivo)
		xmltext=f:read("*a")
	else
		error(e)
	end
	
	-- Instancia o objeto que é responsável por armazenas o XML em forma de tabela lua
	local xmlhandler = simpleTreeHandler()
	
	-- xmltext é a string contendo o código XML
	local xmlparser = xmlParser(xmlhandler)
	-- aqui que a conversao do XML para table esta sendo feita de fato
	xmlparser:parse(xmltext)
	
	-- Xmlhandler.root é a raiz do XML
	
	-- Imprime a tabela recursivamente automaticamente
	--printable(xmlhandler.root)
	
	
	for k,p in pairs(xmlhandler.root.lutas.luta) do
	print("Carregando Luta")
		local luta = {}
		luta["contador"] = p.contador
		luta["lutador1"] = p.lutador1
		luta["lutador2"]= p.lutador2
		luta["horario"] = p.horario
		table.insert(grid, luta)
	end
	print(grid)
	return grid
end

--[[
function load_grid()

	local ok, res = pcall(load_xml)
	if not ok then
	   print("\n\n",res, "\n\n")
	   return -1
	end
	return res

end
--]]
	--[[
	for k,p in pairs(xmlhandler.root.lutas.luta) do
		print("Lutador 1: ",p.lutador1)
		print("Lutador 2: ",p.lutador2)
		print("Horario: ",p.horario)
		print ""
	end
	--]]


