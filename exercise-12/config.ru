require_relative 'linguine/main'
require_relative 'linguine/linguine_rack'

LinguineRack = LinguineRack.new

# require_relative 'config/routes'

LinguineRack.router.config do

  # get('/home')
  #
  # get('/about')

  get /(^\/\w+)\.?(\w+)?/

end

class MyApp

  def call(env)
    route = LinguineRack.router.route_for(env)
    if route
      # render 'template' and return response
      response = route.execute env
      response.rack_response
      # return response.rack_response
    else
      return [404, {}, []]
    end
  end
end

class Linguine
  class << self

    def call env
      [200, {'Content-Type' => 'text/html'}, [page]]
    end
  end

end

class MyApp < Linguine
  def page
    '<html><h1>Hello World</h1></html>'
  end
end
run MyApp.new
