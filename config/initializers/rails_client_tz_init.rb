# Say in config/initializers/rails_client_tz_init.rb
RailsClientTimezone::Setting.mode = :smart #default value is :smart. Accepted values - :browser, :ip, :smart

RailsClientTimezone::Setting.baseline_year = 2014 #default value is 2011. Accepted values - any valid year or string - "current"