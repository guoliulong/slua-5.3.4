require('LuaXml')

-- load XML data from file "test.xml" into local table xfile
local xfile = xml.load("test.xml")
-- search for substatement having the tag "scene"
local cdata = xfile:find("scene")
-- if this substatement is found…
if cdata ~= nil then
  --  …print it to screen
  --print(xscene)
  --  print  tag, attribute id and first substatement
  print( cdata.text, cdata.id, cdata[1] )
  
  for k,v in pairs(cdata[1]) do
	print(k,v)
  end
  
  
end

xfile:save"t.xml"
print("---\nREADY.")