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
end
