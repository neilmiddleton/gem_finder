ENV["RACK_ENV"] = 'test'

require 'rubygems'
require 'bundler'
Bundler.require

require 'minitest/autorun'
require 'rack/test'
require 'vcr'
require_relative '../app'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end
