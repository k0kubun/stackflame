require "stackflame/version"
require "stackprof"

class Stackflame
  def self.profile(mode: :cpu, &block)
    stackflame = self.new
    stackflame.run(mode, &block)
  end

  def run(mode, &block)
    result = StackProf.run(mode: mode, raw: true, &block)
  end
end
