class VisitsController < ApplicationController

  DEFAULT_SLACK_CHANNEL = '#private_soc_channel'
  SLACK_USERNAME = "webhookbot"
  USERNAME_ICON = ":sanjsanj:"

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
    slack_webhook = Rails.application.secrets.slack_webhook
    notifier = Slack::Notifier.new slack_webhook,
                                   channel: DEFAULT_SLACK_CHANNEL,
                                   username: SLACK_USERNAME,
                                   icon_emoji: USERNAME_ICON,
                                   link_names: 1
    grab_slack_details
    notifier.ping @slack_details
  end

  def grab_slack_details
    visitor_name = (User.find_by(phone_id: visit_params["phone_id"])).name
    team_member = @visit_to_update.team_member
    @slack_details = "Hello @#{team_member}, #{visitor_name} has arrived"
    render json: @slack_details
  end
end
