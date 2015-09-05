module Rack
  class Stackflame
    def initialize(app, options = {})
      @app = app
      @options = options
    end

    def call(env)
      result = nil
      ::Stackflame.profile(@options) do
        result = @app.call(env)
      end
      result
    end
  end
end
