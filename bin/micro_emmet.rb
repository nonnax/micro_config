#!/usr/bin/env ruby
# Id$ nonnax 2022-08-24 21:44:06

class Dive
  attr :arr

  def initialize(*a)
    @arr=a
    @level=-1
  end

  def tab(&block)
    (" "*@level)+block.call if @level>=0
  end

  def enclose(tag, &block)
      tag=tag.gsub(/\#(\w+)/, ' id="\1"').gsub(/\.(\w+)/, ' class="\1"')

      str=''
      str<< tab{"<%s>\n" % tag}
      str<< tab{block.call} if block
      str<<"\n"
      str<< tab{"</%s>" % tag.scan(/\w+/).first}
  end

  def dive()
    @level+=1
    return if arr.empty?
    current=arr.shift
    s=enclose(current){ dive().to_s }
    @level-=2
    @level=[@level, 0].max
    s
  end

  def repeat(args)
   @arr_copy=arr.dup
    tag, repeat = args.split(/\*/)
    tag=tag.gsub(/\#(\w+)/, ' id="\1"').gsub(/\.(\w+)/, ' class="\1"')

    res=repeat.to_i.times.map do |i|
      s="<%s></%s>" % [tag, tag.scan(/\w+/).first]
    end
  end

  def to_s
    @output
  end
end

template = gets
arr=template.split(/>/)
d=Dive.new(*arr)

if arr.first.match?(/\d+/)
  digit=arr.first.match(/\d+/)[2]
  puts d.repeat(template)
else
  puts d.dive()
end

