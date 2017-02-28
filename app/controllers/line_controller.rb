class LineController < ApplicationController
  def login
    channel_id = ENV['LINE_CHANNEL_ID']
    redirect_uri = CGI.escape('http://localhost:3000/line/callback')
    state = SecureRandom.hex
    @login_url = "https://access.line.me/dialog/oauth/weblogin?response_type=code&client_id=#{channel_id}&redirect_uri=#{redirect_uri}&state=#{state}"
  end

  def callback
    binding.pry
  end

  def get_user_profile(access_token)
    response = line_api_client.get do |req|
      req.url '/v2/profile'
      req.headers['Authorization'] = "Bearer #{access_token}"
    end
    JSON.parse(response.body)
  end

  def refresh_access_token(refresh_token)
    response = line_api_client.post do |req|
      req.url '/v2/oauth/accessToken'
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.params = {
        grant_type: 'refresh_token',
        client_id: ENV['LINE_CHANNEL_ID'],
        client_secret: ENV['LINE_CHANNEL_SECRET'],
        refresh_token: refresh_token
      }
    end
    JSON.parse(response.body)
  end

  def validate_access_token(access_token)
    response = line_api_client.post do |req|
      req.url '/v2/oauth/verify'
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.params = {
        access_token: access_token
      }
    end
    JSON.parse(response.body)
  end

  def receive_access_token
    response = line_api_client.post do |req|
      req.url '/v2/oauth/accessToken'
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.params = {
        grant_type: 'authorization_code',
        client_id: ENV['LINE_CHANNEL_ID'],
        client_secret: ENV['LINE_CHANNEL_SECRET'],
        code: params[:code],
        redirect_uri: 'http://localhost:3000/line/callback'
      }
    end
    JSON.parse(response.body)
  end

  def line_api_client
    @line_api_client = Faraday.new(:url => 'https://api.line.me') do |faraday|
      faraday.request :url_encoded # form-encode POST params
      faraday.response :logger # log requests to STDOUT
      faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end
  end
end
