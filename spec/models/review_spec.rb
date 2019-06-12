require "rails_helper"
RSpec.describe Review, type: :model do
  let(:role) {FactoryBot.create(:role)}
  let(:user) {FactoryBot.create(:user, role_id: role.id)}
  let(:user2) {FactoryBot.create(:user2, role_id: role.id)}
  let(:user3) {FactoryBot.create(:user3, role_id: role.id)}
  let(:parking) {FactoryBot.create :parking, user_id: user.id}

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

  describe "scope" do
    before :each do
      @review1 = Review.create user_id: user2.id, parking_id: parking.id,
        rating: 2, comment: "Khong hai long", created_at: Time.now
      @review2 = Review.create user_id: user3.id, parking_id: parking.id,
        rating: 4, comment: "Hai long", created_at: 2.days.ago
    end

    it "order by time" do
      expect(Review.all.order_by_time).to eq [@review1, @review2]
    end
  end
end
