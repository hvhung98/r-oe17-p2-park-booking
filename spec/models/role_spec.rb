require "rails_helper"
RSpec.describe User, type: :model do
  context "name" do
    it {is_expected.to validate_presence_of(:name)}
  end

  context "column" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
  end

end
