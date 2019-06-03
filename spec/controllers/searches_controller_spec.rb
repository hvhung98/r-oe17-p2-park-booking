require "rails_helper"

RSpec.describe SearchesController, type: :controller do
  let(:role) {FactoryBot.create(:role, id: 1)}
  let(:user) {FactoryBot.create(:user, role_id: role.id)}
  let(:parking) {FactoryBot.create(:parking_test, user_id: user.id)}

  describe "GET searches#index" do
    it "populates an array" do
      get :index
      expect(assigns(:items)).to eq([parking])
    end
    it "renders to the #index view" do
      get :index
      expect(response).to render_template :index
    end
  end
end
