class EventsController < ApplicationController
  def index
    @events = Event.includes(:user, :category).order(start_time: :asc)
  end

  def new
    @event = current_user.events.build
    @event.build_category
    @categories = Category.all
  end

  def create
    @event = Event.build_with_category_handling(current_user, event_params)
    if @event.save
      flash[:success] = "イベントを作成しました。"
      redirect_to events_path
    else
      flash.now[:danger] = "イベントを作成できませんでした。"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @event = current_user.events.find(params[:id])
  end

  def edit
    @event = current_user.events.find(params[:id])
  end

  def update
    @event = current_user.events.find(params[:id])
    if @event.update(event_params)
      flash[:success] = "イベント内容を更新しました。"
      redirect_to events_path
    else
      flash.now[:danger] = "イベント内容を更新できませんでした。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = current_user.events.find(params[:id])
    @event.destroy!
    flash[:success] = "イベントを削除しました。"
    redirect_to events_path
  end

  private

    def event_params
      params.require(:event).permit(:title, :description, :start_time, :location,
                                    :category_id, category_attributes: [ :name ])
    end
end
