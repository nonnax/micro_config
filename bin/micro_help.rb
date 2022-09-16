#!/usr/bin/env -S ruby --disable=gems
# Id$ nonnax 2022-02-12 12:34:38 +0800
require 'json'
# require 'rubytools/array_table'

f=File.expand_path "~/.config/micro/bindings.json"
bindings=JSON.parse(File.read(f))
arr=[]
bindings.each do |k, v|
  # arr<<[k, v.gsub(/\.rb$/, '')]
  puts [k.ljust(25,' '), v].join
end
# puts arr.sort.to_table(ljust: [1])

