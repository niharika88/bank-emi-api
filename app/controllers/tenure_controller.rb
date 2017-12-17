# app/controllers/tenure_controller.rb
class TenureController < ApplicationController
  include Response

  before_action :set_bank
  before_action :set_bank_tenure, only: [:show, :update, :destroy]

  # GET /bank/:bank_id/tenure
  def index
    @emi_info = {:bank => @bank.name,

                 :tenures => {
                   :months => @bank.tenure.month,
                   :rate => @bank.tenure.rate,
                   :minimum_amount => @bank.tenure.minimum_amount
                 }

                 }

    json_response(@emi_info)

  end

  # GET /bank/:bank_id/tenure/:id
  def show
    json_response(@tenure)
  end

  # POST /bank/:bank_id/tenure
  def create
    @bank.create_tenure!(tenure_params)
    @bank.tenure.save!
    json_response(@bank.tenure, :created)
  end

  # PUT /bank/:bank_id/tenure/:id
  def update
    @tenure.update(tenure_params)
    head :no_content
  end

  # DELETE /bank/:bank_id/tenure/:id
  def destroy
    @tenure.destroy
    head :no_content
  end

  private

  def tenure_params
    params.permit(:rate, :month, :minimum_amount)
  end

  def set_bank
    @bank = Bank.find(params[:bank_id])
  end

  def set_bank_tenure
    @tenure = @bank.tenure if @bank
  end
end
