require 'rails_helper'

describe "dog_owner_test", type: :system do
  let!(:dog_owner) { create(:dog_owner) }
  let!(:trimmer) { create(:trimmer) }

  before do
    visit new_customer_session_path
    fill_in 'customer[email]', with: dog_owner.email
    fill_in 'customer[password]', with: dog_owner.password
    click_button "ログイン"
    visit customers_path
    click_link "トリマ test1"
  end
  it "いいねする、解除する", js: true  do
    click_link "いいねする", href: "/customers/2/assessments"
    expect(page).to have_link 'いいねを消す', href: "/customers/2/assessments"
    expect(trimmer.likers.count).to eq(1)
    click_link "いいねを消す", href: "/customers/2/assessments"
    expect(page).to have_link 'いいねする', href: "/customers/2/assessments"
    expect(trimmer.likers.count).to eq(0)
  end
  it "フォローする、解除する", js: true  do
    click_link "フォローする", href: "/customers/2/relationships"
    expect(page).to have_link 'フォロー外す', href: "/customers/2/relationships"
    expect(trimmer.followers.count).to eq(1)
    click_link "フォロー外す", href: "/customers/2/relationships"
    expect(page).to have_link 'フォローする', href: "/customers/2/relationships"
    expect(trimmer.followers.count).to eq(0)
  end
  it "フォローする、解除する", js: true  do
    click_link "chatを始める", href: "/chats/2"
    expect(current_path).to eq "/chats/2"
    fill_in "chat[message]", with: "chatテストです"
    click_button "投稿する"
    expect(page).to have_content 'chatテストです'
  end
end