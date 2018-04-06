class Product < ApplicationRecord
    has_many :line_items
    before_destroy :ensure_not_referenced_by_any_line_item
   
   # checking of those were entered into the new product form 
    validates :title, :image_url, presence: true
    
    # price should be a number < or = 0.01
    
    validates :price, numericality: {greater_than_or_equal_to: 0.01}
    
    # to check if the title is unique
    
    validates :title, uniqueness: true
    
    # to male sure image path matches the format and file extension is valid for the purpose
    
    validates :image_url, allow_blank: true, format: {
with: %r{\.(gif|jpg|png)\Z}i,
message: 'must be a URL for GIF, JPG or PNG image.'
}

private
 # ensure that there are no line items referencing this product
 def ensure_not_referenced_by_any_line_item
 unless line_items.empty?
 errors.add(:base, 'Line Items present')
 throw :abort
 end
 end

end
