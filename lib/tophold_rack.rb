require "tophold_rack/version"
require "tophold_rack/engine"
require "tophold_rack/redispatcher"

module TopholdRack

  mattr_accessor :app_root

  def self.setup
    yield self
  end

end
