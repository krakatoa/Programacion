#!/usr/bin/ruby
require 'rubygems'
require 'haml'

file = File.read('curso.haml')

m = /(\W*)~=\W*'(.+)'/
output = ""
file.each_line { |line|
  matches = line.match(m)
  if matches
    name = matches[2]
    indent = matches[1].size
    partial = File.read("#{name}.haml")
    partial.each_line { |partial_line|
      output << " " * indent << partial_line
    }
  else
    output << line
  end
}

haml = Haml::Engine.new(output, {:attr_wrapper => "\""})

render = File.open('index.html', 'w')
render.write(haml.render)
