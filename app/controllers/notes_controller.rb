class NotesController < ApplicationController
  before_action :set_note, only: %i[ show edit update destroy ]

  def index
    filters = params[:filters]&.to_unsafe_h&.symbolize_keys
    puts "filters: #{filters}"
    if filters && filters[:title].present?
      @notes = Note.search_by_title(filters[:title])
    else
      @notes = Note.all.order(created_at: :desc)
    end

    @notes
  end

  def show
    @note = Note.find(params[:id])

  end

  def new
    @note = Note.new
  end

  def edit
  end

  def create
    @note = Note.new(note_params)

    puts "note_params: #{note_params["body"]}"

    respond_to do |format|
      if @note.save
        format.html { redirect_to notes_url, notice: "Note was successfully created." }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to notes_url, notice: "Note was successfully updated." }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: "Note was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :body)
  end
end
