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

  describe "scope" do
    before :each do
      @place = Place.create latitude: 21.0012406, longitude: 105.7938073
    end
    it "find_place" do
      expect(Place.all.find_place("21.0012406", "105.7938073")).to eq [@place]
    end
  end
end
