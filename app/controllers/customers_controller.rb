class CustomersController < ApplicationController
  before_action :require_customer_logged_in, only: [:index, :show]
  
  def index
    @customers = Customer.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(user_params)

    if @customer.save
      flash[:success] = 'ユーザ登録、完了！！'
      redirect_to @customer
    else
      flash.now[:danger] = 'ごめんなさい。ユーザ登録できませんでした。'
      render :new
    end
  end

  private

  def user_params
    params.require(:customer).permit(:name, :email, :password, :password_confirmation)
  end  
  
end
