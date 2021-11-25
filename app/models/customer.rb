class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  belongs_to :info, optional: true
  has_many :dogs, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :applications, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries
  has_many :chats

  has_many :client_contract, class_name: "Contract", foreign_key: "client_id", dependent: :destroy
  has_many :trimmer_contract, class_name: "Contract", foreign_key: "trimmer_id", dependent: :destroy

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

  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :prefecture_code, presence: true
  validates :city, presence: true
  validates :street, presence: true
  validates :post_code, presence: true
  validates :phone_number, presence: true
  validates :user_status, presence: true

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
    last_name + " " + first_name
  end

  def full_name_kana
    last_name_kana + " " + first_name_kana
  end

  def open_addres
    prefecture_code + city
  end

  def addres
    prefecture_code.to_s + city.to_s + street.to_s + other_address.to_s
  end

    # -----------------------SQL??----------------------
    # ransacker :likers_count do
    # # Customer.left_joins(:likers).group(:id).order(Arel.sql("count(get_like_id) desc"))
    # # SELECT "customers".* FROM "customers" LEFT OUTER JOIN "assessments" ON "assessments"."get_like_id" = "customers"."id" LEFT OUTER JOIN "customers" "likers_customers" ON "likers_customers"."id" = "assessments"."like_id" GROUP BY "customers"."id" ORDER BY count(get_like_id) desc
    #   query = '(SELECT COUNT("get_like_id") FROM "customers" LEFT OUTER JOIN "assessments" ON "assessments"."get_like_id" = "customers"."id" LEFT OUTER JOIN "customers" "likers_customers" ON "likers_customers"."id" = "assessments"."like_id" GROUP BY "customers"."id")'
    #   Arel.sql(query)
    # end

  # 住所自動入力
  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  # enum使用
  enum user_status: { dog_owner: 0, trimmer: 1 }
end
