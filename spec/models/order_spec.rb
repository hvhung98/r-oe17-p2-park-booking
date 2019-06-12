require "rails_helper"
RSpec.describe Order, type: :model do
  before {@role = Role.create(id: 1, name: "normal")}
  let(:user) {FactoryBot.create :user, id: 1}
  let(:parking) {FactoryBot.create :parking, id: 1, user_id: user.id}
  let(:order) {FactoryBot.create :order, user_id: user.id, orderable_id: parking.id}
  subject {order}

  context "status" do
    it {is_expected.to validate_presence_of :status}
  end

  context "car_number" do
    it {is_expected.to validate_presence_of :car_number}
  end

  context "type_booked" do
    it {is_expected.to validate_presence_of :type_booked}
  end

  context "price" do
    it {is_expected.to validate_presence_of :price}
    context "invalid" do
      before {subject.price = 0}
      it {is_expected.not_to be_valid}
    end
  end

  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :orderable}
  end

   context "column" do
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_index(:user_id)}
    it {is_expected.to have_db_column(:car_number).of_type(:string)}
    it {is_expected.to have_db_column(:status).of_type(:integer)}
    it {is_expected.to have_db_column(:price).of_type(:integer)}
    it {is_expected.to have_db_column(:orderable_type).of_type(:string)}
    it {is_expected.to have_db_column(:orderable_id).of_type(:integer)}
  end

  describe "scope" do
    before :each do
      @order1 = Order.create user_id: user.id, car_number: "29H1-12345",
        orderable_type: "Parking", orderable_id: parking.id,
        type_booked: "Đặt theo ngày", day_booked: 2.days.ago, status: 2,
        price: 200000, created_at: 2.days.ago
      @order2 = Order.create user_id: user.id, car_number: "29H1-12345",
        orderable_type: "Parking", orderable_id: parking.id,
        type_booked: "Đặt theo ngày", day_booked: Time.now,
        price: 200000, created_at: Time.now
    end
    it "find_order" do
      expect(Order.all.find_order(parking.id, "Parking")).to eq [@order1, @order2]
    end

    it "find_status" do
      expect(Order.all.find_status("Đã đặt")).to eq [@order2]
    end

    it "order by time" do
      expect(Order.all.order_by_time).to eq [@order2, @order1]
    end
  end
end
