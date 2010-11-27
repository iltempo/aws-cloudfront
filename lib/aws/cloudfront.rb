$:.unshift(File.dirname(__FILE__))

require 'optparse'
require 'openssl'
require 'uri'
require 'net/http'
require 'net/https'
require 'rubygems'
require 'yaml'

require 'xmlsimple'

require 'cloudfront/distribution'
