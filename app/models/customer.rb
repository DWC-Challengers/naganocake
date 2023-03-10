class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :shipping_addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :first_name, :last_name, :first_name_kana, :last_name_kana,
            :address, :phone_number,
            presence: true
            
  validates :postal_code, length: {is: 7}, numericality: { only_integer: true }
  validates :phone_number, numericality: { only_integer: true }
  validates :is_deleted, inclusion: [true, false]
  
  def self.looks(word)
    if word.blank?
      @customer = Customer.all
    else
      @Customer = Customer.where("last_name LIKE?", "%#{word}%").or(Customer.where("first_name LIKE?", "%#{word}%")).or(Customer.where("last_name_kana LIKE?", "%#{word}%")).or(Customer.where("first_name_kana LIKE?", "%#{word}%"))
    end 
  end
  
  # 氏名（姓＋名）
  def customer_name
    customer_name = last_name + "　" + first_name
  end

  # 氏名（姓＋名（カナ））
  def customer_name_kana
    customer_name_kana = last_name_kana + "　" + first_name_kana
  end
   
  # is_deletedステータスの変換
  def customer_status
    if is_deleted == true
      is_deleted = "退会"
    else
      is_deleted = "有効"
    end
  end
  
  def self.looks(customer_status)
    if customer_status == "1"
      @customers = Customer.where(is_deleted: true)
    elsif customer_status == "0"
      @customers = Customer.where(is_deleted: false)
    else
      @customers = Customer.all
    end
  end 
  
end
