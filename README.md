# SinatraCyclist

## Installation

Add this line to your application's Gemfile:

    gem 'sinatra_cyclist'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra_cyclist

Installation into your code depends on how you are using Sinatra

### Classic Applications
Require the gem and specify the routes you want to cycle through.

```ruby
require "sinatra"
require "sinatra/cyclist"

set :routes_to_cycle_through, [:page_1, :page_2]

get "/page_1" do
  "Page 1"
end

get "/page_2" do
  "Page 2"
end
```

### Modular Applications
Require the gem, explicitly register the extension, and specify the routes.
```ruby
require "sinatra/base"
require "sinatra/cyclist"

class MyApp < Sinatra::Base
  register Sinatra::Cyclist

  set :routes_to_cycle_through, [:page_1, :page_2]

  get "/page_1" do
    "Page 1"
  end

  get "/page_2" do
    "Page 2"
  end
end
```

## Usage
Now visit `/_cycle` to start cycling!

You can also specify a duration (in seconds) in the params to the cycle action

```
http://sinatra_app.com/_cycle?duration=10
```

### Dashing
If you are using [dashing](https://github.com/Shopify/dashing), update your `config.ru`

```ruby
require "sinatra/cyclist"
require 'dashing'

configure do
  set :auth_token, 'YOUR_AUTH_TOKEN'

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

set :routes_to_cycle_through, [:dashboard_1, :dashboard_2]

run Sinatra::Application
```

* Require `sinatra_cyclist` before `dashing` otherwise you will see this error:

    > No such file or directory - sample/dashboards/_cycle.erb

* Set the `routes_to_cycle_through` before running the application.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

![](http://24.media.tumblr.com/tumblr_lhgo817Gnw1qf6o97o1_500.jpg)
