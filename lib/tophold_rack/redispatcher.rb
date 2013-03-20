module TopholdRack

  class Redispatcher

    def initialize app
      @app = app
    end

    def call env
      request = Rack::Request.new env
      if request.get?
        p "request: #{request.body}"
        path, params = request.path, request.params
        p "path: #{request.path}" 
        p "params: #{request.params}"
        scope = env["rack.session"]["warden.user.#{Rails.configuration.tophold_rack_devise_scope}.key"]
        user_id = scope[1][0] if scope
        p "/\/^(#{Rails.configuration.tophold_rack_request_black_list.join('|')})/"
        unless path =~ /\/^(#{Rails.configuration.tophold_rack_request_black_list.join('|')})/
          p "passed..."
        end
      end
      @app.call env #pass the buckets
    end
  
  end

end
