require 'rails/generators'
class TopholdRackGenerator < Rails::Generators::Base

  source_root File.expand_path('../templates', __FILE__)

  def install 
    template "tophold_rack.rb", "config/initializers/tophold_rack.rb"
  end

end
