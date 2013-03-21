require 'cgi'
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
          p "path: #{path}"
          p "query: #{query}"
          str = path.blank? ? '/' : path
          str += "?#{query}" unless query.blank?
          url = Rails.configuration.tophold_rack_tracking_url+"?request_url=#{CGI.escape str}"
          p url
          open url
        end
      end
      @app.call env #pass the buckets
    end
  
  end

end
