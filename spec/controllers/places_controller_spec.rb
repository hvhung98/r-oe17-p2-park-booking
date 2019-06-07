require "rails_helper"

RSpec.describe PlacesController, type: :controller do
  let(:place) {FactoryBot.create(:place)}
  describe "POST places#create" do
    it "create new place" do
      expect {post :create, params: {place: FactoryBot.attributes_for(:place)}
      }.to change(Place, :count).by(1)
    end

    it "redirects to the place view" do
      post :create, params: {place: FactoryBot.attributes_for(:place)}
      expect(response).to redirect_to place_path(Place.last)
    end
  end

  describe "GET places#show" do
    before :each do
      get :show, params: {id: place.id}
    end

    it "assigns the requested place to @place" do
      expect(assigns(:place)).to eq(place)
    end

    it "renders to the #show view" do
      expect(response).to render_template :show
    end
  end
end
