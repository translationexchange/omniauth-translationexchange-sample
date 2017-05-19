#--
# Copyright (c) 2016 Translation Exchange, Inc.
#
#
#  _______                  _       _   _             ______          _
# |__   __|                | |     | | (_)           |  ____|        | |
#    | |_ __ __ _ _ __  ___| | __ _| |_ _  ___  _ __ | |__  __  _____| |__   __ _ _ __   __ _  ___
#    | | '__/ _` | '_ \/ __| |/ _` | __| |/ _ \| '_ \|  __| \ \/ / __| '_ \ / _` | '_ \ / _` |/ _ \
#    | | | | (_| | | | \__ \ | (_| | |_| | (_) | | | | |____ >  < (__| | | | (_| | | | | (_| |  __/
#    |_|_|  \__,_|_| |_|___/_|\__,_|\__|_|\___/|_| |_|______/_/\_\___|_| |_|\__,_|_| |_|\__, |\___|
#                                                                                        __/ |
#                                                                                       |___/
#
#
#-- ::HomeController Routing Information
#
#  get       /home                                   => index
#
#++

class OauthController < ApplicationController

  def authorize
    if params[:type] == 'password'
      client = OAuth2::Client.new(OAUTH_CLIENT_ID, OAUTH_CLIENT_SECRET, :site => OAUTH_CLIENT_URL)
      access_token = client.password.get_token(params[:username], params[:password])
      puts access_token.token
      session[:access_token] = access_token.token
      return redirect_to(controller: 'home', action: 'index')
    end

    if params[:type] == 'client_credentials'
      client = OAuth2::Client.new(OAUTH_CLIENT_ID, OAUTH_CLIENT_SECRET, :site => OAUTH_CLIENT_URL)
      access_token = client.client_credentials.get_token
      puts access_token.token
      session[:access_token] = access_token.token
      return redirect_to(controller: 'home', action: 'index')
    end

    redirect_to('/auth/translationexchange')
  end

  def clear
    session[:access_token] = nil
    redirect_to(controller: 'home', action: 'index')
  end

  def callback
    omniauth = request.env['omniauth.auth']

    pp omniauth

    session[:access_token] = omniauth[:credentials][:token]
    return redirect_to(controller: 'home', action: 'index')
  end

  def failure
    pp params

    render text: 'Failed'
  end

end
