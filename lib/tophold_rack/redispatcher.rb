module TopholdRack

  class Redispatcher

    def initialize app
      @app = app
    end

    def call env
      request = Rack::Request.new env
      p "path: #{request.path}" 
      p "params: #{request.params}"
      env.keys.sort.each do |k|
        p k
      end
      @app.call env #pass the buckets
    end
  
  end

end
