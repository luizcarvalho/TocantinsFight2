
---Quebra uma string para que a mesma tenha linhas
--com um comprimento máximo definido, não quebrando
--a mesma no meio das palavras.
--@param str String a ser quebrada
--@param maxLineSize Quantidade máxima de caracteres por linha
--@returns Retorna uma tabela onde cada item é uma linha
--da string quebrada.
function breakString(str)
maxLineSize = 50
print("1 -Beacking lines")
  local t = {}
  local i, fim, countLns = 1, 0, 0
	print("Se não ouver string")
  if (str == nil) or (str == "") then
     return t
  end
	print("2  -Retira Scapes")
  str = string.gsub(str, "\n", " ")
  str = string.gsub(str, "\r", " ")
  print("3 -Enquanto i < str")  
  while i < #str do
     countLns = countLns + 1
       print("4 - se i > #str")  
     if i > #str then
        t[countLns] = str
        i = #str
        
     else
     print("5 - se não")
        fim = i+maxLineSize-1
        if fim > #str then
           fim = #str
        else
--se o caracter onde a string deve ser quebrada
--não for um espaço, procura o próximo espaço
print("6 - procura proximo espaco")
if string.byte(str, fim) ~= 32 then
fim = string.find(str, ' ', fim)
if fim == nil then
fim = #str
end
end
        end
        t[countLns]=string.sub(str, i, fim)
        i=fim+1
     end
  end
  print("7 -Retorna")
  return t
end