require 'csv'
require 'pry'
require '###'

users_to_load = User.joins(:authentications).joins(:user_setting)
.where('user_settings.linkedin_info IS NOT NULL')

CSV.open("##{#}/linkedin_data.csv", "r+") do |csv|
  csv << ["user_id", "location", "picture-url", "public-profile-url", "headline", "summary", "title1", "company_id_1", "title2", "company_id_2",
    "title3", "company_id_3", "title4", "company_id_4", "title5", "company_id_5", "title6", "company_id_6"]
  users_to_load.find_each do |user|
    p = LinkedinInfoParser.new(user)

    row = [p.user_id, p.address, p.picture_url, p.public_profile_url, p.headline, p.summary]
    _positions = (0..5).to_a.each_with_object([]) {|num, a| a << p.titles[num] << p.company_ids[num] }
    row = row.concat _positions

    csv << row
  end
end
