require_relative 'linguine_rack'

LinguineRack = LinguineRack.new

LinguineRack.router.config do
  get /(^\/\w+)\.?(\w+)?/
end

class Linguine

  DEFAULT_LANGUAGE = :en

  attr_reader :route, :translator

  def call(env)

    @route = LinguineRack.router.route_for(env)
    if route
      @translator = Translator.new(Linguine::DEFAULT_LANGUAGE, route.lang)
      # render 'template' and return response
      # @translator = route.translator
      response = route.execute env, translator
      response.rack_response
    else
      return [404, {}, []]
    end
  end
end