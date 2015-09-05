require "stackflame/version"
require "rack/stackflame"
require "stackprof"

class Stackflame
  DEFAULT_OPTIONS = {
    interval: 1000,
    mode:     :cpu,
    raw:      true,
  }.freeze

  def self.profile(options = {}, &block)
    stackflame = self.new
    stackflame.run(options, &block)
    stackflame.open_flamegraph
  end

  def run(options = {}, &block)
    options = DEFAULT_OPTIONS.merge(options)
    result  = StackProf.run(options, &block)

    File.open(temp_js_path, 'w') do |f|
      StackProf::Report.new(result).print_flamegraph(f)
    end
  end

  def open_flamegraph
    if system("which osascript > /dev/null")
      # NOTE: `open` can't open path with query string
      `osascript -e 'open location "#{flamegraph_path}"'`
    else
      puts "This OS is not supported. Please open: #{flamegraph_path}"
    end
  end

  private

  def flamegraph_path
    viewer_path = File.expand_path('../../vendor/viewer.html', __FILE__)
    "file://#{viewer_path}?data=#{temp_js_path}"
  end

  def temp_js_path
    return @js_path if @js_path

    temp = `mktemp /tmp/stackflame-XXXXXXXX`.strip
    @js_path = "#{temp}.js"
    `mv #{temp} #{@js_path}`
    @js_path
  end
end
