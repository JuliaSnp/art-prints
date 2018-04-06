require 'test_helper'

class ProductTest < ActiveSupport::TestCase
    
    #points to the fixture that we'll use in the test
    fixtures :products 
    
    #test are below
    
test "product fields must not be empty" do
product = Product.new
assert product.invalid?
assert product.errors[:title].any?
assert product.errors[:price].any?
assert product.errors[:image_url].any?
end

test "product price must be positive" do
product = Product.new(title: "Image title",
image_url: "flower.jpg")
product.price = -1
assert product.invalid?
assert_equal ["must be greater than or equal to 0.01"],
product.errors[:price]
product.price = 0
assert product.invalid?
assert_equal ["must be greater than or equal to 0.01"],
product.errors[:price]
product.price = 1
assert product.valid?
end

def new_product(image_url)
Product.new(title: "image title",
price: 1,
image_url: image_url)
end
test "image url" do
ok = %w{ tree.gif tree.jpg tree.png TREE.JPG TREE.Jpg
http://a.b.c/x/y/z/tree.gif }
bad = %w{ tree.doc tree.gif/more tree.gif.more }
ok.each do |name|

assert new_product(name).valid?, "#{name} shouldn't be invalid"
end
bad.each do |name|
assert new_product(name).invalid?, "#{name} shouldn't be valid"
end
end

test "product is not valid without a unique title" do
product = Product.new(title: products(:lake).title,
price: 2,
image_url: "tree.gif")
assert product.invalid?
assert_equal ["has already been taken"], product.errors[:title]
end

end
