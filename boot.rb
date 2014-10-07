require "dotenv"
Dotenv.load

require "sinatra"
require "./lib/om"
require "./lib/rdio"

enable :sessions
set :session_secret, "9786c91f98c44f17be6dfa8e6aa0a936"

get '/' do
  access_token = session[:at]
  access_token_secret = session[:ats]
  if access_token and access_token_secret
    redirect :artists
  else
    erb :login
  end
end

get "/artists" do
  access_token = session[:at]
  access_token_secret = session[:ats]
  if access_token and access_token_secret
    rdio = Rdio.new([ENV["RDIO_CONSUMER_KEY"], ENV["RDIO_CONSUMER_SECRET"]], [access_token, access_token_secret])
    @current_user = rdio.call('currentUser')['result']
    @artists = rdio.call("getArtistsInCollection", user: @current_user["key"])["result"]
    erb :artists
  else
    redirect :logout
  end
end

get '/login' do
  session.clear
  rdio = Rdio.new([ENV["RDIO_CONSUMER_KEY"], ENV["RDIO_CONSUMER_SECRET"]])
  callback_url = (URI.join request.url, '/callback').to_s
  url = rdio.begin_authentication(callback_url)
  session[:rt] = rdio.token[0]
  session[:rts] = rdio.token[1]
  redirect url
end

get '/callback' do
  request_token = session[:rt]
  request_token_secret = session[:rts]
  verifier = params[:oauth_verifier]
  if request_token and request_token_secret and verifier
    rdio = Rdio.new([ENV["RDIO_CONSUMER_KEY"], ENV["RDIO_CONSUMER_SECRET"]], [request_token, request_token_secret])
    rdio.complete_authentication(verifier)
    session[:at] = rdio.token[0]
    session[:ats] = rdio.token[1]
    session.delete(:rt)
    session.delete(:rts)
    redirect to('/')
  else
    redirect to('/logout')
  end
end

get '/logout' do
  session.clear
  redirect to('/')
end