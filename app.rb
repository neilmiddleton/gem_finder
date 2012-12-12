require 'rubygems'
require 'sinatra'
require_relative 'lib/gem_wrapper'

set :public_folder, File.dirname(__FILE__) + '/static'


get "/" do
  if params.has_key?("q")
    g = GemWrapper.new(params["q"])
    target = g.github_page
    redirect target unless target.nil?
    'Gem not found'
  else
    haml :index
  end
end
