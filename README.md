# Lbrary
Implementation of the [Rdio web service API](http://www.rdio.com/developers/docs/web-service/index/) and the [Echo Nest API](http://developer.echonest.com/)

## Setup

### Ruby
- Ensure you've installed the version of Ruby found in the `Gemfile` and `.ruby-version` ([rbenv](https://github.com/sstephenson/rbenv))

### Postgres
- Ensure you've installed PostgreSQL ([Postgres.app](http://postgresapp.com/) on OS X)
- Ensure Postgres is running

### Environment Variables
- Create a `.env` file in the project root
- Add the following keys:
  - `RDIO_CONSUMER_KEY`
  - `RDIO_CONSUMER_SECRET`
- Set the values of the above keys to the ones found in your [Rdio developer account](http://rdio.mashery.com/apps/mykeys) (or create one if needed)
- Add the following keys:
  - `ECHO_NEST_API_KEY`
  - `ECHO_NEST_CONSUMER_KEY`
  - `ECHO_NEST_CONSUMER_SECRET`
- Set the values of the above keys to the ones found in your [Echo Nest developer account](https://developer.echonest.com/account/profile)  (or create one if needed)

### Gems & Database
- Run `bundle install`
- Run `bundle exec rake db:setup` to create, migrate, and seed the database

### Redis
- Ensure you've installed Redis (`brew install redis` on OS X)
- Run `redis-client` to start Redis

## Running locally
- Run `bundle exec rerun ruby boot.rb` or `bundle exec rerun rackup config.ru`
- Run `bundle exec sidekiq -r ./boot.rb` to start Sidekiq
- In your browser, navigate to [http://localhost:4567](http://localhost:4567)

## To-do
- Investigate Echo Nest gems:
  - https://github.com/maxehmookau/echonest-ruby-api
  - https://github.com/timcase/echowrap
  - https://github.com/youpy/ruby-echonest
  - http://echowrap.com