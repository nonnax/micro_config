#!/usr/bin/env ruby
# Id$ nonnax 2022-09-04 15:43:48
keywords=gets.split
flag = keywords.detect{|k| k.match?(/^-/)}

def bounded(rx); /^#{rx}$/ end
def time_now; Time.now.strftime("%Y-%m-%d.%I:%M %p") end

case flag

when /--env/
  keywords.delete(flag)
  kw=keywords.shift
  date, time = time_now.split(/\./)
  puts '#/usr/bin/env %s' % [kw || 'ruby']
  puts "Id$ nonnax %s %s" % [date, time]

when /--wup/, bounded(/-w/)
  keywords.delete(flag)
  kw=keywords.join(' ')

  puts <<~___
  date: #{Time.now.strftime('%Y%m%d')}
  tag: #{kw || 'note'}
  ---
  ___

when /^-tt/, /--time/
  puts time_now.split(/\./).pop

when bounded(/-t/), /--date/
  puts time_now

end
