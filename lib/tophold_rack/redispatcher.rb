require 'cgi'
require 'open-uri'

module TopholdRack

  class Redispatcher

    def initialize app
      @app = app
      @redis = Rails.configuration.tophold_statistics_redis
    end

    def request_black_list 
      @black_list ||= /^\/(#{Rails.configuration.tophold_rack_request_black_list.join('|')})/
    end

    def call env
      unless Rails.configuration.tophold_rack_disabled
        request = Rack::Request.new env
        if request.get?
          path, query = request.path, request.query_string
          if scope = env["rack.session"]["warden.user.#{Rails.configuration.tophold_rack_devise_scope}.key"]
            user_id = scope[1][0].to_s =~ /\d+/ ? scope[1][0] : scope[0][0]
          else
            user_id = nil
          end
          unless path =~ request_black_list
            begin
              @redis.lpush(Rails.configuration.tophold_statistics_queue,{user_id: user_id, url: path, visited_date: Date.today}.to_json)
            rescue Exception => e
              raise e
              Rails.logger.fatal 'RedisDispatcher can not work!'
            end
          end
        end
      end
      @app.call env #pass the buckets
    end
  
  end

end
