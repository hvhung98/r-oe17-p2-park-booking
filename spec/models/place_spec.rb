require "rails_helper"
RSpec.describe Place, type: :model do
  let(:place) {FactoryBot.create :place}
  subject {place}

  context "longitude" do
    it {is_expected.to validate_presence_of(:longitude)}
  end

  context "latitude" do
    it {is_expected.to validate_presence_of(:latitude)}
  end

  context "column" do
    it {is_expected.to have_db_column(:longitude).of_type(:decimal)}
    it {is_expected.to have_db_column(:latitude).of_type(:decimal)}
  end

end
