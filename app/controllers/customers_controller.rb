class CustomersController < ApplicationController
 KEYS =  [:id, :name, :registered_at, :postal_code, :phone, :videos_checked_out_count]

    def index 
      customers = Customer.all.as_json(only: KEYS.sort)  # TODO Videos checked out
      render json: customers, status: :ok
    end
  
  
    def create
      customer = Customer.new(customer_params)
  
      if customer.save
         render json: customer.as_json(only: [:id]), status: :created
         return
      else
        render json: {
            ok: false,
            errors: customer.errors.messages
          }, status: :bad_request
        return
      end
    end
  
  
  def show
      customer = Customer.find_by(id: params[:id])
  
      if customer
        render json: customer.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :videos_checked_out_count])
        return
      else
        render json: { ok: false, errors: ["Not Found"] }, status: :not_found
        return
      end
  end
    
  
    private
  
    def customer_params
      return params.require(:customer).permit(:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone, :videos_checked_out_count)
    end

 end