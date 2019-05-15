require "rails_helper"
RSpec.describe Parking, type: :model do
  before {@role = Role.create(id: 1, name: "normal")}
  let(:user) {FactoryBot.create :user, id: 1}
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
    it {is_expected.to have_db_column(:status).of_type(:boolean)}
    it {is_expected.to have_db_column(:price).of_type(:integer)}
    it {is_expected.to have_db_column(:time_open).of_type(:time)}
    it {is_expected.to have_db_column(:time_close).of_type(:time)}
  end

end
