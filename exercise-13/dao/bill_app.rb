require 'json'
require 'sinatra/base'

class BillApp < Sinatra::Base

  get '/bill' do
    content_type :json
    read_json 'resources/bill.json'
  end

  def read_json(filename)
    File.read filename
  end

end