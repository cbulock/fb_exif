# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fb_exif/version'

Gem::Specification.new do |spec|
  spec.name          = "fb_exif"
  spec.version       = FbExif::VERSION
  spec.authors       = ["Cameron Bulock"]
  spec.email         = ["cameron@bulock.com"]

  spec.summary       = %q{Read FB Photo Archive and Add EXIF Data to Photos}
  spec.description   = %q{Facebook strips EXIF data from their photos.  But, it's included in HTML that is in the downloadable archives they provide. This reads that HTML and inserts the EXIF data back in.}
  spec.homepage      = "https://github.com/cbulock/fb_exif"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   << 'fb_exif'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency 'nokogiri',      '~> 1.6.7.1'
  spec.add_dependency 'mini_exiftool', '~> 2.5.1'
end
