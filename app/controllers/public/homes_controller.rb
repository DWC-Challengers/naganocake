class Public::HomesController < ApplicationController
  before_action :check_admin_login
    
def top
  @items=Item.all.limit(4).order("created_at DESC").where(is_active: 'true')
end 

def about
end

private

def check_admin_login
  if admin_signed_in?
    sign_out(:admin)
  end 
end

end
