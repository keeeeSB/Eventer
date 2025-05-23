require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { FactoryBot.create(:event) }

  it "ファクトリーが正常に動く" do
    expect(FactoryBot.build(:event)).to be_valid
  end

  describe "バリデーションのテスト" do
    it "タイトルは必須である" do
      event.title = " "
      expect(event).to_not be_valid
    end

    it "説明文は必須である" do
      event.description = " "
      expect(event).to_not be_valid
    end

    it "開催日は必須である" do
      event.start_time = " "
      expect(event).to_not be_valid
    end

    it "開催場所は必須である" do
      event.location = " "
      expect(event).to_not be_valid
    end
  end
end
