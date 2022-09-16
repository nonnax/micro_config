#!/usr/bin/env ruby
# Id$ nonnax 2021-12-14 12:24:46 +0800
DENSITY_SIGNS = ['░', '▒', '▓', '█'].reverse.freeze

puts DENSITY_SIGNS.map{|e| e*3}.join
