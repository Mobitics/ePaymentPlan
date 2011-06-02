class TransactionsController < ApplicationController
  def index
    @user = User.find params[:user_id]
    @payment_profile = @user.payment_profiles.find params[:payment_profile_id]
    @transactions = @payment_profile.transactions
  end

  def new
    @user = User.find params[:user_id]
    @payment_profile = @user.payment_profiles.find params[:payment_profile_id]
    @transaction = @payment_profile.transactions.build
  end

  def create
    @user = User.find params[:user_id]
    @payment_profile = @user.payment_profiles.find params[:payment_profile_id]
    @transaction = @payment_profile.transactions.build params[:transaction]
    if @transaction.save
      redirect_to user_payment_profile_transactions_path(@user, @payment_profile)
    else
      render :new
    end
  end

end
