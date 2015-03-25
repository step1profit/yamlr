#!/usr/bin/env ruby -w
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'rubygems'
require 'minitest/unit'
$: << 'lib' << 'test'
require 'yamlr'
MiniTest::Unit.autorun

class TestYamlr < MiniTest::Unit::TestCase
  def setup
    @files  = "#{File.expand_path(File.dirname(__FILE__))}/files"
    @test = "#{@files}/test.yml"
    @opt = Yamlr::Defaults.options.merge(Yamlr::Indicators.options)
    @hom = ENV['HOME']
    @dot = "#{@hom}/.yamlrc"
    @hsh = {
      "grocery_list" => {
        "meatsez" => {
          1 => {"count"=>5, "model"=>"Spam"},
          2 => {"count"=>1, "model"=>"Log of ground beef"}},
        "beer"=>{1=>{"count"=>1, "model"=>"24 pack - Coors Lite"}},
        "cigarettes" => {
          1 => {"count"=>2, "model"=>"Carton - Basic Ultra Menthol Box 100"}},
        "other" => {
          1 => {"count"=>2, "model"=>"Economy-Size Pork & Beans"},
          2 => {"count"=>1, "model"=>"Jumbo Miracle Whip"},
          3 => {"count"=>2, "model"=>"White Wonder Bread"}}}}
    @exp =
      ["grocery_list:",
       "  meatsez:",
       "    1:",
       "      count: 5",
       "      model: Spam",
       "    2:",
       "      count: 1",
       "      model: Log of ground beef",
       "  beer:",
       "    1:",
       "      count: 1",
       "      model: 24 pack - Coors Lite",
       "  cigarettes:",
       "    1:",
       "      count: 2",
       "      model: Carton - Basic Ultra Menthol Box 100",
       "  other:",
       "    1:",
       "      count: 2",
       "      model: Economy-Size Pork & Beans",
       "    2:",
       "      count: 1",
       "      model: Jumbo Miracle Whip",
       "    3:",
       "      count: 2",
       "      model: White Wonder Bread"]
    @nested =<<FEKJA
domain: test
manifest:
  manifest_id:
    format: String
  master_id:
    format: String
  owner_id:
    format: String
  log_id:
    desc: log of all transactions withing the entire tree
    format: String
FEKJA
  end

  def test_read_hash
    act = Yamlr.read("#{@files}/hashes.yml")
    assert_equal @hsh, act
  end

  def test_read_hash_options_symbolize_keys
    hsh = ":awesome: dude"
    exp = {:awesome => "dude"}
    act = Yamlr.read(hsh, {:symbolize_keys => true})
    assert_equal exp, act
  end

  def test_read_nested_hash_options_symbolize
    exp = {
     :domain => :test,
     :manifest => {
       :manifest_id => {
         :format => :String},
       :master_id => {
         :format => :String},
       :owner_id=>{
         :format => :String},
       :log_id => {
         :desc => :"log of all transactions withing the entire tree",
         :format => :String}}}
    act = Yamlr.read(@nested, {:symbolize => true})
    assert_equal exp, act
  end

  def test_read_nested_hash_options_symbolize_keys
    exp = {
     :domain=>"test",
     :manifest=>{
       :manifest_id=>{
         :format => "String"},
       :master_id=>{
         :format => "String"},
       :owner_id=>{
         :format => "String"},
       :log_id=>{
         :desc=>"log of all transactions withing the entire tree",
         :format => "String"}}}
    act = Yamlr.read(@nested, {:symbolize_keys => true})
    assert_equal exp, act
  end

  def test_read_string
    str = IO.read("#{@files}/hashes.yml")
    act = Yamlr.read(str)
    assert_equal @hsh, act
  end

  def test_parse_hash
    act = Yamlr.parse(@hsh)
    assert_equal @exp, act
  end

  def test_write
    File.delete(@test) if File.exists?(@test)
    refute(File.exists?(@test), "dude!")
    Yamlr.write(@hsh, @test)
    act = (IO.readlines(@test).map {|x| x.chomp})
    assert(File.exists?(@test))
    assert_equal @exp, act
    File.delete(@test)
  end

  def test_dotfile
    File.delete(@dot) if File.exists?(@dot)
    refute(File.exists?(@dot), "dude!")
    Yamlr.dotfile
    assert(File.exists?(@dot))
    exp_keys = Yamlr::Defaults.options
    act_keys = Yamlr::Reader.read(@dot, @opt.merge({:symbolize_keys => true}))
    assert_equal exp_keys, act_keys
    File.delete(@dot)
  end

  def test_dotfile_exists
    len = Dir.entries(@hom).length
    mv_by_test = (File.exists?(@dot) ? "#{@dot}.mv_by_test" : "")
    File.rename(@dot, mv_by_test) unless mv_by_test.empty?
    refute(File.exists?(@dot), "dude!")
    dot = Yamlr.dotfile
    assert File.exists?(@dot)
    assert File.exists?(dot)
    assert_equal len, (Dir.entries(@hom).length - 1)
    File.delete(@dot) if File.exists?(@dot)
    File.delete(dot) if File.exists?(dot)
    refute(File.exists?(@dot), "dude!")
    refute(File.exists?(dot), "dude!")
    File.rename(mv_by_test, @dot) if File.exists?(mv_by_test)
  end

  def test_read_raise_on_empty_string
    assert_raises(Yamlr::Reader::EmptyInputError) {Yamlr.read("")}
  end

  def test_format_sym_str_nested_2009yml
    file = "#{@files}/2009.yml"
    raise file.inspect unless File.exist?(file)
    act = Yamlr.read(file, {:sym_str => true})
    exp = {:content=>{1=>:"200901.yml", 2=>:"200902.yml"}}
    assert_equal exp, act
  end

  # this is what was happening! because the "01".to_i # => 1
  # {:content=>{"01"=>:"200901.yml", "02"=>:"200902.yml"}}
  def test_format_sym_str_nested
    file = "#{@files}/nested.yml"
    raise file.inspect unless File.exist?(file)
    act = Yamlr.read(file)
    exp = {1 => "awesome", 2 => "dude", 3 => {1 => "niceone", 2 => "bro", "fekja" => "bacon", 3 => {1 => "beer", 2 => "camaro"}}}
    assert_equal exp, act
  end
end
