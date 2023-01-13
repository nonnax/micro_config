#!/usr/bin/env -S lua
-- Id$ nonnax 2022-09-05 21:22:42
pl=require 'pl'
pp=require 'pl.pretty'
function enclose(t, fn)
  s="<"..t..">"
  s=s..tostring(fn())
  s=s.."</"..t..">\n"
  return s
end

res=enclose('div', function()
 return 'this is the content'
end)

print(res)
pp(pl)
