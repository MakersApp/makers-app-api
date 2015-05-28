require 'net/http'

class FeedbackController < ApplicationController

  def send_form(name, comments, nps, email, mailing_list)
    uri = Rails.application.secrets.google_form_url

    res = Net::HTTP.post_form(URI.parse(uri),
      'entry.1639198320' => name,
      'entry.526227826' => comments,
      'entry.2030410404' => nps,
      'entry.843495276' => email,
      'entry.1128867892' => mailing_list
      )
  end

  def new
    name = User.find_by(phone_id: params["phoneID"]).name
    comments = params["question"]
    nps = params["nps"]
    email = params["email"]
    mailing_list = params["joinMailingList"]
    send_form(name, comments, nps, email, mailing_list)
  end
end
