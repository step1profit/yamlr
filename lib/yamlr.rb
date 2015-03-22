require 'yamlr/version'
require 'yamlr/reader'
require 'yamlr/writer'
require 'yamlr/indicators'
require 'yamlr/defaults'

module Yamlr
  DOTFILE = "#{ENV['HOME']}/.yamlr"

  # File to Hash or Array
  #
  def self.read(input, options = {})
    Yamlr::Reader.read(input, self.options(options))
  end

  # Hash or Array to .yml Array
  #
  def self.parse(object, options = {})
    Yamlr::Writer.build(object, self.options(options))
  end

  # Hash or Array to .yml file, e.g. filename.yml
  #
  def self.write(object, filename, options = {})
    Yamlr::Writer.write(object, filename, self.options(options))
  end

  # writes a .yamlr file HOME, merges with options if :dot is true
  #
  def self.dotfile(home = ENV['HOME'])
    Yamlr::Writer.dotfile(Yamlr::Defaults.options, home)
  end

  private

  # options
  #
  def self.options(options = {})
    opt = Yamlr::Defaults.options.merge(Yamlr::Indicators.options.merge(options))
    dot_opt = File.exists?(DOTFILE) ? Yamlr::Reader.read(DOTFILE, opt.merge({:symbolize_keys => true})) : nil
    unless opt[:dot]
      opt = opt.merge(dot_opt) if (dot_opt && dot_opt[:dot])
    end
    opt
  end
end
