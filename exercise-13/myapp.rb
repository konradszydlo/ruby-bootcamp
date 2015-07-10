require 'sinatra/base'
require 'json'
require 'net/http'

require_relative 'models/user'

class MyApp < Sinatra::Base

  attr_reader :current_user

  set(:auth) do |*roles|
    condition do
      unless logged_in? && roles.any? { |role| get_current_user.in_role? role.to_s }
        redirect '/login', 303
      end
    end
  end

  get '/' do
    'Hello World'
  end

  get '/login' do
    erb :login
  end

  get '/logout' do
    session[:user_id] = nil
  end

  post '/login' do
    user = User.new params['username'], params['password']
    session[:user_id] = user.username
    redirect to '/bill'
  end

  get '/bill', :auth => [:user, :admin] do
    content = get_json
    erb :bill, :locals => content
  end

  def get_current_user
    @current_user = User.find_by_username session[:user_id]
  end

  def logged_in?
    !session[:user_id].nil?
  end

  def get_json
    # read_json 'resources/bill.json'
    endpoint_json '/bill'
  end

  def endpoint_json(path)
    resp = Net::HTTP.get_response(URI.parse('http://localhost:9292/bill'))
    data = resp.body
    JSON.parse data
  end

  def read_json(filename)
    file = File.read filename
    JSON.parse file
  end
end
