local ok, res = pcall(main)
if not ok then
   print("\n\nError: "..res, "\n\n")
   return -1
end