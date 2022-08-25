#!/usr/bin/env ruby
# Id$ nonnax 2022-08-25 10:03:28

current=nil
@a=%w[a b c]

def enclose(tag, tabstop:0, &block)
  inside=block.call if block
  tag=tag.gsub(/\#(\w+)/, ' id="\1"').gsub(/\.(\w+)/, ' class="\1"')
  tagname=tag.scan(/\w+/).first
  # "<%s>%s</%s>" % [tag, inside, tag]
  tabs="  "*tabstop
  s="\n#{tabs}<%s>" % tag
  s<<"#{tabs*2}%s\n" % inside if block && !inside.strip.empty?
  s<<"\n#{tabs}</%s>" % tagname
  s
end

def process(a="", &block)
  arg=a.chomp.split(/>/)
  # res=arg.dup.reverse.inject(str) do |acc, e|
  acc=''
  arg.dup.reverse.map.with_index do |e, i|
    tag, n = e.split(/\*/)
    n ||= 1
    tabstop=arg.size-i-1
    acc=enclose(tag, tabstop:){acc}
    acc=acc*n.to_i
  end
  .last
  .gsub(/\n{1,}/,"\n")
end

# pop c
# process c
# return "<c></c>"
# pop b
# process(b){doc}
# return b

# puts process(@a)
a=gets
puts res=process(a)
puts res
