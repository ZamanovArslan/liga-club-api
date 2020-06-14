class ParticipationsController < ApplicationController
  before_action :set_participation, only: %i[show update destroy]

  # GET /participations
  def index
    @participations = Participation.all

    render json: @participations
  end

  # GET /participations/1
  def show
    render json: @participation
  end

  # POST /participations
  def create
    @participation = Participation.new(participation_params)

    if @participation.save
      render json: @participation, status: :created, location: @participation
    else
      render json: @participation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /participations/1
  def update
    if @participation.update(participation_params)
      render json: @participation
    else
      render json: @participation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /participations/1
  def destroy
    @participation.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_participation
    @participation = Participation.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def participation_params
    params.require(:participation).permit(:user_id, :badge_id, :confirmed?)
  end
end
