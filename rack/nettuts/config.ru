
class ToUpper

  def initialize(app)
    @app = app
  end

  def call(env)

    status, header, body = @app.call(env)

    upcased_body = body.map { |chunk| chunk.upcase }


    [status, header, upcased_body]
  end
end

class Hello
  def self.call(env)
    [ 200, { 'Content-Type' => 'text/plain'}, ['Hello from Rack']]
  end
end

use ToUpper
run Hello