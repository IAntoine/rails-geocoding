require 'dotenv/load'

class BeachesController < ApplicationController
  before_action :set_beach, only: %i[ show edit update destroy ]

  # GET /beaches
  def index
    @beaches = Beach.all
    respond_to do |format|
      format.html # Render the HTML view (if needed)
      format.json { render json: @beaches } # Render JSON data
    end
  end
  # GET /beaches/1
  def show
  end

  # GET /beaches/new
  def new
    @beach = Beach.new
  end

  # GET /beaches/1/edit
  def edit
  end

  # POST /beaches
  def create
    @beach = Beach.new(beach_params)

    if @beach.save
      redirect_to @beach, notice: "Beach was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /beaches/1
  def update
    if @beach.update(beach_params)
      redirect_to @beach, notice: "Beach was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /beaches/1
  def destroy
    @beach.destroy
    redirect_to beaches_url, notice: "Beach was successfully destroyed.", status: :see_other
  end

    def nearby
      url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522%2C151.1957362&radius=1500&type=land&keyword=beach&key=#{ENV['GOOGLE_MAPS_API_KEY']}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)

      response = https.request(request)
      puts response.read_body

      # Process the response and render the view
      # You can assign the response data to an instance variable and use it in your view
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beach
      @beach = Beach.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def beach_params
      params.require(:beach).permit(:address, :latitude, :longitude)
    end
end
