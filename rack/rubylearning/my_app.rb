
class MyApp

  def call(env)
    [200, { 'Content-Type' => 'text/plain'}, ['Hello Rack participants from']]
  end
end
