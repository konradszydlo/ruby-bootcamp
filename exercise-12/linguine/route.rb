require 'erb'

require_relative 'response'

class Route

  CONTENT_ROOT = 'language_content'
  VIEW_ROOT = 'views'

  attr_reader :content_path, :filename, :view_path

  def initialize(data = {})

    puts data

    # @filename = data[]
    # @content_path = CONTENT_ROOT + data
    # @view_path = VIEW_ROOT + data

  end

  def get_language_content(path)

    data = {}
    File.readlines(path + '.data').each do |line|
      key, value = line.split(':')
      value = value.strip
      data[key] = value
    end
    data
  end

  def execute(env)

    # get content of a file -
    content = get_language_content content_path

    # pass it to html template
    template = File.read(view_path + '.erb')

    # get html

    rendered_result = ERB.new(template).result(binding)

    Response.new.tap do |response|
      response.body = rendered_result
      response.status_code = 200
    end
  end
end