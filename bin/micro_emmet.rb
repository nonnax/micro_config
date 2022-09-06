#!/usr/bin/env ruby
# Id$ nonnax 2022-08-25 22:21:19

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
  s << if (block && !inside.strip.empty?)
    format("%s%s",    tabs * 2, inside)
  else
    "text"
  end
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

   s << enclose(tag, tabstop:){process(arr,size)}

   n
   .to_i
   .times
   .map{ s }
   .join('')
end

def run(cmd)
  process(cmd.reverse, cmd.size)
end

puts run( gets.chomp.split(/\>/) )
