#class LineItem < ApplicationRecord
#  belongs_to :product
#  belongs_to :cart
  
#  def total_price
#line_items.to_a.sum { |item| item.total_price }
#  end
  
#end

class LineItem < ApplicationRecord
belongs_to :order, optional: true
belongs_to :product, optional: true
belongs_to :cart

def total_price
product.price * quantity
end
end