require 'yamlr/reader/node'
require 'yamlr/reader/format'
require 'yamlr/reader/builder'
require 'yamlr/reader/parser'

module Yamlr
  module Reader
    class EmptyFileError < StandardError; end
    class EmptyInputError < StandardError; end
    class InvalidInputError < StandardError; end
    #
    # parses file or string into Ruby Array, or Hash
    #
    def self.read(input, options)
      raise Yamlr::Reader::EmptyInputError if input.is_a?(String) && input.strip.empty?
      raise Yamlr::Reader::InvalidInputError unless input.is_a?(String) or input.is_a?(File)
      input = File.exists?(input) ? IO.readlines(input) : input.split("\n")
      raise Yamlr::Reader::EmptyFileError if input.empty?
      hash = {}
      lineno = 0
      input.each {|line|
        parsed_hash    = Yamlr::Reader::Parser.parse(line, options, (lineno += 1))
        formatted_hash = Yamlr::Reader::Format.format(parsed_hash)
        Yamlr::Reader::Builder.build(hash, formatted_hash)
      }
      hash.delete(:adr)
      case
      when options[:list] then hash
      when !options[:list] then hash.delete(:lst) && (hash.length == 1) ? hash[1] : hash
      end
    end
  end
end
