require "rails_helper"

RSpec.describe ParkingsController, type: :controller do
  let(:role) {FactoryBot.create(:role, id: 1)}
  let(:user) {FactoryBot.create(:user, role_id: role.id)}
  let(:parking) {FactoryBot.create(:parking_test, user_id: user.id)}
  before {
    sign_in user
  }
  describe "before_action" do
    it {is_expected.to use_before_action :set_user}
    it {is_expected.to use_before_action :set_parking}
    it {is_expected.to use_before_action :authenticate_user!}
    it {is_expected.to use_before_action :set_current_user}
  end

  describe "GET parkings#index" do
    it "populates an array of parkings" do
      get :index
      expect(assigns(:parkings)).to eq([parking])
    end

    it "renders to the #index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "POST parkings#create" do
    context "with valid attributes" do
      it "create new parking" do
        expect{post :create, params: {user_id: user.id,
          parking: FactoryBot.attributes_for(:parking)}
        }.to change(Parking, :count).by(1)
      end

      it "redirects to the parking view" do
        post :create, params: {user_id: user.id,
          parking: FactoryBot.attributes_for(:parking_test)}
        is_expected.to set_flash[:success].to("Tạo bãi đỗ thành công")
        expect(response).to redirect_to user_parking_path(user, Parking.last)
      end
    end

    context "with invalid attributes" do
      it "does not save a new parking" do
        expect{post :create, params: {user_id: user.id,
          parking: FactoryBot.attributes_for(:invalid_parking_test)}
        }.not_to change(Parking, :count)
      end

      it "re-renders to the new method" do
        post :create, params: {user_id: user.id,
          parking: FactoryBot.attributes_for(:invalid_parking_test)}
        is_expected.to set_flash[:danger].to("Tạo bãi đỗ thất bại")
        expect(response).to render_template :new
      end
    end
  end

  describe "GET parkings#show" do
    before :each do
      get :show, params: {user_id: user.id, id: parking.id}
    end
    it "assigns the requested parking to @parking" do
      expect(assigns(:parking)).to eq(parking)
    end

    it "renders to the #show view" do
      expect(response).to render_template :show
    end
  end

  describe "PUT parkings#update" do
    before {
      @parking = FactoryBot.create(:parking_test, user_id: user.id)
    }
    context "with valid attributes" do
      it "located the requested @parking" do
        put :update, params: {user_id: user.id, id: @parking.id,
          parking: FactoryBot.attributes_for(:parking_test)}
        expect(assigns(:parking)).to eq(@parking)
      end

      before :each do
        put :update, params: {user_id: user.id, id: @parking.id,
          parking: FactoryBot.attributes_for(:parking, status: "Đóng cửa", user_id: user.id)}
      end
      it "changes @parking's attributes" do
        @parking.reload
        expect(@parking.name).to eq("baidoxe")
        expect(@parking.total_position).to eq(50)
        expect(@parking.status).to eq("Đóng cửa")
      end

      it "redirects to the updated parking" do
        is_expected.to set_flash[:success].to("Cập nhật bãi đỗ thành công")
        expect(response).to redirect_to user_parking_path(user, @parking)
      end
    end

    context "with invalid attributes" do
      it "located the requested @parking" do
        put :update, params: {user_id: user.id, id: @parking.id,
          parking: FactoryBot.attributes_for(:invalid_parking_test)}
        expect(assigns(:parking)).to eq(@parking)
      end

      before :each do
        put :update, params: {user_id: user.id, id: @parking.id,
          parking: FactoryBot.attributes_for(:invalid_parking_test, user_id: user.id)}
      end
      it "does not change @parking's attributes" do
        @parking.reload
        expect(@parking.waiting_time).not_to eq("50 phut")
        expect(@parking.description).not_to eq("OK")
      end

      it "re-renders to the edit view" do
        is_expected.to set_flash[:danger].to("Cập nhật bãi đỗ thất bại")
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE parkings#destroy" do
    it "deletes the parking" do
      delete :destroy, params: {user_id: user.id, id: parking.id}
      is_expected.to set_flash[:success].to("Xóa bãi đỗ thành công")
      expect(response).to redirect_to root_url
    end
  end
end
