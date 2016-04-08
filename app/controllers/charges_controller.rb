require 'amount'
class ChargesController < ApplicationController
  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card:  params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer:    customer.id,
      amount:      Amount.default,
      description: "MusicApp Premium Membership - #{current_user.email}",
      currency:    'usd'
    )

    current_user.premium!
    flash[:notice] = "Upgraded to Premium successfully, #{current_user.username}! Enjoy our Premium service."
    redirect_to root_path

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "MusicApp Premium Membership - #{current_user.email}",
      amount: Amount.default
    }
  end

  def cancel_premium
    current_user.standard!

    flash[:notice] = "You have canceled Premium service, #{current_user.username}. You are now #{current_user.role} member."
    redirect_to root_path
  end
end
