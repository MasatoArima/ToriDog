class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :dogs, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :applications, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :assessments, class_name: "Assessment", foreign_key: "like_id", dependent: :destroy
  has_many :reverse_of_assessments, class_name: "Assessment", foreign_key: "get_like_id", dependent: :destroy

  has_many :likings, through: :assessments, source: :get_like
  has_many :likers, through: :reverse_of_assessments, source: :like

  has_one_attached :profile_image
  has_many_attached :cut_images


  # フォロー・フォロワー
  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end
  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
  end
  def following?(customer)
    followings.include?(customer)
  end

  # いいね
  def likes(customer_id)
    assessments.create(get_like_id: customer_id)
  end
  def unlikes(customer_id)
    assessments.find_by(get_like_id: customer_id).destroy
  end
  def liking?(customer)
    likings.include?(customer)
  end




  def full_name
    self.last_name + " " + self.first_name
  end

  def full_name_kana
    self.last_name_kana + " " + self.first_name_kana
  end


  #住所自動入力
  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end



  #enum使用
  enum user_status: { dog_owner: 0, trimmer: 1 }
end
