require_relative 'test_helper'

include Rack::Test::Methods

def app() Sinatra::Application end

describe 'my app' do
  it 'has a homepage' do
    get '/'
    assert last_response.ok?
  end

  it 'redirects to the source page for a given gem' do
    VCR.use_cassette('rails') do
      get '/?q=rails'
    end
    follow_redirect!
    assert_equal "http://github.com/rails/rails", last_request.url
  end

  it 'gives you a list of possible gems for a unmatched name' do
    VCR.use_cassette('missing_gem') do
      get '/?q=cucum'
    end
    assert last_response.ok?
    assert last_response.body.include?('cucumber')
  end
end
