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
    notify_slack if @visit_to_update.checkedin = true
  end

  def visit_params
    params.permit(:team_member, :phone_id, :checkedin)
  end

  def notify_slack
    grab_slack_webhook
  end

  def grab_slack_webhook
    grab_slack_details
    slack_webhook = Rails.application.secrets.slack_webhook
    notifier = Slack::Notifier.new slack_webhook,
                                   channel: '#private_soc_channel',
                                   username: "webhookbot",
                                   icon_emoji: ":sanjsanj:",
                                   link_names: 1
    notifier.ping "Hello @#{@slack_details[:team_member]}, #{@slack_details[:visitor_name]} has arrived"
    render json: notifier
  end

  def grab_slack_details
    user_name = User.find_by(phone_id: visit_params["phone_id"])
    team_member = @visit_to_update.team_member
    @slack_details = { visitor_name: user_name.name, team_member: team_member }
  end
end
