#!/usr/bin/env -S ruby --disable=gem
# Id$ nonnax 2021-11-02 19:11:52 +0800
print readlines.map(&:chomp).join(' ').gsub(/\s{2,}/, ' ').strip
