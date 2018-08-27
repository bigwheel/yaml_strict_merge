#!/usr/bin/env ruby

require_relative '../lib/yaml_strict_merge.rb'

yaml = <<~EOS
---
EOS

ARGV.each do |filename|
  s = File.open(filename) { |f| f.read }
  yaml = YamlStrictMerge::merge_yaml(yaml, s)
end

puts yaml
