#!/usr/bin/env ruby
# Id$ nonnax 2021-12-15 22:02:15 +0800
buff=$stdin.read
puts IO.popen("wput", 'w+'){|io| io.puts buff; io.close_write; io.read}
