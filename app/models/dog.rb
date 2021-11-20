class Dog < ApplicationRecord
  belongs_to :customer
  has_many :request

  has_one_attached :dog_image
  has_many_attached :trimming_images

  validates :name, presence: true
  validates :name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力してください" }
  validates :breed, presence: true
  validates :size, presence: true
  validates :inoculation_date, format: { with: /\A\d{8}\z/, message: "は8桁で入力してください" }, unless: -> { inoculation_date.blank? }
  validates :birthday, format: { with: /\A\d{8}\z/, message: "は8桁で入力してください" }
  validates :sex, inclusion: { in: [true, false] }
  validates :is_inoculate, inclusion: { in: [true, false] }

  def age
    ((Date.today.strftime("%Y%m%d").to_i - self.birthday.to_i) / 10000).to_s + "才"
  end

  def birth_day
    self.birthday.slice(0..3) + "年" + self.birthday.slice(4..5) + "月" + self.birthday.slice(6..7) + "日"
  end
  
  def inoculation_day
    self.birthday.slice(0..3) + "年" + self.birthday.slice(4..5) + "月" + self.birthday.slice(6..7) + "日"
  end

  # enum使用
  enum size: { large: 0, medium: 1, small: 2 }
end
