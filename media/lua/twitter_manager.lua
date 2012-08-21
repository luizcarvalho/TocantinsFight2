dofile("xml_load_tweets.lua")
dofile("manoel/utils.lua")
		print("Load Tweets")

tweets = {}
total_tweets = 0
index = 1
function reload_tweets()
	tweets = load_tweets()
	total= #tweets
	index = 1
end

reload_tweets()

--[[
	local ok, res = pcall(breakString(tweets[1]["texto"], 100))
	if not ok then
	   print("\n\nError: "..res, "\n\n")
	   return -1
	end
--]]

function proximoTweet()
	local index =  changeTweet(true)
	print("RETURNED INDEX: "..index)	
	showTweet(tweets[index])	
end

function anteriorTweet()
	local index = changeTweet(false)	
	showTweet(tweets[index])
end

function changeTweet(proximo)
  if proximo then
  	 index = index + 1
  	 print("proximo "..index)
  	 print("index "..index..">"..total)
  	 if index > total then
  	 	print("SIM")
  	    index = 1
  	 end
  else
  	 index = index - 1
  	 print("anterior "..index)
  	 print("index "..index.."<="..total)
  	 if index <= 0 then
  	 	print("SIM")
  	    index = total
  	 end;
  end
  print("RETURN: "..index)
  return index
end 

function showTweet(tweet)
 print("Load char size")
 local th = 14
 local y=10
 canvas:clear();
 --local tw, th = canvas:measureText("a")

	print("Draw field")
	canvas:attrColor(0,0,0,255)
	local largura,altura = canvas:attrSize()
	canvas:drawRect("fill",0,0,largura,altura)
	print("Draw NICK")
	--NICK
	

	--TWEETS
		print("Draw Tweet")
    canvas:attrColor(0,255,238,255)	
	local texto = breakString(tweet.texto)
	canvas:attrFont("vera",18)	
	canvas:attrColor(0,255,238,255)	
	for k,ln in pairs(texto) do
      canvas:drawText(10, y, ln)
      y = y + th + 4
  	end
	canvas:attrColor(255,255,255,255)
	canvas:drawText(largura-200, altura-30, "por".." "..tweet.nome)
	local controllers = canvas:new("../images/control.png")
	canvas:compose(1,altura-30,controllers)
	
	canvas:flush();
end


function handler(evt)	
	for key,value in pairs(evt) do
		print(key,"=",value)
	end 
	  if (evt.class == 'key' and evt.type == 'press') then
		  if evt.key == "CURSOR_RIGHT" then
		  print("Proximo Tweet")
	     	proximoTweet()
	elseif evt.key == "BLUE" then
		  print("RELOAD....")
		     	reload_tweets()
		     	showTweet(tweets[index])	  	     	
	  elseif evt.key == "CURSOR_LEFT" then
	  print("Tweet Anterior")
	     	anteriorTweet()
	  end
	
	
	elseif(evt.class=="ncl" and evt.type=="presentation" and evt.action=="start") then
		print("Show Tweets")
		showTweet(tweets[index])
	end
end	




event.register(handler)