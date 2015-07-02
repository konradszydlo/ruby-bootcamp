require './my_app'
require './my_rack_middleware'

use Rack::Reloader
use MyRackMiddleware
run MyApp.new