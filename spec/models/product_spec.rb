require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "product saves  successfully" do
    product = Product.new(name: 'tomato', price: 8.5, quantity: 12, category: Category.new(name: 'vegetables'))
    product.validate
    expect(product.errors.full_messages).to be_empty
  end
  it "gives an error without name" do
    product = Product.new(price: 8.5, quantity: 12, category: Category.new(name: 'vegetables'))
    product.validate
    expect(product.errors.full_messages).to include("Name can't be blank")
end
it "gives an error without price" do
  product = Product.new(name: 'tomato', quantity: 12, category: Category.new(name: 'vegetables'))
  product.validate
  expect(product.errors.full_messages).to include("Price can't be blank")
end
it "gives an error without quantiyt" do
  product = Product.new(name: 'tomato',price: 8.5, category: Category.new(name: 'vegetables'))
  product.validate
  expect(product.errors.full_messages).to include("Quantity can't be blank")
end
it "gives an error without category" do
  product = Product.new(name: 'tomato', price: 8.5, quantity: 12)
  product.validate
  expect(product.errors.full_messages).to include("Category must exist")
end
end
end