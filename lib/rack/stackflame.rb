module Rack
  class Stackflame
    ASSET_EXTNAMES = %w[js css png jpg jpeg].freeze

    def initialize(app, options = {}, &block)
      @app     = app
      @options = options.dup

      if block_given?
        @block = block
      else
        @block = -> (env) { not_asset_request?(env) }
      end
    end

    def call(env)
      result = nil

      stackflame = ::Stackflame.new
      stackflame.run(@options) do
        result = @app.call(env)
      end

      if @block.call(env)
        stackflame.open_flamegraph
      end

      result
    end

    private

    def not_asset_request?(env)
      path = env['PATH_INFO']
      return false unless path

      extname = Pathname.new(path).extname.gsub(/\A\./, '')
      !ASSET_EXTNAMES.include?(extname)
    end
  end
end
