class Public::CustomersController < ApplicationController

def show
  @customer = current_customer
end    

def edit
  @customer = current_customer
end

def quit
    @customer = current_customer
end

def update
  @customer = current_customer
     
	if @customer.update(customer_params)
  	flash[:success] = "登録情報を変更しました"
		redirect_to customer_path(@customer.id)
	else
  	render :edit and return
 	end
end



def out
	@customer = current_customer

  @customer.update(is_deleted: true)
  reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
end

private

def customer_params
  params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :phone_numbar)
end


end
