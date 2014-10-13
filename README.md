# Lbrary
Implementation of the [Rdio web service API](http://www.rdio.com/developers/docs/web-service/index/) and the [Echo Nest API](http://developer.echonest.com/)

## Setup

### API Keys
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

### Gems
- Run `bundle install`

## Running
- Run `bundle exec rerun ruby boot.rb`
- In your browser, navigate to [http://localhost:4567](http://localhost:4567)

## To-do
- Lots...