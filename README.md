This is the source code for the sinatra-template project on github. Base on the template I have create page to solve Fyber Development Challenge.

What's inside?
--------------

* Modular Sinatra app version 1.3.2 using ruby 1.9.3-p125
* minitest for unit-level tests
* rack-test for routes tests
* yard for documentation
* Rakefile, Gemfile, .rvmrc, .gitignore

Folders Structure
------------------

    app.rb         # require sinatra, vendor'd gems, models/init, routes/init, helpers/init

    helpers/         
      init.rb      # Require each helper file
      helper1.rb   # Related helper methods

    routes/          
      init.rb      # Require each route, in controlled order
      api.rb       # One or more routes related to some feature

    views/
      flash.erb         # Partial layout for showing errors
      header.erb        # Partial for page header
      index.erb         # Main page for basic form
      no_offers.erb     # Partial for showing no effers page
      offer_element.erb # Partial for showing offer element
      offers.erb        # The main page for showing offers

    test/         
      models       # minitest
      routes       # rack-test
      acceptance  # capybara + minitest

Setup
-----

Install bundler

    gem install bundler

Install the gems

    bundle install --without production staging

View all available rake commands

    rake -T

    rake                  # Run all tests
    rake test:routes      # Run routes tests

Run the server

    rackup -o 0.0.0.0 -p 9292 config.ru

Go to [http://127.0.0.1:9292](http://127.0.0.1:9292)


