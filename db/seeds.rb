# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  # 管理者
  Admin.create!(
  email: 'admin@admin',
  password: 'adminadmin'
  )

  # 会員
  7.times do |n|
      Customer.create!(
        email: "hanako#{n + 1}@test.com",
        password: "111111",
        last_name: "山田",
        first_name: "花子#{n + 1}",
        last_name_kana: "ヤマダ",
        first_name_kana: "ハナコ",
        prefecture_code: "東京都",
        city: "test",
        street: "test2",
        post_code: "0000000",
        phone_number: "09012345678",
        user_status: 0,
      )
  end
  7.times do |n|
      Customer.create!(
        email: "hana#{n + 1}@test.com",
        password: "111111",
        last_name: "山田",
        first_name: "花#{n + 1}",
        last_name_kana: "ヤマダ",
        first_name_kana: "ハナコ",
        prefecture_code: "埼玉県",
        city: "test",
        street: "test2",
        post_code: "0000000",
        phone_number: "09012345678",
        user_status: 0,
      )
  end
  15.times do |n|
      Customer.create!(
        email: "tatuo#{n + 1}@test.com",
        password: "111111",
        last_name: "山田",
        first_name: "達夫#{n + 1}",
        last_name_kana: "ヤマダ",
        first_name_kana: "ハナコ",
        prefecture_code: "東京都",
        city: "test",
        street: "test2",
        post_code: "0000000",
        phone_number: "09012345678",
        user_status: 1,
      )
  end
  15.times do |n|
      Customer.create!(
        email: "tat#{n + 1}@test.com",
        password: "111111",
        last_name: "山田",
        first_name: "達夫#{n + 1}",
        last_name_kana: "ヤマダ",
        first_name_kana: "ハナコ",
        prefecture_code: "埼玉県",
        city: "test",
        street: "test2",
        post_code: "0000000",
        phone_number: "09012345678",
        user_status: 1,
      )
  end