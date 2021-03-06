class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, only: :show

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.all.preload(:note_tags)
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
    @notes_count = @tag.notes.count
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:name)
    end
end
