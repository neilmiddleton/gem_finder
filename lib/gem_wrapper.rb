require 'gems'
require 'json'

class GemWrapper

  attr :info, :name

  def initialize(gem)
    @name = gem
  end

  def info=(val)
    @info = val
  end

  def info
    @info ||= Gems.info(@name)
  end

  def home_page
    info["homepage_uri"]
  end

  def source_page
    info["source_code_uri"]
  end

  def github_page
    page = source_page
    page = home_page if source_page.nil? || !source_page.index("github.com")
    page ||= rubygems_page
  end

  def rubygems_page
    info["project_uri"]
  end

end
