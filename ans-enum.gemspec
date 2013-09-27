# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ans-enum/version'

Gem::Specification.new do |gem|
  gem.name          = "ans-enum"
  gem.version       = Ans::Enum::VERSION
  gem.authors       = ["sakai shunsuke"]
  gem.email         = ["sakai@ans-web.co.jp"]
  gem.description   = %q{モデルに include すると、列挙型クラスを作成するヘルパーメソッドを追加する}
  gem.summary       = %q{列挙型クラスを作成する}
  gem.homepage      = "https://github.com/answer/ans-enum"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
