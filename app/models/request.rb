class Request < ApplicationRecord
  belongs_to :customer
  belongs_to :dog
  has_many :applications, dependent: :destroy

  validates :dog_id, presence: true
  validates :prefecture_code, presence: true

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
