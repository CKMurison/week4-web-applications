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
    it 'returns Hello!' do
      response = get('/hello')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Hello!</h1>')
    end
  end

  context 'GET /names' do
    it "returns a list of names" do
      response = get('/names')
      expect(response.status).to be(200)
      expect(response.body).to eq("Julia, Mary, Karim")
    end
  end
  
  context "POST /sort-names" do
    it "Returns sorted list of names" do
      names = "Joe,Alice,Zoe,Julia,Kieran"
      response = post("sort-names?names=#{names}")
      expect(response.status).to eq 200
      expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
    end
  end
end