json.array! @resources do |product|
  json.partial! 'product', product: product 
end