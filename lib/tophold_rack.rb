require "tophold_rack/version"
require "redis"
require "redis-namespace"

module TopholdRack

  mattr_accessor :app_root

  def self.setup
    yield self
  end

end

require "tophold_rack/engine"
require "tophold_rack/redispatcher"
