module Lbrary

  module Controllers

    class ApplicationController < Sinatra::Base

      enable :sessions
      set :root, Lbrary::APP_ROOT
      set :session_secret, "9786c91f98c44f17be6dfa8e6aa0a936"

      before do
      end

      not_found do
      end

      helpers do

        def instantiate_rdio
          access_token = session[:at]
          access_token_secret = session[:ats]
          if access_token && access_token_secret
            @rdio = Rdio.new([ENV["RDIO_CONSUMER_KEY"], ENV["RDIO_CONSUMER_SECRET"]], [access_token, access_token_secret])
          else
            redirect :logout
          end
        end

        def current_user
          unless session[:current_user]
            session[:current_user] = @rdio.call("currentUser")["result"]
          end
          session[:current_user]
        end

        def logged_in?
          !session[:current_user].nil? ? true : false
        end

      end

      get "/" do
        access_token = session[:at]
        access_token_secret = session[:ats]
        if access_token && access_token_secret
          redirect :artists
        else
          erb :login
        end
      end

      get "/artists" do
        instantiate_rdio
        response = @rdio.call("getArtistsInCollection", user: current_user["key"])
        @artists = response["result"]
        erb :artists
      end

      # get "/albums" do
      #   instantiate_rdio
      #   response = @rdio.call("getAlbumsInCollection", user: current_user["key"])
      #   @albums = response["result"]
      #   erb :albums
      # end

      # get "/tracks" do
      #   instantiate_rdio
      #   response = @rdio.call("getTracksInCollection", user: current_user["key"])
      #   @tracks = response["result"]
      #   erb :tracks
      # end

      get "/login" do
        session.clear
        rdio = Rdio.new([ENV["RDIO_CONSUMER_KEY"], ENV["RDIO_CONSUMER_SECRET"]])
        callback_url = (URI.join request.url, "/callback").to_s
        url = rdio.begin_authentication(callback_url)
        session[:rt] = rdio.token[0]
        session[:rts] = rdio.token[1]
        redirect url
      end

      get "/callback" do
        request_token = session[:rt]
        request_token_secret = session[:rts]
        verifier = params[:oauth_verifier]
        if request_token && request_token_secret && verifier
          rdio = Rdio.new([ENV["RDIO_CONSUMER_KEY"], ENV["RDIO_CONSUMER_SECRET"]], [request_token, request_token_secret])
          rdio.complete_authentication(verifier)
          session[:at] = rdio.token[0]
          session[:ats] = rdio.token[1]
          session.delete(:rt)
          session.delete(:rts)
          redirect to("/")
        else
          redirect to("/logout")
        end
      end

      get "/logout" do
        session.clear
        redirect to("/")
      end

      get "/search" do
        instantiate_rdio
        response = @rdio.call("search", query: params[:query], types: "Album,Artist,Label,MusicGenre,Playlist,Track,User")
        @search_results = response["result"]["results"]
        erb :search
      end

      get "/import" do
        erb :import
      end

      post "/import" do
        instantiate_rdio
        music = JSON.parse( IO.read("music_20141008111200.json") )
        music.each do |m|
          response = @rdio.call("search", query: m["artist"], types: "Artist")
          if response["status"] = "ok" && response["result"]["number_results"] == 0
            return "No results, mark and skip"
          elsif response["status"] = "ok" && response["result"]["number_results"] == 1
            return "Exactly one match, go ahead and add it"
          else
            return "Too many matches, needs to be narrowed down"
          end
        end
      end

    end

  end

end