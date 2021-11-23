require 'rails_helper'

describe "dog_owner_test", type: :system do

  # 新規登録テスト未
  let!(:dog_owner) { create(:dog_owner) }
  let!(:trimmer) { create(:trimmer) }
  let!(:dog) { create(:dog) }

  describe 'ユーザーログインのテスト' do
    before do
      visit new_customer_session_path
      fill_in 'customer[email]', with: dog_owner.email
      fill_in 'customer[password]', with: dog_owner.password
      click_button "ログイン"
    end

    context "Login" do
      it 'is login test' do
        expect(current_path).to eq root_path
      end
    end
# ヘッダー--------------------------------------------------------
    context "header_link" do
      it 'is link test' do
        click_link "News"
        expect(current_path).to eq news_index_path
        click_link "トリマー一覧"
        expect(current_path).to eq customers_path
        click_link "愛犬ページ"
        expect(current_path).to eq dogs_path
        click_link "Logout"
        expect(current_path).to eq root_path
        click_link "問い合わせ"
        expect(current_path).to eq contacts_path
      end
    end
# -----------------------------------------------------------------
# トリマ一覧--------------------------------------------------------
    context "customers_index" do
      before do
        visit customers_path
      end
      it 'is link test' do
        click_link "飼い主 test1"
        expect(current_path).to eq '/customers/2'
      end
    end
# -----------------------------------------------------------------
# 愛犬ページ--------------------------------------------------------
    context "dog_index_page" do
      before do
        visit dogs_path
      end
      it 'is link test' do
        click_link "犬"
        expect(current_path).to eq '/dogs/1'
      end
      it 'is link test' do
        click_link "愛犬登録"
        expect(current_path).to eq '/dogs/new'
      end
    end

    context "dog_show_page" do
      before do
        visit dogs_path
        click_link "犬"
      end
      it 'is link test' do
        click_link "愛犬編集"
        expect(current_path).to eq '/dogs/1/edit'
      end
      it 'is link test' do
        click_link "愛犬情報削除"
        expect(current_path).to eq '/dogs'
      end
    end
# -----------------------------------------------------------------
# マイページ--------------------------------------------------------
    context "mypage_show_page" do
      before do
        visit customers_mypage_path
      end
      it 'is link test' do
        click_link "依頼作成"
        expect(current_path).to eq '/requests/new'
      end
      it 'is link test' do
        click_link "会員編集"
        expect(current_path).to eq '/customers/1/edit'
      end
      it 'is link test' do
        click_link "愛犬一覧"
        expect(current_path).to eq '/dogs'
      end
      it 'is link test' do
        click_link "退会する"
        expect(current_path).to eq '/customers/withdraw_confirm'
        click_link "退会しない"
        expect(current_path).to eq '/customers/mypage'
      end
      it 'is link test' do
        click_link "退会する"
        expect(current_path).to eq '/customers/withdraw_confirm'
        click_link "退会する"
        expect(current_path).to eq '/'
        customer = Customer.first
        expect(customer.is_deleted).to eq true
      end
      it 'have content test' do
        expect(page).to have_content "犬"
      end
    end
# -----------------------------------------------------------------
# コンタクト--------------------------------------------------------
    context "mypage_show_page" do
      before do
        visit contacts_path
      end
      it 'have content test' do
        fill_in 'お名前', with: Faker::Lorem.characters(number: 10)
        fill_in '要件', with: Faker::Lorem.characters(number: 10)
        fill_in 'メッセージ', with: Faker::Lorem.characters(number: 50)
        click_button '送信する'
        # ------------------
        # ダイアログクリック
        #-------------------

      end
    end
# -----------------------------------------------------------------


  end
end