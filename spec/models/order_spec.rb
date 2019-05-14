require "rails_helper"
RSpec.describe Order, type: :model do
  before {@role = Role.create(id: 1, name: "normal")}
  let(:user) {FactoryBot.create :user, id: 1}
  let(:parking) {FactoryBot.create :parking, id: 1, user_id: user.id}
  let(:order) {FactoryBot.create :order, user_id: user.id, parking_id: parking.id}
  subject {order}

  context "status" do
    it {is_expected.to validate_presence_of :status}
  end

  context "price" do
    it {is_expected.to validate_presence_of :price}
    context "invalid" do
      before {subject.price = 0}
      it {is_expected.not_to be_valid}
    end
  end

  context "associations" do
    it {is_expected.to belong_to :parking}
    it {is_expected.to belong_to :user}
    it {is_expected.to have_many :time_orders}
  end

   context "column" do
    it {is_expected.to have_db_column(:parking_id).of_type(:integer)}
    it {is_expected.to have_db_index(:parking_id)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_index(:user_id)}
    it {is_expected.to have_db_column(:status).of_type(:string)}
    it {is_expected.to have_db_column(:price).of_type(:integer)}

  end

end
