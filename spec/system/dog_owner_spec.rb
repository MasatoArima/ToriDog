require 'rails_helper'

describe "dog_owner_test", type: :system do
  # 新規登録テスト未
  let!(:dog_owner) { create(:dog_owner) }
  let!(:trimmer) { create(:trimmer) }
  let!(:dog) { create(:dog) }
  let!(:request) { create(:request) }
  let!(:application) { create(:application) }

  describe 'ユーザーログインのテスト' do
    before do
      visit new_customer_session_path
      fill_in 'customer[email]', with: dog_owner.email
      fill_in 'customer[password]', with: dog_owner.password
      click_button "ログイン"
    end

    context "Login" do
      it 'ログイン test' do
        expect(current_path).to eq root_path
      end
    end
    # ヘッダー-----------------------------------------------

    context "header_link" do
      it 'リンク test' do
        click_link "News"
        expect(current_path).to eq news_index_path
        click_link "トリマー一覧"
        expect(current_path).to eq customers_path
        click_link "愛犬ページ"
        expect(current_path).to eq dogs_path
        click_link "マイページ"
        expect(current_path).to eq customers_mypage_path
        click_link "Logout"
        expect(current_path).to eq root_path
        click_link "問い合わせ"
        expect(current_path).to eq contacts_path
      end
    end
    # -------------------------------------------------------
    # トリマ一覧---------------------------------------------

    context "customers_index" do
      before do
        visit customers_path
      end

      it 'showpage test' do
        click_link "トリマ test1"
        expect(current_path).to eq '/customers/2'
      end
      it '検索時 test' do
        fill_in 'q[last_name_or_first_name_or_last_name_kana_or_first_name_kana_or_introduction_or_info_best_cut_or_info_best_breed_cont]', with: "トリマ"
        click_button "検索"
        expect(page).to have_content 'トリマ test1'
      end
    end
    # -------------------------------------------------------
    # 愛犬ページ---------------------------------------------

    context "dog_index_page" do
      before do
        visit dogs_path
      end

      it 'showpage test' do
        click_link "犬"
        expect(current_path).to eq '/dogs/1'
      end
      it '新規登録 test' do
        click_link "愛犬登録"
        expect(current_path).to eq '/dogs/new'
      end
    end

    context "dog_show_page" do
      before do
        visit dogs_path
        click_link "犬"
      end

      it '愛犬編集リンク test' do
        expect(page).to have_content '既往歴'
        click_link "愛犬編集"
        expect(current_path).to eq '/dogs/1/edit'
      end
      it '愛犬編集 test' do
        click_link "愛犬編集"
        fill_in 'dog[medical_history]', with: "既往歴"
        click_button "変更"
        expect(current_path).to eq '/dogs/1'
        expect(page).to have_content '既往歴'
      end
      it '愛犬削除 test' do
        click_link "愛犬情報削除"
        expect(current_path).to eq '/dogs'
      end
    end
    # -------------------------------------------------------
    # マイページ---------------------------------------------

    context "mypage_show_page" do
      before do
        visit customers_mypage_path
      end

      it '依頼作成~削除テスト' do
        click_link "依頼作成"
        expect(current_path).to eq '/requests/new'
        find("option[value='1']").select_option
        click_button "依頼登録"
        expect(current_path).to eq '/requests/2'
        click_link "依頼削除"
        expect(current_path).to eq '/customers/mypage'
      end
      it '会員情報編集テスト' do
        expect(page).to have_content '飼い主'
        click_link "会員編集"
        expect(current_path).to eq '/customers/1/edit'
        fill_in 'customer[last_name]', with: "tttttt"
        click_button "情報更新"
        expect(current_path).to eq '/customers/mypage'
        expect(page).to have_content 'tttttt'
      end
      it 'is link test' do
        click_link "愛犬一覧"
        expect(current_path).to eq '/dogs'
      end
      it '退会テスト' do
        click_link "退会する"
        expect(current_path).to eq '/customers/withdraw_confirm'
        click_link "退会しない"
        expect(current_path).to eq '/customers/mypage'
      end
      it '退会確定テスト' do
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
    #------契約テスト---------
    # -------------------------------------------------------------
    # コンタクト---------------------------------------------------

    context "mypage_show_page" do
      before do
        visit contacts_path
      end

      it 'have content test' do
        fill_in 'お名前', with: Faker::Lorem.characters(number: 10)
        fill_in '要件', with: Faker::Lorem.characters(number: 10)
        fill_in 'メッセージ', with: Faker::Lorem.characters(number: 50)
        click_button '送信する'
        expect(current_path).to eq '/'
      end
    end
    # -------------------------------------------------------------
  end
end
