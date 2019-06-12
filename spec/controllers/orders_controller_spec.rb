require "rails_helper"

RSpec.describe OrdersController, type: :controller do
  let(:role) {FactoryBot.create(:role, id: 1)}
  let(:user) {FactoryBot.create(:user, role_id: role.id)}
  let(:user2) {FactoryBot.create(:user2, role_id: role.id)}
  let(:parking) {FactoryBot.create(:parking_test, user_id: user.id)}
  let(:parking2) {FactoryBot.create(:parking_test2, user_id: user2.id)}
  let(:order2) {FactoryBot.create(:order2, user_id: user.id, orderable_id: parking2.id)}
  before {
    sign_in user
    @order1 = Order.create user_id: user2.id, car_number: "29H1-04316",
      orderable_type: "Parking", orderable_id: parking.id,
      type_booked: "Đặt theo ngày", day_booked: 2.days.ago, status: 2,
      price: 200000
  }

  describe "before_action" do
    it {is_expected.to use_before_action :set_orderable}
    it {is_expected.to use_before_action :set_order}
    it {is_expected.to use_before_action :authenticate_user!}
  end

  describe "GET orders#index" do
    context "with orderable class's name is User" do
      it "populates an array of orders" do
        get :index, params: {user_id: 1}
        expect(assigns :orders).to eq [order2]
      end

      it "renders to the #index view" do
        get :index, params: {user_id: 1}
        expect(response).to render_template :index
      end

      it "array of orders for invalid user" do
        get :index, params: {user_id: user2.id}
        is_expected.to set_flash[:danger].to("Bạn không có quyền truy cập trang này")
        expect(response).to redirect_to root_url
      end
    end

    context "with orderable class's name is Parking" do
      it "populates an array of orders" do
        get :index, params: {parking_id: parking.id}
        expect(assigns :orders).to eq [@order1]
      end

      it "renders to the #index view" do
        get :index, params: {parking_id: parking.id}
        expect(response).to render_template :index
      end

      it "array of orders for invalid parking" do
        get :index, params: {parking_id: parking2.id}
        is_expected.to set_flash[:danger].to("Bạn không có quyền truy cập trang này")
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "POST orders#create" do
    context "with valid attributes" do
      it "create new order" do
        expect{post :create, params: {parking_id: parking2.id,
          order: FactoryBot.attributes_for(:order3)}
        }.to change(Order, :count).by(1)
      end

      it "redirects to the index view" do
        post :create, params: {parking_id: parking2.id,
          order: FactoryBot.attributes_for(:order3)}
        is_expected.to set_flash[:success].to("Đặt chỗ thành công")
        expect(response).to redirect_to user_orders_path(user.id)
      end
    end

    context "with invalid attributes" do
      it "with day_booked is invalid" do
        expect{post :create, params: {parking_id: parking2.id,
          order: FactoryBot.attributes_for(:order2)}
        }.not_to change(Order, :count)
      end

      it "re-renders to the new view" do
        post :create, params: {parking_id: parking2.id,
          order: FactoryBot.attributes_for(:order2)}
        is_expected.to set_flash[:danger].to("Ngày đặt không hợp lệ")
        expect(response).to render_template :new
      end

      it "with car_number is null" do
        expect{post :create, params: {parking_id: parking2.id,
          order: FactoryBot.attributes_for(:order3, car_number: "")}
        }.not_to change(Order, :count)
      end

      it "re-renders to the new view" do
        post :create, params: {parking_id: parking2.id,
          order: FactoryBot.attributes_for(:order3, car_number: "")}
        is_expected.to set_flash[:danger].to("Đặt chỗ không thành công")
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT orders#update" do
    before {
      @order2 = Order.create user_id: user2.id, car_number: "29H1-04316",
        orderable_type: "Parking", orderable_id: parking.id,
        type_booked: "Đặt theo ngày", day_booked: Time.now + 2.days, price: 200000
    }

    it "located the requested @order" do
        put :update, params: {parking_id: parking.id, id: @order2.id,
          order: FactoryBot.attributes_for(:order2)}
        expect(assigns(:order)).to eq(@order2)
    end

    before :each do
      put :update, params: {parking_id: parking.id, id: @order2.id,
        order: FactoryBot.attributes_for(:order2)}
    end
    it "changes @order2's attributes" do
      @order2.reload
      expect(@order2.status).to eq("sending")
    end

    it "redirects to the index view" do
      is_expected.to set_flash[:success].to("Cập nhật trạng thái order thành công")
      expect(response).to redirect_to parking_orders_path(parking.id)
    end
  end
end
