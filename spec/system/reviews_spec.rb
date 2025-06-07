require 'rails_helper'

RSpec.describe "レビュー機能", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:event) { FactoryBot.create(:event, user: user) }

  before do
    sign_in user
    visit root_path
  end

  scenario "ユーザーは開催済みのイベントにレビューを投稿できる" do
    visit user_event_path(user, event)

    expect {
      choose "star5"
      fill_in "コメント", with: "とても良かったです。"
      click_button "投稿"
    }.to change(Review, :count).by(1)

    expect(page).to have_content "レビューを投稿しました。"
    expect(page).to have_content "とても良かったです。"
    expect(page).to have_css(".star.filled", count: 5)
  end

  scenario "ユーザーは自身が投稿したレビューを編集できる" do
    review = FactoryBot.create(:review,
                                body: "とても良かったです。",
                                star_rating: "5",
                                user: user,
                                event: event)
    visit user_event_path(user, event)
    expect(page).to have_content "とても良かったです。"
    expect(page).to have_css(".star.filled", count: 5)

    within("#review_#{review.id}") do
      click_link "編集"
    end

    within("#review_#{review.id}") do
      choose "star3"
      fill_in "コメント", with: "まあまあでした。"
      click_button "更新"
    end

    expect(page).to have_content "レビューを更新しました。"
    expect(page).to have_content "まあまあでした。"
    expect(page).to have_css(".star.filled", count: 3)
    expect(page).to_not have_content "とても良かったです。"
  end

  scenario "ユーザーは自身が投稿したレビューを削除できる" do
    review = FactoryBot.create(:review,
                                body: "とても良かったです。",
                                star_rating: "5",
                                user: user,
                                event: event)
    visit user_event_path(user, event)
    expect(page).to have_content "とても良かったです。"
    expect(page).to have_css(".star.filled", count: 5)

    within("#review_#{review.id}") do
      click_link "削除"
    end

    expect(page).to have_content "レビューを削除しました。"
    expect(page).to_not have_content "とても良かったです。"
    expect(page).to_not have_css(".star.filled", count: 5)
  end
end
