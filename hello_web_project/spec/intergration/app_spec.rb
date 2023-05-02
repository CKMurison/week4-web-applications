require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  # GET /

  context 'GET /hello' do
    it 'returns Hello Cameron!' do
      response = get('/hello?name=Cameron')
      expect(response.status).to be(200)
      expect(response.body).to eq('Hello Cameron!')
    end

    it 'returns Hello Jim!' do
      response = get('/hello?name=Jim')
      expect(response.status).to be(200)
      expect(response.body).to eq('Hello Jim!')
    end
  end

  context 'GET /names' do
    it "returns a list of names" do
      response = get('/names')
      expect(response.status).to be(200)
      expect(response.body).to eq("Julia, Mary, Karim")
    end
  end
end