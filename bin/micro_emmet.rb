#!/usr/bin/env ruby
# Id$ nonnax 2022-08-25 10:03:28

def enclose(tag, tabstop:0, &block)
  tag =
  tag
  .gsub(/\#(\w+)/, ' id="\1"')
  .gsub(/\.(\w+)/, ' class="\1"')

  tagname=tag.scan(/\w+/).first
  inside=block.call if block

  tabs="  "*tabstop

  s="\n#{tabs}<%s>" % tag
  s<<"#{tabs*2}%s\n" % inside if block && !inside.strip.empty?
  s<<"\n#{tabs}</%s>" % tagname
  s
end

def process(a="", &block)
  arg=a.chomp.split(/>/)
  i=0
  arg
  .dup
  .reverse
  .inject("") do |acc, e|
    tag, n = e.split(/\*/)
    n ||= 1
    tabstop=arg.size-(i=i.succ)
    acc=enclose(tag, tabstop:){ acc }
    acc=acc*n.to_i
  end
  .gsub(/\n{1,}/,"\n")
end

puts process(gets)
