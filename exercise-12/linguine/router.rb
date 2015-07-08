require_relative 'route'
require_relative 'main'

class Router

  attr_reader :routes

  def initialize
    @routes = Hash.new { |hash, key| hash[key] = [] }
  end

  def config(&block)
    instance_eval &block
  end

  def get(path)
    @routes[:get] << path
  end

  def route_for(env)

    path = env['PATH_INFO']
    method = env['REQUEST_METHOD'].downcase.to_sym

    match = if path =~ routes[method].first
      default_path = $1
      lang = $2 ? $2.to_sym : Linguine::DEFAULT_LANGUAGE
    end

    return Route.new({:path => default_path,  :lang => lang}) if match
    return nil
  end
end