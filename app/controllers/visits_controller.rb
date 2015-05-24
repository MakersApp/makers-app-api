class VisitsController < ApplicationController
  def index
  end

  def show
  end

  def create
    @visit = Visit.new(visit_params)
    @visit.save
    render json: @visit
  end

  def update
    visit = Visit.find_by(phone_id: visit_params["phone_id"])
    visit.update(checkedin: visit_params["checkedin"])
    user = User.find_by(phone_id: visit_params["phone_id"])
    @visitor_name = user.name
    notify_slack
  end

  def visit_params
    params.permit(:team_member, :phone_id, :checkedin)
  end

  def notify_slack
    slack_webhook = "https://hooks.slack.com/services/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"
    notifier = Slack::Notifier.new slack_webhook,
                                   channel: '#private_soc_channel',
                                   username: "webhookbot",
                                   icon_emoji: ":sanjsanj:",
                                   link_names: 1
    notifier.ping "Hello @soc, #{@visitor_name} has arrived"
    render json: notifier
  end
end
