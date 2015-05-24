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
    @visit_to_update = Visit.find_by(phone_id: visit_params["phone_id"])
    @visit_to_update.update(checkedin: true)
    @user = User.find_by(phone_id: visit_params["phone_id"])
    notify_slack if @visit_to_update.checkedin = true
  end

  def visit_params
    params.permit(:team_member, :phone_id, :checkedin)
  end

  def notify_slack
    visitor_name = @user.name
    team_member = @visit_to_update.team_member

    slack_webhook = "https://hooks.slack.com/services/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"
    notifier = Slack::Notifier.new slack_webhook,
                                   channel: '#private_soc_channel',
                                   username: "webhookbot",
                                   icon_emoji: ":sanjsanj:",
                                   link_names: 1
    notifier.ping "Hello @#{team_member}, #{visitor_name} has arrived"
    render json: notifier
  end
end
