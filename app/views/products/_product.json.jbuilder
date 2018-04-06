json.extract! product, :id, :title, :artist, :category, :image_url, :price, :tag1, :tag2, :tag3, :tag4, :created_at, :updated_at
json.url product_url(product, format: :json)
