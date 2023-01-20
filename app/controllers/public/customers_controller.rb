class Public::CustomersController < ApplicationController

def show
  @customer = current_customer
end    

def edit
  @customer = current_customer
end

def update
  @customer = current_customer
     
	if @customer.update(customer_params)
  	flash[:success] = "登録情報を変更しました"
		redirect_to customer_path
	else
  	render :edit and return
 	end
end

def quit
end

def out
	@customer = current_customer
  @customer.update(is_valid: true)
end

private

def customer_params
  params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :phone_numbar)
end


end
