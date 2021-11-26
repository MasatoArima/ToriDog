# frozen_string_literal: true

require 'rails_helper'

describe 'method', type: :model do
  let!(:dog_owner) { create(:dog_owner) }
  let!(:dog) { create(:dog) }

  it 'age_method' do
    expect(dog.age).to eq("2021才")
  end
  it 'birth_day_method' do
    expect(dog.birth_day).to eq("0000年00月00日(2021才)")
  end
  it 'inoculation_day_method' do
    expect(dog.inoculation_day).to eq("0000年00月00日")
  end
end
