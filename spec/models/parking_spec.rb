require "rails_helper"
RSpec.describe Parking, type: :model do
  let(:role) {FactoryBot.create(:role)}
  let(:user) {FactoryBot.create(:user, role_id: role.id)}
  let(:user2) {FactoryBot.create(:user2, role_id: role.id)}
  let(:parking) {FactoryBot.create :parking, user_id: user.id}
  subject {parking}

  context "name" do
    it {is_expected.to validate_presence_of(:name)}
    it {is_expected.to validate_uniqueness_of(:name)}
    context "valid" do
      it {is_expected.to validate_length_of(:name).is_at_most(Settings.name_max)}
    end
    context "invalid" do
      before {subject.name = "a" * 50}
      it {is_expected.not_to be_valid}
    end
  end

  context "total_position" do
    it {is_expected.to validate_presence_of(:total_position)}
    context "valid" do
      it {is_expected.to be_valid}
    end
    context "invalid" do
      before {subject.total_position = 0}
      it {is_expected.not_to be_valid}
    end
  end

  context "longitude"do
    it {is_expected.to validate_presence_of(:longitude)}
  end

  context "latitude"do
    it {is_expected.to validate_presence_of(:longitude)}
  end

  context "address" do
    it {is_expected.to validate_presence_of(:address)}
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
    it {is_expected.to have_many :orders}
    it {is_expected.to have_many :users}
  end

  context "column" do
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_index(:user_id)}
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:description).of_type(:text)}
    it {is_expected.to have_db_column(:waiting_time).of_type(:string)}
    it {is_expected.to have_db_column(:total_position).of_type(:integer)}
    it {is_expected.to have_db_column(:avail_position).of_type(:integer)}
    it {is_expected.to have_db_column(:longitude).of_type(:decimal)}
    it {is_expected.to have_db_column(:latitude).of_type(:decimal)}
    it {is_expected.to have_db_column(:address).of_type(:string)}
    it {is_expected.to have_db_column(:status).of_type(:string)}
    it {is_expected.to have_db_column(:price).of_type(:integer)}
    it {is_expected.to have_db_column(:time_open).of_type(:time)}
    it {is_expected.to have_db_column(:time_close).of_type(:time)}
  end

  describe "scope" do
    before :each do
      @park1 = Parking.create(user_id: user.id, name: "B1", waiting_time: "30 phut",
        description: "OK", total_position: 50, avail_position: 50,
        longitude: 102.5789, latitude: 27.0123, address: "HN", time_open: Time.now,
        time_close: Time.now, price: 200000, created_at: Time.now)
      @park2 = Parking.create(user_id: user2.id, name: "B2", waiting_time: "30 phut",
        description: "OK", total_position: 50, avail_position: 50,
        longitude: 103.5789, latitude: 27.1123, address: "HN", time_open: Time.now,
        time_close: Time.now, price: 220000, created_at: 6.hours.ago)
    end
    it "order by time" do
      expect(Parking.all.order_by_time).to eq [@park1, @park2]
    end
  end
end
