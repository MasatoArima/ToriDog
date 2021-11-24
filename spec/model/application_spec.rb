# frozen_string_literal: true

require 'rails_helper'

describe 'method', type: :model do
  let!(:dog_owner) { create(:dog_owner) }
  let!(:dog) { create(:dog) }
  let!(:trimmer) { create(:trimmer) }
  let!(:request) { create(:request) }
  let!(:application1) { create(:application1) }
  let!(:application2) { create(:application2) }
  let!(:application3) { create(:application3) }

  it 'preferred_dates_method' do
    expect(application1.preferred_dates).to eq("指定なし")
    expect(application2.preferred_dates).to eq("2020/10/06 00:00")
    expect(application3.preferred_dates).to eq("2020/10/06 00:00~2020/10/07 00:00")
  end
end