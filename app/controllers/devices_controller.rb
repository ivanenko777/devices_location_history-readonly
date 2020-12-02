class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  before_action only: [:new, :create, :edit, :update] do
    # TODO: active rooms
    @device_models_for_select = DeviceModel.includes(:device_type, :device_manufacturer).order_by_default
    @rooms_for_select = Room.includes(:office).all
  end

  # GET /devices
  def index
    @devices = Device.includes(:device_model, room: :office).all
  end

  # GET /devices/1
  def show; end

  # GET /devices/new
  def new
    @device = Device.new
    @device.device_model_id = params[:device_model] if params[:device_model].present?
    @device.room_id = params[:room] if params[:room].present?
  end

  # POST /devices
  def create
    @device = Device.new(device_params)

    if @device.save && params[:commit] == 'Create and New'
      redirect_to new_device_path(device_model: @device.device_model_id, room: @device.room_id), notice: 'Device was successfully created.'
    elsif @device.save
      redirect_to @device, notice: 'Device was successfully created.'
    else
      render :new
    end
  end

  # GET /devices/1/edit
  def edit; end

  # PATCH/PUT /devices
  def update
    if @device.update(device_params)
      redirect_to @device, notice: 'Device was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /device/1
  def destroy
    # TODO: salyga pries destroy, pvz status ir t.t.
    @device.destroy
    redirect_to devices_url, notice: 'Room was successfully deleted.'
  end

  private

  def set_device
    @device = Device.find(params[:id])
  end

  def device_params
    params.require(:device).permit(:device_model_id, :room_id, :serial_no, :asset_no)
  end
end
