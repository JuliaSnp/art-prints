class StoreController < ApplicationController
    #skip_before_action :authorize
include CurrentCart
before_action :set_cart
def index
@products = Product.order(:title)
end




#to display the results of the serch to the user

 def search_results
    
      # if search parameters match, list matching items in descending order 
   #if none of the items match still display all along with the "none found" message, as per products/index.html.erb
    if params[:search]
      @products = Product.search(params[:search]).order("title DESC")
    else
      @products = Product.all.order("title DESC")
    end
 end
    
end

