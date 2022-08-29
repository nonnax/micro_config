#!/usr/bin/env ruby
# Id$ nonnax 2022-08-25 22:21:19

# require 'fiber_scheduler'

# def enclose(tag, tabstops, &block)
   # s =  "\n%s<%s>"  % [' '*tabstops, tag]
   # s << "%s%s"      % [' '*tabstops, block.call ] if block
   # s << "\n%s</%s>" % [' '*tabstops, tag]
# end

def sub_labels(tag, marker, name)
  tag.sub(/#{marker}([#{marker}\w]+)/) do |matched|
    " #{name}=\"%s\"" % matched.strip.split(/#{marker}/).reject(&:empty?).join(' ')
  end
end

def enclose(tag, tabstop: 0, &block)
  tagname = tag.scan(/\w+/).first
  tag =
    tag
    .then { |tag| sub_labels(tag, '\#', 'id') }
    .then { |tag| sub_labels(tag, '\.', 'class') }

  inside = block.call if block

  tabs = '  ' * tabstop

  s =  format("\n%s<%s>",  tabs, tag)
  s << format("%s%s\n",    tabs * 2, inside) if block && !inside.strip.empty?
  s << format("\n%s</%s>", tabs, tagname)
  s
end

def process(arr, size)
   return "" if arr.empty?
   v = arr.pop
   tabstop=size-arr.size

   tag, n = v.split(/\*/)
   s = ''
   if tag.match?(/\+/)
    head, tag = tag.split(/\+/)
    s<<enclose(head, tabstop:)
   end

   n ||= 1

   # s =  "\n%s<%s>"  % [' '*tabstops, tag]
   # s << "%s%s"      % [' '*tabstops, process(arr,size) ]
   # s << "\n%s</%s>" % [' '*tabstops, tag]

   s<<enclose(tag, tabstop:){process(arr,size)}

   n
   .to_i
   .times
   .map{ s }
   .join('')
end

def run(cmd)
  process(cmd.reverse, cmd.size)
end

# cmd=list=('a'..'z').to_a
cmd=%w[a#cointainer b.content*3 c d e.box f.item*2 g]
puts run( gets.split(/\>/) )
