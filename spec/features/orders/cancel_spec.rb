require 'rails_helper'

RSpec.describe("Order Show Page") do
  describe "As a registered user" do
    before(:each) do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

      @user = User.create!(name: "Batman",
                            address: "Some dark cave 11",
                            city: "Arkham",
                            state: "CO",
                            zip: "81301",
                            email: 'batmansemail@email.com',
                            password: "password")

      @order_1 = @user.orders.create!(
        name: 'Rodrigo',
        address: '2 1st St.',
        city: 'South Park',
        state: 'CO',
        zip: '84125'
      )

      @item_order = ItemOrder.create!(item: @paper, order: @order_1, quantity: 2, price: (@paper.price * 2))

      @order_2 = @user.orders.create!(
        name: 'Ogirdor',
        address: '1 2nd St.',
        city: 'Bloomington',
        state: 'IN',
        zip: '24125'
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'can cancel and order' do
      visit "/profile/orders/#{@order_1.id}"
      click_on "Cancel Order"
      expect(page).to have_content("cancelled")
      expect(current_path).to eq("/profile")
      expect(page).to have_content("Your order was cancelled")
    end
  end
  end
