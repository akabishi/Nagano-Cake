class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @address = Address.new
    @addresses = Address.where(customer_id: current_customer.id)
  end
  
  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    @addresses = Address.where(customer_id: current_customer.id)
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path
  end
  
  def destroy
    @addresses = Address.where(customer_id: current_customer.id)
    @address = Address.find(params[:id])
    @address.destroy
  end
  
  private
  
  def address_params
    params.require(:address).permit(:postal_code, :address, :name, :customer_id)
  end
end
