class ReviewsController < ApplicationController
  before_action :set_review, only: [ :edit, :update, :destroy ]
  before_action :set_event

  def create
    @review = current_user.reviews.create!(review_params)
    flash[:notice] = "レビューを投稿しました。"
    redirect_to user_event_path(@event.user, @event)
  end

  def edit
    render partial: "reviews/edit_form", locals: { review: @review, event: @event }
  end

  def update
    if @review.update(review_params)
      flash[:notice] = "レビューを更新しました。"
      redirect_to user_event_path(@event.user, @event)
    else
      flash.now[:danger] = "レビューを更新できませんでした。"
      respond_to do |format|
        format.turbo_stream do
          render partial: "reviews/edit_form", formats: [ :html ], locals: { review: @review, event: @event }, status: :unprocessable_entity
        end
        format.html do
          render partial: "reviews/edit_form", locals: { review: @review, event: @event }, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @review.destroy!
    flash[:notice] = "レビューを削除しました。"
    redirect_to user_event_path(@event.user, @event)
  end

  private

    def review_params
      params.require(:review).permit(:body, :star_rating).merge(event_id: params[:event_id])
    end

    def set_review
      @review = current_user.reviews.find(params[:id])
    end

    def set_event
      @event = Event.find(params[:event_id])
    end
end
