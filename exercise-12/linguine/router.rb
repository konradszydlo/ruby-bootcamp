require_relative 'route'

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
    # route_data = routes[method].detect do |route|
    #
    #   puts path
    #   puts route
    #
    #   # if path =~ /(^\/\w+)(\.\w+)?/
    #   if path =~ route
    #     puts 'it matches now'
    #     puts "path: #{$1} and extension: #{$2}"
    #   else
    #     puts 'not matches'
    #   end
    #   route == path
    # end

    match = if path =~ routes[method].first
      puts 'it matches now'
      puts "path: #{$1} and extension: #{$2}"
      # lang = if $2 then $2.to_sym else :en end
      lang = $2 ? $2.to_sym : :en

    else
      puts 'not matches'
    end

    puts lang

    return Route.new({path => path,  lang => lang}) if match
    return nil
  end
end