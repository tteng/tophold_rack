## Scenario

Once you want to do some statistics on your ROR application, there're three solutions so far as I know.

  *  One is to analyze the log file(decouple way, but need to customize the log format to record who is the current user) 
  *  The other way is add some callbacks in your code(coupled). 
  *  And also you could use the google analytics(not so realtime). 

Today I introduce you the way I do. 

When we talk about how to authticate in rails, people may suggest you the very popular gem ``` devise ```, it's based on the ```warden``` middleware, and you can access the seeeion in your rack code. 

Since with rack we could access the request info(path, query string etc) and we also could access the session info, why not we collect these info and parse it? 

That's what tophold_rack do. Tophold rack will not perform *statistics* work, it only collect nessary info and send it to the 3rd party ( I coded this module with node, see detail at [here] (https://github.com/tteng/fetch_stock_quotes/blob/master/src/tracking_handler.coffee)

## Installation

Add this line to your application's Gemfile:

    gem 'tophold_rack'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tophold_rack

After installation, run 

    $ rails g tophold_rack install  

to generate the config file.

## Usage

Say, if you authticate with admin_user.rb model, change the devise scope to corresponding model name.

    Rails.configuration.tophold_rack_devise_scope = "admin_user"

Sometimes we don't want to analyze assets and some static file uri, it make no sense. You could customize the uri black list, by default tophold_rack will ignore uri begin with 'assets', 'uploads'.

    Rails.configuration.tophold_rack_request_black_list << "admin"

The last thing is to specify which url to receive these parameters and to do the detaild parse job. I prefer node, it's bloody fast and non-block, will make the cost to the minimum level. Also you can push these parameters to a redis list, and parse it with blpop, it's up to you.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
