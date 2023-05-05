require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  def reset_all_table
    seed_sql = File.read('spec/seeds/music_library.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end
  
    before(:each) do 
      reset_all_table
    end

    context "GET /albums" do
      it "returns a list of all albums" do
        response = get('/albums')
        expect(response.status).to eq(200)
        expect(response.body).to include('<a href="/albums/2"> Surfer Rosa </a> </p>')
        expect(response.body).to include('<a href="/albums/3"> Waterloo </a> </p>')
      end
    end

    context 'GET /albums/:id' do
      it "returns a induvidual album" do
        response = get('/albums/1')
        expect(response.status).to eq(200)
        expect(response.body).to include('<h1>Doolittle</h1>')
        expect(response.body).to include('Release year: 1989')
        expect(response.body).to include('Artist: Pixies')
      end
    end
    
  context 'POST /albums' do
    it "should create a new album" do
      response = post('/albums', title: 'ok computer', release_year: '1997', artist_id: '1')
      expect(response.status).to eq(200)
      expect(response.body).to eq('')

      response = get('albums')

      expect(response.body).to include('ok computer')
    end
  end

  context "GET /artists" do
    it "gets a list of all the artists" do
      response = get('/artists')
      expect(response.status).to eq(200)
      expect(response.body).to include('<a href="/artists/1"> Pixies </a>')
      expect(response.body).to include('<a href="/artists/2"> ABBA </a>')
    end

    it "gets artists id 1" do
      response = get('/artists/1')
      expect(response.status).to eq(200)
      expect(response.body).to include('Pixies')
    end
    
    it "gets artists id 2" do
      response = get('/artists/2')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>ABBA</h1>')
    end
  end

  context 'POST /artists' do
    it "creates a new artist" do
      response = post('/artists', name: 'Wild Nothing', genre: 'Indie')
      expect(response.status).to eq(200)
      expect(response.body).to eq('')
      response = get('artists')
      expect(response.body).to include('Wild Nothing')
    end
  end
end