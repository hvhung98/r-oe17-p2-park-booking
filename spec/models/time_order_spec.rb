require "rails_helper"
RSpec.describe TimeOrder, type: :model do
  before {@role = Role.create(id: 1, name: "normal")}
  let(:user) {FactoryBot.create :user, id: 1}
  let(:parking) {FactoryBot.create :parking, id: 1, user_id: user.id}
  let(:order) {FactoryBot.create :order,id: 1, user_id: user.id, parking_id: parking.id}
  let(:time_order) {FactoryBot.create :time_order, order_id: order.id}

  context "type" do
    it {is_expected.to validate_presence_of(:type)}
  end

  context "value" do
    it {is_expected.to validate_presence_of(:value)}
  end

  context "associations" do
    it {is_expected.to belong_to :order}
  end

 context "column" do
  it {is_expected.to have_db_column(:order_id).of_type(:integer)}
  it {is_expected.to have_db_index(:order_id)}
  it {is_expected.to have_db_column(:value).of_type(:datetime)}
  it {is_expected.to have_db_column(:type).of_type(:string)}
  end

end
