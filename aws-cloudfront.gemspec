# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "aws-cloudfront/version"

Gem::Specification.new do |s|
  s.name        = "aws-cloudfront"
  s.version     = Aws::Cloudfront::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alexander Greim", "Luke van der Hoeven", "TJ Singleton"]
  s.email       = ["alexxx@iltempo.de", "hungerandthirst@gmail.com", "tj@salescrunch.com"]
  s.homepage    = "https://github.com/iltempo/aws-cloudfront"
  s.summary     = %q{Library and command line tool for managing CloudFront.}
  s.description = %q{This tool enables you to manage your CloudFront distributions via Ruby or command line. It is
                     driven by functions you need to host complete static websites on CloudFront. At the moment you can
                     set the root object of a distribution and invalidate objects to trigger a re-deployment of certain
                     files.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "xml-simple"
end
