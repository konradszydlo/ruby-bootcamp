require_relative '../myapp'


describe MyApp do

  def app
    MyApp
  end

  it 'says hello world' do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Hello World')
    expect(last_response.body).to include 'Hello'
  end

  it 'shows login page with login form' do
    get '/login'
    expect(last_response).to be_ok
    expect(last_response.body).to include 'Username'
    expect(last_response.body).to include 'Password'
  end

  context 'user is not logged in' do
    it 'bill redirects to login' do
      get '/bill'
      expect(last_response.location).to eq('http://example.org/login') # include '/login'
    end
  end
  context 'user is logged in' do
    it 'bill is displayed' do
      session = {:user_id => 'bob' }
      get '/bill', {}, 'rack.session' => session
      expect(last_response.body).to include 'Generated on:'

    end
  end



end