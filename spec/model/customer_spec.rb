# frozen_string_literal: true

require 'rails_helper'

describe 'method', type: :model do
  let!(:dog_owner) { create(:dog_owner) }

  it 'full_name_method' do
    expect(dog_owner.full_name).to eq("飼い主 test1")
  end
  it 'full_name_kana_method' do
    expect(dog_owner.full_name_kana).to eq("カイヌシ テスト")
  end
  it 'open_addres_method' do
    expect(dog_owner.open_addres).to eq("福島県須賀川市")
  end
  it 'addres_method' do
    expect(dog_owner.addres).to eq("福島県須賀川市滑川")
  end
end
