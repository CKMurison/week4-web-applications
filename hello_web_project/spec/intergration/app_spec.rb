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

  context 'GET /tasks/new' do
    it "Should get the html form to create a new task" do
      
      response = get('/tasks/new')
      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/tasks">')
      expect(response.body).to include('<input type="text" name="task_name" />')
    end
  end

  context "POST /tasks" do
    it "Should post a task and return confirmation" do
    response = post('/tasks', task_name: 'Buy weggs')
    
    expect(response.status).to eq(200)
    expect(response.body).to include('<h1>Task saved: Buy weggs</h1>')
    end

    it "Should post a task and return confirmation with a different name" do
      response = post('/tasks', task_name: 'Eat The Cheese')
      
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Task saved: Eat The Cheese</h1>')
    end
  end
end