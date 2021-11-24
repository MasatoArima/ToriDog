class Application < ApplicationRecord
  belongs_to :customer
  belongs_to :request

  # 1対1の記述ー－－－－－－
  belongs_to :contract, optional: true
  # ー－－－－－－－－－－－

  def preferred_dates
    if first_preferred_date.nil?
      "指定なし"
    elsif last_preferred_date.nil?
      first_preferred_date.to_s(:datetime_jp_time)
    else
      first_preferred_date.to_s(:datetime_jp_time) + "~" + last_preferred_date.to_s(:datetime_jp_time)
    end
  end
end
