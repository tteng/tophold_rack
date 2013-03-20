module TopholdRack

  class Redispatcher

    def initialize app
      @app = app
    end

    def call env
      request = Rack::Request.new env
      p "path: #{request.path}" 
      p "params: #{request.params}"
      p env["rack.session"]["warden.user.admin_user.key"][1].inspect
      @app.call env #pass the buckets
    end
  
  end

end
