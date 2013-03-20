module TopholdRack

  class Engine < Rails::Engine
 
    initializer "tophold_rack.load_app_instance_data" do |app|
      TopholdRack.setup do |config|
        config.app_root = app.root
      end
    end   

    initializer "tophold_rack.add_middleware_after_devise" do
      config.middleware.insert_after ActionDispatch::Session::CookieStore, TopholdRack::Redispatcher
    end
  
  end

end
