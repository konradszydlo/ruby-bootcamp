
class MyRackMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    status, header, body = @app.call(env)
    append_s = '... greetings from anime'
    new_body = ''
    body.each { |string| new_body << ' ' << string }
    new_body << ' ' << append_s
    [status, header, [new_body]]
  end
end