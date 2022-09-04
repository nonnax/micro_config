#!/usr/bin/env ruby
# Id$ nonnax 2022-09-04 11:38:02

lines=ARGF.readlines
anchor=lines.last.index(/\S/)

lines.map{|l|
  l.match?(/\S/) ? l.lstrip.prepend("\s"*anchor) : l
}
.map(&:rstrip)
.join("\n")
.then{|out|
  puts out
}
