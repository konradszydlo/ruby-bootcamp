require 'sinatra/base'
require 'json'

require_relative 'models/user'

class MyApp < Sinatra::Base

  # enable :sessions
  # set :sessions => true

  attr_reader :current_user

  get '/' do
    'Hello World'
  end

  get '/login' do
    erb :login
  end

  get '/logout' do
    session[:user_id] = nil
  end

  def get_current_user

    @current_user = User.find_by_username session[:user_id]

  end

  post '/login' do
    user = User.new params['username'], params['password']
    session[:user_id] = user.username
    redirect to '/bill'
  end

  def logged_in?
    !session[:user_id].nil?
  end

  set(:auth) do |*roles|
    condition do
      unless logged_in? && roles.any? { |role| get_current_user.in_role? role.to_s }
        redirect '/login', 303
      end
    end
  end

  get '/bill', :auth => [:user, :admin] do
    content = get_json
    erb :bill, :locals => content
  end

  def get_json
    read_json 'resources/bill.json'
  end

  def read_json(filename)
    file = File.read filename
    JSON.parse file
  end
end
