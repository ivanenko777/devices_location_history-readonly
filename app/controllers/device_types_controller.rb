class DeviceTypesController < ApplicationController
  before_action :set_device_model, only: [:show]

  # GET /device_types
  def index
    @device_types = DeviceType.all
  end

  # GET /device_types/1
  def show; end

  # GET /device_types/new
  def new
    @device_type = DeviceType.new
  end

  # POST /device_type

  def create
    @device_type = DeviceType.new(device_type_params)
    if @device_type.save
      redirect_to @device_type, notice: 'Device manufacturer was successfully created.'
    else
      render :new
    end
  end

  private

  def set_device_model
    @device_type = DeviceType.find(params[:id])
  end

  def device_type_params
    params.require(:device_type).permit(:sys_name, :name)
  end
end
