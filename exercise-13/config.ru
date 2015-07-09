require './myapp'

use Rack::Session::Cookie, :key => 'rack.session',
    :path => '/',
    :secret => 'your_secret'

run MyApp