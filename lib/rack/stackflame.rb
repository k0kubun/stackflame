module Rack
  class Stackflame
    def initialize(app)
      @app = app
    end

    def call(env)
      result = nil
      ::Stackflame.profile do
        result = @app.call(env)
      end
      result
    end
  end
end
