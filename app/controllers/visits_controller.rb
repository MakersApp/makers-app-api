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
    visit = Visit.find(params[:id])
    visit.update(visit_params)
    @visitor_name = (User.find(visit.user_id)).name
    notify_slack
  end

  def visit_params
    params.permit(:user_id, :checkedin)
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
