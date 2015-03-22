require 'yamlr/writer/builder'

module Yamlr
  module Writer
    class EmptyFilenameError < StandardError; end
    class EmptyInputError < StandardError; end
    class InvalidInputError < StandardError; end
    class InvalidFilenameError < StandardError; end

    # array, hash, or string to array of lines of .yml file
    #
    def self.build(object, options)
      raise Yamlr::Writer::EmptyInputError if object.is_a?(String) && object.strip.empty?
      raise Yamlr::Writer::InvalidInputError unless object.is_a?(String) or object.is_a?(Array) or object.is_a?(Hash)
      Yamlr::Writer::Builder.build([], object, options)
    end

    # array, hash, or string to file
    #
    def self.write(object, filename, options)
      filename = "#{ENV['HOME']}/#{File.basename(filename.to_s)}" if (filename =~ /^~/)
      raise Yamlr::Writer::EmptyInputError if (object.is_a?(String) && object.strip.empty?)
      raise Yamlr::Writer::InvalidInputError unless (object.is_a?(String) or object.is_a?(Array) or object.is_a?(Hash))
      raise Yamlr::Writer::EmptyFilenameError if File.basename(filename.to_s).strip.empty?
      raise Yamlr::Writer::InvalidFilenameError unless File.exists?(File.dirname(filename))
      File.open(filename, "w") do |file|
        self.build(object, options).each {|line|
          file.print("#{line}\n")
        }
      end
      filename
    end

    # write a yamlr dotfile to home dir
    #
    def self.dotfile(options, home)
      filename = "#{home.chomp("/")}/.yamlrc"
      new_name = nil
      if File.exists?(filename)
        new_name = "#{filename}.#{Time.now.strftime("%Y%m%d%H%M%S")}"
        File.rename(filename, new_name)
      end
      self.write(options, filename, Yamlr::Indicators.options)
      new_name ? new_name : filename
    end
  end
end
