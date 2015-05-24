require 'net/http'

class FeedbackController < ApplicationController

  def send_form(name, enjoyed_visit, more_q, email)
    uri = Rails.application.secrets.google_form_url

    res = Net::HTTP.post_form(URI.parse(uri), 'entry.1639198320' => name, 'entry.571908240' => enjoyed_visit, 'entry.207225403' => more_q, 'entry.843495276' => email)
  end

  def new
    name = User.find_by(phone_id: params["phone_id"]).name
    enjoyed_visit = params["enjoyed"] ? "Yes" : "No"
    more_q = params["questions"]
    email = params["email"]
    send_form(name, enjoyed_visit, more_q, email)
  end
end
