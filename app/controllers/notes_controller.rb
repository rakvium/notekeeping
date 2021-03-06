class NotesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_note, only: %i[show edit update destroy new_tag add_tag]

  # GET /notes
  # GET /notes.json
  def index
    @notes = current_user.notes + current_user.received_notes
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = current_user.notes.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_tag
    @tags = Tag.all
    @used_tags = @note.tags
  end

  def add_tag
    @note_tag = NoteTag.new(note: @note, tag_id: params[:tag_id])
    if @note_tag.save
      redirect_to @note, notice: 'Tagged!'
    else
      redirect_to new_tag_note_path(@note), alert: 'Choose a new tag!'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def note_params
    params.require(:note).permit(:text).merge(user_id: current_user.id)
  end
end
