require "rails_helper"
RSpec.describe Review, type: :model do
  context "rating" do
    it {is_expected.to validate_presence_of :rating}
  end

  context "comment" do
    it {is_expected.to validate_presence_of :comment}
  end

  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :parking}
  end

  context "column" do
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_index(:user_id)}
    it {is_expected.to have_db_column(:parking_id).of_type(:integer)}
    it {is_expected.to have_db_index(:parking_id)}
    it {is_expected.to have_db_column(:rating).of_type(:integer)}
    it {is_expected.to have_db_column(:comment).of_type(:text)}
  end
end
