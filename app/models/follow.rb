class Follow < ActiveRecord::Base

  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes

  # NOTE: Follows belong to the "followable" interface, and also to followers
  belongs_to :followable, :polymorphic => true
  belongs_to :follower,   :polymorphic => true

  after_create :create_notification, :send_email

  def block!
    self.update_attribute(:blocked, true)
  end

  def create_notification
    subject = "#{follower.user_name}"
    body = "is now <b>following</b> you"
    if followable_type != 'Member'
      followable.member.notify(subject, body, self)
    else
      followable.notify(subject, body, self)
    end
  end

  def send_email
      FollowMailer.email_notification(followable, follower, self).deliver
  end
end
