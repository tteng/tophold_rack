module TopholdRack

  class Redispatcher

    def initialize app
      @app = app
    end

    def call env
      request = Rack::Request.new env
      p "path: #{request.path}" 
      p "params: #{request.params}"
      env["rack.session"].keys.sort.each do |k|
        p k 
        p env["rack.session"][k].inspect
      end
      p "warden.user.#{Rails.configuration.tophold_rack_devise_scope}"
      scope = env["rack.session"]["warden.user.#{Rails.configuration.tophold_rack_devise_scope}"]
      if scope
        p scope[1].inspect 
      else
        p nil
      end
      @app.call env #pass the buckets
    end
  
  end

end
