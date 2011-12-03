#!/usr/bin/env ruby
# @see http://d.hatena.ne.jp/kitokitoki/20101219/p1

require 'rubygems'
require 'haml/html'

begin
  haml = Haml::HTML.new(ARGV[0]).render
  puts Haml::Engine.new(haml, :attr_wrapper => '"').render
rescue Exception => e
  puts ARGV[0]
end
