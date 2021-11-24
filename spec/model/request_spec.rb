# frozen_string_literal: true

require 'rails_helper'

describe 'method', type: :model do
  let!(:dog_owner) { create(:dog_owner) }
  let!(:dog) { create(:dog) }
  let!(:trimmer) { create(:trimmer) }
  let!(:request1) { create(:request1) }
  let!(:request2) { create(:request2) }
  let!(:request3) { create(:request3) }

  it 'preferred_dates_method' do
    expect(request1.preferred_dates).to eq("指定なし")
    expect(request2.preferred_dates).to eq("2020/10/06 00:00")
    expect(request3.preferred_dates).to eq("2020/10/06 00:00~2020/10/07 00:00")
  end
end