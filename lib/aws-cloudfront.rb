$:.unshift(File.dirname(__FILE__))

require 'openssl'
require 'uri'
require 'net/http'
require 'net/https'
require 'rubygems'
require 'yaml'

require "rubygems"
require "bundler/setup"

require "xmlsimple"
require 'aws-cloudfront/distribution'
