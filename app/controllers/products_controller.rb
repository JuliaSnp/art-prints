class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
   # http://www.rymcmahon.com/articles/2
   # if search parameters match, list matching items in descending order 
   #if none of the items match still display all along with the "none found" message, as per products/index.html.erb
    if params[:search]
      @products = Product.search(params[:search]).order("title DESC")
    else
      @products = Product.all.order("title DESC")
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
 def update
respond_to do |format|
if @product.update(product_params)
format.html { redirect_to @product,
notice: 'Product was successfully updated.' }
format.json { render :show, status: :ok, location: @product }

 @products = Product.all
 ActionCable.server.broadcast 'products',
 html: render_to_string('store/index', layout: false)
else
format.html { render :edit }
format.json { render json: @product.errors,
status: :unprocessable_entity }
end
end
 end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url,
          notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :artist, :category, :image_url, :price, :tag1, :tag2, :tag3, :tag4)
    end
    
    def who_bought
      @product = Product.find(params[:id])
      @latest_order = @product.orders.order(:updated_at).last 
      if stale?(@latest_order)
        respond_to do |format| 
          format.atom
        end
      end
    end
  end