# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "yamlr"
  s.version = "2.0.0.20150322055231"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Step1Profit"]
  s.date = "2015-03-22"
  s.description = "Yamlr is a minimal YAML parser written in Ruby."
  s.email = ["sales@step1profit.com"]
  s.executables = ["yamlr"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt", "History.txt"]
  s.files = [".autotest", "History.txt", "Manifest.txt", "README.txt", "Rakefile", "bin/yamlr", "yamlr.gemspec", "lib/yamlr.rb", "lib/yamlr/defaults.rb", "lib/yamlr/errors.rb", "lib/yamlr/indicators.rb", "lib/yamlr/reader.rb", "lib/yamlr/reader/builder.rb", "lib/yamlr/reader/format.rb", "lib/yamlr/reader/node.rb", "lib/yamlr/reader/parser.rb", "lib/yamlr/version.rb", "lib/yamlr/writer.rb", "lib/yamlr/writer/builder.rb", "test/files/2009.yml", "test/files/arrays.yml", "test/files/blank.yml", "test/files/comments.yml", "test/files/hashes.yml", "test/files/malformed.yml", "test/files/mixed.yml", "test/files/nested.yml", "test/files/split.yml", "test/test_reader.rb", "test/test_reader_builder.rb", "test/test_reader_format.rb", "test/test_reader_parser.rb", "test/test_writer.rb", "test/test_writer_builder.rb", "test/test_yamlr.rb", ".gemtest"]
  s.homepage = "http://github.com/step1profit/yamlr"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--title", "TestYamlr Documentation", "--quiet"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Yamlr is a minimal YAML parser written in Ruby."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe-yard>, [">= 0.1.2"])
      s.add_development_dependency(%q<hoe>, ["~> 3.13"])
    else
      s.add_dependency(%q<hoe-yard>, [">= 0.1.2"])
      s.add_dependency(%q<hoe>, ["~> 3.13"])
    end
  else
    s.add_dependency(%q<hoe-yard>, [">= 0.1.2"])
    s.add_dependency(%q<hoe>, ["~> 3.13"])
  end
end
