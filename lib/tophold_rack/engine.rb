module TopholdRack

  class Engine < Rails::Engine

    config.tophold_rack_devise_scope = "user"

    config.tophold_rack_request_black_list = ["uploads", "assets"]

    config.tophold_rack_disabled = false
    
    redis = Redis.new host: "127.0.0.1", port: 6379
    
    nspace = Redis::Namespace.new 'st', redis: redis

    config.tophold_statistics_redis = nspace
    
    config.tophold_statistics_queue = "static"
 
    initializer "tophold_rack.load_app_instance_data" do |app|
      TopholdRack.setup do |config|
        config.app_root = app.root
      end
    end   

    initializer "tophold_rack.add_middleware_after_devise" do |app|
      #app.middleware.insert_after ActionDispatch::Session::CookieStore, TopholdRack::Redispatcher
      app.middleware.use TopholdRack::Redispatcher
    end
  
  end

end
