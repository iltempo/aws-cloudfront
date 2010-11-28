#!/usr/bin/env ruby
require File.dirname(__FILE__) + '/lib/aws/cloudfront'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: #{__FILE__}.rb [options] command"

  opts.on("-d", "--distribution-id [ID]", "CloudFront Distribution ID") do |v|
    options[:distribution_id] = v
  end
  opts.on("-k", "--access-key [KEY]", "AWS Access Key") do |v|
    options[:access_key] = v
  end
  opts.on("-s", "--secret-access-key [KEY]", "AWS Secret Access Key") do |v|
    options[:secret_key] = v
  end
  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end
end.parse!(ARGV)

unless ARGV.length > 0
  puts "Please specify command: set_default_root_object [object]"
  exit 1
end

distribution = AWS::Cloudfront::Distribution.new(options[:distribution_id],
                                options[:access_key], options[:secret_key], options[:verbose])

distribution.__send__(ARGV.shift, ARGV)
