
class Linguine

  def initialize
    @response = ''
  end

  def render(text)
    @response = text
  end

  def call(env)
    ['200', {'Content-Type' => 'text/plain'}, [@response]]
  end

  def get(path, opts = {}, &block)

    map path do

    end
  end
end