module TopholdRack

  class Redispatcher

    def initialize app
      @app = app
    end

    def request_black_list 
      @black_list ||= /^\/(#{Rails.configuration.tophold_rack_request_black_list.join('|')})/
      p @black_list
      @black_list
    end

    def call env
      request = Rack::Request.new env
      if request.get?
        path, params = request.path, request.params
        scope = env["rack.session"]["warden.user.#{Rails.configuration.tophold_rack_devise_scope}.key"]
        user_id = scope ? scope[1][0] : nil
        unless path =~ request_black_list            
          p "passed..."
        end
      end
      @app.call env #pass the buckets
    end
  
  end

end
