class ReviewsController < ApplicationController
  before_action :set_review, only: [ :edit, :update, :destroy ]
  before_action :set_event

  def create
    @review = current_user.reviews.create!(review_params)
    flash[:notice] = "レビューを投稿しました。"
    redirect_to user_event_path(@event.user, @event)
  end

  def edit
  end

  def update
    @review.update!(review_params)
    flash[:notice] = "レビューを更新しました。"
    redirect_to user_event_path(@event.user, @event)
  end

  def destroy
    @review.destroy!
    flash[:notice] = "レビューを削除しました。"
    redirect_to user_event_path(@event.user, @event)
  end

  private

    def review_params
      params.require(:review).permit(:body, :star_rating)
    end

    def set_review
      @review = current_user.reviews.find(params[:id])
    end

    def set_event
      @event = Event.find(params[:event_id])
    end
end
