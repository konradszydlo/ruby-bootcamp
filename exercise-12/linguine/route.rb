require 'erb'
require_relative 'response'
require_relative 'translate'

class Route

  CONTENT_ROOT = 'language_content'
  VIEW_ROOT = 'views'

  attr_reader :content_path, :view_path, :lang, :translator

  def initialize(data = {} )
    @content_path = CONTENT_ROOT + data[:path]
    @view_path = VIEW_ROOT + data[:path]
    @lang = data[:lang]
  end

  def execute(env, translator)

    # content is used inside erb.
    content = translator.get_language_content content_path

    template = File.read(view_path + '.erb')

    rendered_result = ERB.new(template).result(binding)

    Response.new.tap do |response|
      response.body = rendered_result
      response.status_code = 200
    end
  end
end