#!/usr/bin/env ruby
# Id$ nonnax 2021-11-02 19:11:52 +0800
lines=$stdin.read

puts lines.gsub(/\n{2}/,"\n")
# puts lines.split(/(?=\n{2,})/).map{|l|
  # p l
  # # l.gsub(/\n{2}/,"\n")
# }.join
