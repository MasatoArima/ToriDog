class Application < ApplicationRecord
  belongs_to :customer
  belongs_to :request

  # 1対1の記述ー－－－－－－
  # belongs_to :contract
  # ー－－－－－－－－－－－


  def preferred_dates
    if self.first_preferred_date.nil?
      "指定なし"
    elsif self.last_preferred_date.nil?
      self.first_preferred_date.to_s(:datetime_jp_time)
    else
      self.first_preferred_date.to_s(:datetime_jp_time) + "~" + self.last_preferred_date.to_s(:datetime_jp_time)
    end
  end
end
