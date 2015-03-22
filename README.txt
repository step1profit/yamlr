= Yamlr

* http://github.com/step1profit/yamlr
* http://seattlerb.org

== DESCRIPTION:

Yamlr is a minimal YAML parser written in Ruby.

== FEATURES:

* Parse Array/Hash/String
* Read/write .yml files
* Dotfile configurable
* Serialize keys
* Robust command line support
* No variables or fancy YAML features

== INSTALLATION:

gem install yamlr

== SYNOPSIS:

=== Comand Line Usage

$ yamlr
Yamlr 2.0.0
    -r, --read FILENAME              .yml file to Ruby Hash or Array
    -w, --write FILENAME,FILENAME    Hash or Array => .yml file
    -d, --dotfile [HOME]             Create .yamlrc dotfile
    -v, --version                    Display verison number
    -h, --help                       Show this message
        --[no-]auto_sym
        --[no-]auto_sym_keys
        --[no-]auto_sym_vals
        --[no-]auto_true
        --[no-]auto_true_keys
        --[no-]auto_true_vals
        --[no-]docs
        --[no-]dot
        --[no-]dotfile
        --[no-]int
        --[no-]int_keys
        --[no-]int_vals
        --[no-]list
        --[no-]strip
        --[no-]strip_keys
        --[no-]strip_vals
        --[no-]symbolize
        --[no-]symbolize_keys
        --[no-]symbolize_vals
        --[no-]sym_str
        --[no-]sym_str_keys
        --[no-]sym_str_vals
        --[no-]yaml

$ yamlr -r your_app/config/database.yml
{"development"=>
  {"adapter"=>"sqlite3",
   "database"=>"db/development.sqlite3",
   "pool"=>5,
   "timeout"=>5000},
[...]

=== Ruby Env Usage

File to Hash or Array
'''
Yamlr.read("your_app/config/database.yml")
# {"development"=>
#  {"adapter"=>"sqlite3",
#   "database"=>"db/development.sqlite3",
#   "pool"=>5,
#   "timeout"=>5000},
# [...]
'''

Hash or Array to .yml Array
'''
object = {1=>2,3=>4}
Yamlr.parse(object)
'''

Hash or Array to .yml file
'''
object = {1=>2,3=>4}
Yamlr.write(object, filename)
'''
== REQUIREMENTS:

* ruby 1.9.3 or higher

== LICENSE:

The MIT License (MIT)

Copyright (c) 2008 - 2015 SoAwesomeMan, Step1Profit

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
