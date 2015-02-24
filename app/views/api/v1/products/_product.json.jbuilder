json.id product.public_id
json.extract! product, :name, :description, :price
json.created_at product.created_at.utc.to_i unless product.created_at.nil?
json.created_at product.updated_at.utc.to_i unless product.updated_at.nil?
json.deleted true if product.deleted