require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it "ファクトリーが正常に動く" do
    expect(FactoryBot.build(:user)).to be_valid
  end
end
