class ChargesController < ApplicationController
before_action :check_charged, only: [:create]
before_action :authenticate_user!
after_action only: [:create] {Charge.user_pay_bet_in_tournament(current_user, @tournament, @charge)}

  def create
    #in cents - US$10.00
    @amount = 1000

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source => params[:stripeToken]
    )

    @charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => @amount,
      :description => 'Rails Stripe customer',
      :currency => 'usd'
    )
    respond_to do |format|
      format.html { redirect_to tournaments_url, notice: "You payed for #{@tournament.name} tournament."}
    end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

  def check_charged
    @tournament = Tournament.find(params[:tournament_id])
    if !Charge.already_payed(current_user, @tournament).blank?
      respond_to do |format|
        format.html { redirect_to tournaments_url, alert: 'You already pay for this tournament'}
      end
    end
  end
end
