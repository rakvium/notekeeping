class SharingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note
  before_action :set_sharing, only: %i[show edit update destroy]
  load_and_authorize_resource

  def index
    @sharings = Note.find_by(id: params[:note_id]).try(:sharings)
  end

  def new
    @sharing = Sharing.new(note_id: params[:note_id])
  end

  def edit; end

  def show; end

  def create
    @sharing = Sharing.new(sharing_params)

    if @sharing.save
      redirect_to note_sharings_path(note_id: @sharing.note_id)
    else
      render :edit
    end
  end

  def update
    if @sharing.update(sharing_params)
      redirect_to note_sharings_path(note_id: @sharing.note_id)
    else
      render :edit
    end
  end

  def destroy
    redirect_to note_sharings_path(note_id: @sharing.destroy.note_id)
  end

  private

  def set_note
    @note = Note.find(params[:note_id])
  end

  def set_sharing
    @sharing = Sharing.find(params[:id])
  end

  def sharing_params
    params.require(:sharing).permit(:recipient_id).merge(
      sender_id: current_user.id,
      note_id: params[:note_id]
    )
  end
end
