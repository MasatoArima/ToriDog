class Dog < ApplicationRecord
  belongs_to :customer

  #enum使用
  enum size: { large: 0, medium: 1, small: 2 }
end
