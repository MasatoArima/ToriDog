class Dog < ApplicationRecord
  belongs_to :customer
  has_many :request

  has_one_attached :dog_image
  has_many_attached :trimming_images

  validates :name, presence: true
  validates :name_kana, presence: true
  validates :breed, presence: true
  validates :size, presence: true
  validates :birthday, presence: true
  validates :sex, inclusion: { in: [true, false] }
  validates :is_inoculate, inclusion: { in: [true, false] }


  #enum使用
  enum size: {large: 0, medium: 1, small: 2}
end
