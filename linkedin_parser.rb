require 'json'
require 'pry'

class LinkedinInfoParser
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def user_id
    user.id
  end

  def address
    user.location.address
  end

  def picture_url
    user.social_media_image_url
  end

  def public_profile_url
    user.user_setting.linkedin
  end

  def _total
    positions["_total"]
  end

  def values
    positions["values"]
  end

  def titles
    values.map { |x| x["title"] }
  end

  def company_ids
    values.map { |x| x["company"]["id"] }
  end

  def linkedin_info
    user.user_setting.linkedin_info
  end

  def method_missing(method_name, *args)
    linkedin_info.send(:[], method_name)
  end
end
