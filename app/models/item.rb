class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  belongs_to :genre, optional: true

  has_one_attached :image

  validates :image,           presence: true
  validates :name,            presence: true
  validates :text,            presence: true
  validates :genre_id,        presence: true
  validates :non_taxed_price, presence: true

  def add_tax_non_taxed_price
    (self.non_taxed_price * 1.10).round
  end

  def with_tax_price
    (non_taxed_price*1.1).floor
  end
  
  def self.looks(word)
    if word.blank?
      @item = Item.all
    else
      @item = Item.where("name LIKE?", "%#{word}%")
    end
  end

end
