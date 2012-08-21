dofile("luaxml/xml.lua")
dofile("luaxml/handler.lua")
print("XML LOAD TWEET - INITIALIZING...")

function load_tweets()
print("Tweets")
	local tweets = {}

	local filename = "../data/tweets.xml"
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
	
	for k,p in pairs(xmlhandler.root.tweets.tweet) do
	print("Carregando...")
		local tweet = {}
		tweet["nome"] = p.nome
		tweet["texto"] = p.texto
		table.insert(tweets, tweet)
	end
	
	return tweets
end
