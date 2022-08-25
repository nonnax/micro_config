#!/usr/bin/env ruby
# frozen_string_literal: true
# Id$ nonnax 2022-08-25 10:03:28

# = emmet.rb
#  dynamically parses a command to produce output depending on what you type in the abbreviation
#
# ```
# echo "ul>li*2>a" | emmet.rb
#
# output 1:
# <ul>
#   <li>
#   </li>
# </ul>
#
# echo "ul#container>li.item*2>a.link href='http://example.com'" | emmet.rb
#
# output 2:
#
# <ul id="container">
#   <li class="item">
#     <a class="link" href='http://example.com'>
#     </a>
#   </li>
#   <li class="item">
#     <a class="link" href='http://example.com'>
#     </a>
#   </li>
# </ul>
#
def enclose(tag, tabstop: 0, &block)

  tagname = tag.scan(/\w+/).first
  tag =
    tag
    .sub(/\#(\w+)/, ' id="\1"')
    .sub(/\.(\w+)/, ' class="\1"')

  inside = block.call if block

  tabs = '  ' * tabstop

  s =  format("\n%s<%s>",  tabs, tag)
  s << format("%s%s\n",    tabs * 2, inside) if block && !inside.strip.empty?
  s << format("\n%s</%s>", tabs, tagname)
  s
end

def process(cmd = '')
  i = 0
  arg = cmd.chomp.split(/>/)

  arg
    .reverse
    .inject('') do |acc, e|
      tag, n = e.split(/\*/)
      n ||= 1
      tabstop = arg.size - (i = i.succ)
      acc = enclose(tag, tabstop:) { acc }
      acc *= n.to_i
    end
    .gsub(/\n+/, "\n")
end

puts process(gets)
