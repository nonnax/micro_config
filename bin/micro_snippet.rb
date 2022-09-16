#!/usr/bin/env -S ruby --disable=gems
# Id$ nonnax 2022-09-04 15:43:48
# consolidated micro textfilter command processor
#
command=gets
keywords=command.split
flag = keywords.detect{|k| k.match?(/^-/)}

def bounded(rx); /^#{rx}$/ end
def time_now; Time.now.strftime("%Y-%m-%d.%I:%M %p") end

case flag

when /--env/
  keywords.delete(flag)
  kw=keywords.shift
  date, time = time_now.split(/\./)
  puts '#!/usr/bin/env %s' % [kw || 'ruby']
  puts "#Id$ nonnax %s %s" % [date, time]

when /--wup/, bounded(/-w/)
  keywords.delete(flag)
  kw=keywords.join(' ')

  puts <<~___
  date: #{Time.now.strftime('%Y%m%d')}
  tag: #{kw || 'note'}
  ---
  ___

when /--time/, bounded(/-tt/)
  puts time_now.split(/\./).pop

when /--date/, bounded(/-t/)
  puts time_now

when /--emmet/, bounded(/-m/)
  print IO.popen("echo \"#{command.sub(/^.+?\s/,'')}\" | micro_emmet.rb", &:read)

when /--bars/, bounded(/-b/)
  DENSITY_SIGNS = ['░', '▒', '▓', '█'].reverse.freeze
  puts DENSITY_SIGNS.map{|e| e*3}.join

else
  # restore unprocessed command
  print command
end
