require 'open-uri'

module TopholdRack

  class Redispatcher

    def initialize app
      @app = app
    end

    def request_black_list 
      @black_list ||= /^\/(#{Rails.configuration.tophold_rack_request_black_list.join('|')})/
    end

    def call env
      request = Rack::Request.new env
      if request.get?
        path, query = request.path, request.query_string
        scope = env["rack.session"]["warden.user.#{Rails.configuration.tophold_rack_devise_scope}.key"]
        user_id = scope ? scope[1][0] : nil
        unless path =~ request_black_list            
          url = Rails.configuration.tophold_rack_tracking_url+"?request_url=#{query}"
          p url
          open url
        end
      end
      @app.call env #pass the buckets
    end
  
  end

end
