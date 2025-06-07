require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:review) { FactoryBot.create(:review) }

  it "ファクトリーが正常に動く" do
    expect(FactoryBot.build(:review)).to be_valid
  end

  describe "バリデーションのテスト" do
    it "コメントは必須である" do
      review.body = " "
      expect(review).to_not be_valid
    end

    it "5つ星評価は必須である" do
      review.star_rating = " "
      expect(review).to_not be_valid
    end
  end
end
