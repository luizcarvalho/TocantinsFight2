dofile("xml_load_tweets.lua")
dofile("manoel/utils.lua")
		print("Load Tweets")
tweets = load_tweets()

--[[
	local ok, res = pcall(breakString(tweets[1]["texto"], 100))
	if not ok then
	   print("\n\nError: "..res, "\n\n")
	   return -1
	end
--]]

function proximoTweet(total,index)
	return changeTweet(total, index, true)
end

function proximoTweet(total,index)
	return changeTweet(total, index, false)
end

function changeTweet(total, index, proximo)
  if proximo then
  	 index = index + 1
  	 if index > total then
  	    index = 1
  	 end
  else
  	 index = index - 1
  	 if index <= 0 then
  	    index = total
  	 end;
  end
  return index
end 

function showTweet(tweet)
 print("Load char size")
 local th = 14
 local y=10
 --local tw, th = canvas:measureText("a")

	print("Draw field")
	canvas:attrColor(0,0,0,255)
	local largura,altura = canvas:attrSize()
	canvas:drawRect("fill",0,0,largura,altura)
print("Draw NICK")
	--NICK
	--canvas:attrColor(255,255,255,255)
	--canvas:drawText(10, y, tweet.nome)
	--y = y + th + 4
	
	--TWEETS
		print("Draw Tweet")
    canvas:attrColor(0,255,238,255)	
	local texto = breakString(tweet.texto,30)
	canvas:attrFont("vera",18)	
	canvas:attrColor(0,255,238,255)	
	for k,ln in pairs(texto) do
      canvas:drawText(10, y, ln)
      y = y + th + 4
  	end

	
	canvas:flush();
end


function handler(evt)	
 print("Carregando Tweets")
	if(evt.class=="ncl" and evt.type=="presentation" and evt.action=="start") then
		print("Show Tweets")
		showTweet(tweets[1])
	end
end	




event.register(handler)