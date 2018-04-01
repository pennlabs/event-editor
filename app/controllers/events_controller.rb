class EventsController < ApplicationController
  before_action :authenticate_event_user!, :set_type
  before_action :set_event, only: [:show, :edit, :update, :destroy, :crop_preview, :crop]

  # GET /events
  # GET /events.json
  def index
    @events = if params.key?(:q)
                Event.where(type: @type).where('name LIKE ?', "%#{params[:q]}%").order(:start_time).page params[:page]
              else
                Event.where(type: @type).order(:start_time).page params[:page]
              end
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.type = @type

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_path(@type, @event), notice: "#{helpers.event_item} was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_path, notice: "#{helpers.event_item} was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_path, notice: "#{helpers.event_item} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def crop_preview
  end

  def crop
    @event.image.reprocess!
    @event.save
    format.html { redirect_to event_path, notice: "#{helpers.event_item} was successfully updated." }
    format.json { render :show, status: :ok, location: @event }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def set_type
    @type = params[:type]
    redirect_to root_path unless @type == 'fling'
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:name, :description, :image, :start_time, :end_time, :website, :facebook, :email, :image_original_w, :image_original_h, :image_crop_x, :image_crop_y, :image_crop_w, :image_crop_h)
  end
end
