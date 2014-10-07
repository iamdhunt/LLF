class Follow < ActiveRecord::Base

  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes

  # NOTE: Follows belong to the "followable" interface, and also to followers
  belongs_to :followable, :polymorphic => true
  belongs_to :follower,   :polymorphic => true

  after_commit :create_notification, on: :create
  after_create :send_email, unless: Proc.new { |follow| follow.class.name != 'Member' }

  def block!
    self.update_attribute(:blocked, true)
  end

  def create_notification
    subject = "#{follower.user_name}"
    body = "is now following you"
    followable.notify(subject, body, self)
  end

  def send_email
      FollowMailer.email_notification(followable, follower, self).deliver
  end
end
