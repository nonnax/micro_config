#!/usr/bin/env ruby
# Id$ nonnax 2021-11-02 19:11:52 +0800
while s=gets
  print ( (/^#/).match(s) ? s : s.gsub(/([\.\?\!]+)(?=[^'"])\s*/){|m| "#{m.strip}\n" } )
end
