require_relative 'test_helper'
require_relative './../lib/gem_wrapper'

describe GemWrapper do
  before do
    @gw = GemWrapper.new('rails')
  end

  it 'intializes' do
    assert_equal 'rails', @gw.name
  end

  it 'finds a gem' do
    VCR.use_cassette('rails_gem') do
      @gw.info.must_be_kind_of Hash
    end
  end

  it 'knows the gems home_page' do
    VCR.use_cassette('rails_gem') do
      assert_equal "http://www.rubyonrails.org", @gw.home_page
    end
  end

  it 'knows the gems source code location' do
    VCR.use_cassette('rails_gem') do
      assert_equal "http://github.com/rails/rails", @gw.source_page
    end
  end

  it 'knows the gems rubygems page' do
    VCR.use_cassette('rails_gem') do
      assert_equal "http://rubygems.org/gems/rails", @gw.rubygems_page
    end
  end

  it 'should take a likely guess at the best github page' do
    VCR.use_cassette('rails_gem') do
      assert_equal "http://github.com/rails/rails", @gw.github_page
    end
  end

  it 'should fail back to the home_page if there is no source_page' do
    @gw.info = {"homepage_uri" => 'http://homepage'}
    assert_equal "http://homepage", @gw.github_page
  end

  it 'should fail back to the rubygems_page if there is no home_page' do
    @gw.info = {"project_uri" => 'http://rubygems'}
    assert_equal "http://rubygems", @gw.github_page
  end
end
