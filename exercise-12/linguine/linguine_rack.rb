
require_relative 'router'

class LinguineRack

  attr_reader :router

  def initialize
    @router = Router.new
  end
end