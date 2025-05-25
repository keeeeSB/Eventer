class EventsController < ApplicationController
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]

  def upcoming
    @events = Event.upcoming.includes(:user, :category)
  end

  def past
    @events = Event.past.includes(:user, :category)
  end

  def new
    @event = current_user.events.build
    @event.build_category
    @categories = Category.all
  end

  def create
    @event = Event.build_with_category_handling(current_user, event_params)
    if @event.save
      flash[:notice] = "イベントを作成しました。"
      redirect_to events_path
    else
      flash.now[:danger] = "イベントを作成できませんでした。"
      @event.build_category
      @categories = Category.all
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    @event.build_category
    @categories = Category.all
  end

  def update
    if @event.update(event_params)
      flash[:notice] = "イベント内容を更新しました。"
      redirect_to events_path
    else
      flash.now[:danger] = "イベント内容を更新できませんでした。"
      @event.build_category
      @categories = Category.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy!
    flash[:notice] = "イベントを削除しました。"
    redirect_to events_path
  end

  private

    def event_params
      params.require(:event).permit(:title, :description, :start_time, :location,
                                    :category_id, category_attributes: [ :name ])
    end

    def set_event
      @event = current_user.events.find(params[:id])
    end
end
