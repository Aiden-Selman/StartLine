require 'twilio-ruby'

class MessagesController < ApplicationController
  def new
  end

  def send_sms
    account_sid = ENV["TWILIO_ACCOUNT_SID"]
    auth_token = ENV["TWILIO_AUTH_TOKEN"]
    twilio_number = "+13212521946"

    client = Twilio::REST::Client.new(account_sid, auth_token)

    to = params[:phone_number]
    body = params[:message]

    message = client.messages.create(
      body: body,
      from: twilio_number,
      to: to
    )

    flash[:notice] = "SMS sent to #{to}: #{message.sid}"
    redirect_to root_path
  end
end
