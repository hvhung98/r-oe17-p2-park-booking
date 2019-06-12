require "rails_helper"

RSpec.describe ReviewsController, type: :controller do
  let(:role) {FactoryBot.create(:role, id: 1)}
  let(:user) {FactoryBot.create(:user, role_id: role.id)}
  let(:user2) {FactoryBot.create(:user2, role_id: role.id)}
  let(:parking2) {FactoryBot.create(:parking_test2, user_id: user2.id)}
  let(:order4) {FactoryBot.create(:order4, user_id: user.id, orderable_id:
    parking2.id)}
  let(:review) {FactoryBot.create(:review)}
  before {
    sign_in user
  }

  describe "before_action" do
    it {is_expected.to use_before_action :set_parking}
    it {is_expected.to use_before_action :set_review}
    it {is_expected.to use_before_action :authenticate_user!}
  end

  describe "POST orders#create" do
    context "with valid attributes" do
      it "create new review" do
        expect{post :create, params: {parking_id: parking2.id,
          review: FactoryBot.attributes_for(:review)}
        }.to change(Review, :count).by(1)
      end

      it "redirects to the parking view" do
        post :create, params: {parking_id: parking2.id,
          review: FactoryBot.attributes_for(:review)}
        is_expected.to set_flash[:success].to("Thêm đánh giá thành công")
        expect(response).to redirect_to user_parking_path(parking2.user, parking2)
      end
    end

    context "with invalid attributes" do
      it "doesn't create new review" do
        expect{post :create, params: {parking_id: parking2.id,
          review: FactoryBot.attributes_for(:invalid_review)}
        }.not_to change(Review, :count)
      end

      it "re-renders to the new view" do
        post :create, params: {parking_id: parking2.id,
          review: FactoryBot.attributes_for(:invalid_review)}
        is_expected.to set_flash[:danger].to("Thêm đánh giá thất bại")
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT reviews#update" do
    before {
      @review = FactoryBot.create(:review, user_id: user.id, parking_id: parking2.id)
    }
    context "with valid attributes" do
      before :each do
        put :update, params: {parking_id: parking2.id, id: @review.id,
          review: FactoryBot.attributes_for(:review, rating: 3, comment: "Binh thuong")}
      end
      it "located the requested @review" do
        expect(assigns(:review)).to eq(@review)
      end

      it "changes @review's attributes" do
        @review.reload
        expect(@review.rating).to eq 3
        expect(@review.comment).to eq("Binh thuong")
      end

      it "redirects to the parking view" do
        is_expected.to set_flash[:success].to("Cập nhật đánh giá thành công")
        expect(response).to redirect_to user_parking_path(parking2.user, parking2)
      end
    end

    context "with invalid attributes" do
      before :each do
        put :update, params: {parking_id: parking2.id, id: @review.id,
          review: FactoryBot.attributes_for(:invalid_review, rating: 4, comment: "")}
      end

      it "located the requested @review" do
        expect(assigns(:review)).to eq(@review)
      end

      it "does not change @review's attributes" do
        @review.reload
        expect(@review.rating).not_to eq 4
      end

      it "renders to the update view" do
        is_expected.to set_flash[:danger].to("Cập nhật đánh giá thất bại")
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE reviews#destroy" do
    it "deletes the review" do
      delete :destroy, params: {parking_id: parking2.id, id: review.id}
      is_expected.to set_flash[:success].to("Xóa đánh giá thành công")
      expect(response).to redirect_to user_parking_path(parking2.user, parking2)
    end
  end
end
