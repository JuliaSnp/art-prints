require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @update = {

      title: 'Nice photo',
      image_url: 'photo.jpg',
      price: 40.00
              }
  end
test "should get index" do
    get products_url
    assert_response :success
  end
  
  test "should get new" do
    get new_product_url
    assert_response :success
  end
  

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: @update }
      #post products_url, params: { product: { artist: @product.artist, category: @product.category, image_url: @product.image_url, price: @product.price, tag1: @product.tag1, tag2: @product.tag2, tag3: @product.tag3, tag4: @product.tag4, title: @product.title } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: @update }
    #patch product_url(@product), params: { product: { artist: @product.artist, category: @product.category, image_url: @product.image_url, price: @product.price, tag1: @product.tag1, tag2: @product.tag2, tag3: @product.tag3, tag4: @product.tag4, title: @product.title } }
    assert_redirected_to product_url(@product)
  end
  
  test "can't delete product in cart" do
 assert_difference('Product.count', 0) do
 delete product_url(products(:two))
 end

 assert_redirected_to products_url
 end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
