#author: shreadline@gmail.com
#source http://github.com/tteng/tophold_rack
#since the tophold_rack depends on the popular authticate gem `devise`,
#which also based on the rack style auth middlware `warden`(for more detail go and 
#reference: 
#         http://railscasts.com/episodes/305-authentication-with-warden
#         http://railscasts.com/episodes/209-introducing-devise
#onece you invoke the devise generator, say you want user model authticateable
#~/your_console>  rails g devise User
#which will generate migration file, model and tests etc, but the background mechanism 
#is devise add a rack middleware to the rails middlewares stack, run `rake middleware` 
#to get the difference around the above command.
#warden keeps the login session, and the seesion key is related with
#the model you want to include the devise code, which is called a `scope`, 
#
#  module Warden
#    class SessionSerializer
#      attr_reader :env
#      include ::Warden::Mixins::Common
#  
#      def initialize(env)
#        @env = env
#      end
#  
#      def key_for(scope)
#        "warden.user.#{scope}.key"
#      end
#  ...   ...
#
#
# and the model name (here is 'user') is corresponding to the scope, and so on 'admin_user' for the admin/.
# Therefore, in this initializer set the 'tophold_rack_devise_scope' to your corresponding deviseable model
# name ('user' by default) and with this parameter tophold_rack
# will *know* the current_user/current_admin_user which helps to collect individual user behavior.
Rails.configuration.tophold_rack_devise_scope = "user"

#BTW, not all requests should be analyzed, such as static files and admin requests, by default 
#tophold_rack will not collect request begin with "/uploads", "/assets", customize this to meet your requirments.
Rails.configuration.tophold_rack_request_black_list << "admin"
