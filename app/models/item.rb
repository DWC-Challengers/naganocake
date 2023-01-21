class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_items
  belongs_to :genre

  has_one_attached :image

  validates :image,           presence: true
  validates :name,            presence: true
  validates :text,            presence: true
  validates :genres_id,       presence: true
  validates :non_taxed_price, presence: true
  validates :is_active,       presence: true

  def add_tax_non_taxed_price
    (self.non_taxed_price * 1.10).round
  end

end
