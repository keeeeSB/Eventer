require 'rails_helper'

RSpec.describe "イベント機能", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category, name: "夏") }

  before do
    sign_in user
    visit root_path
  end

  scenario "ユーザーは新しいカテゴリーを作成し、イベントを作成できる" do
    expect {
      click_link "イベント作成"
      fill_in "タイトル", with: "花火大会"
      fill_in "説明文", with: "みんなで夏を感じましょう！"
      fill_in "開催日時", with: "2025-07-07"
      fill_in "開催場所", with: "河川敷"
      fill_in "新しいカテゴリーを作成", with: "風物詩"
      click_button "作成"

      aggregate_failures do
        expect(page).to have_content "イベントを作成しました。"
        expect(page).to have_content "花火大会"
        expect(page).to have_content "#{user.name}"
        expect(page).to have_content "風物詩"
      end
    }.to change(user.events, :count).by(1)
  end
end
