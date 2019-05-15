require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:role) {FactoryBot.create(:role, id: 1)}
  let(:user) {FactoryBot.create(:user, role_id: role.id)}

  before {
    sign_in user
  }

  describe "before action" do
    it {is_expected.to use_before_action :authenticate_user!}
  end

  describe "GET users#show" do
    context "with valid id" do
      it "assigns the requested user to @user" do
        get :show, params: {id: user.id}
        expect(assigns(:user)).to eq(user)
      end

      it "renders to the #show view" do
        get :show, params: {id: user.id}
        expect(response).to render_template :show
      end
    end
    context "with invalid id" do
      it "not finds the requested user to @user" do
        get :show, params: {id: 2}
        expect(assigns(:user)).not_to eq(user)
      end

      it "redirects to the root_url" do
        get :show, params: {id: 2}
        is_expected.to set_flash[:danger].to("Người dùng không hợp lệ")
        expect(response).to redirect_to root_url
      end
    end
  end
end
