require 'yaml'
require 'set'

module YamlStrictMerge
  class YamlMergeError < StandardError; end
  class << self
    def merge_yaml(lhs, rhs)
      merge(YAML.load(lhs), YAML.load(rhs)).to_yaml
    end

    def merge(lhs, rhs)
      # p lhs
      # p lhs.class
      # p rhs
      # p rhs.class

      return lhs unless rhs
      return rhs unless lhs
      raise YamlMergeError unless lhs.class == rhs.class
      case lhs
      when Hash
        pairs = lhs.keys.concat(rhs.keys).to_set.map { |key|
          [key, merge(lhs[key], rhs[key])]
        }
        return Hash[*pairs.flatten(1)]
      when Array
        raise YamlMergeError unless lhs.size == rhs.size
        return lhs.zip(rhs).map { |lv, rv|
          merge(lv, rv)
        }
      else # primitive type
        if lhs == rhs
          return lhs
        else
          raise YamlMergeError
        end
      end
    end
  end
end
