require "rails_helper"
RSpec.describe User, type: :model do
  before {@role = Role.create(id: 1, name: "normal")}
  let(:user) {FactoryBot.create :user}
  subject {user}

  context "name" do
    it {is_expected.to validate_presence_of(:name)}
    it {is_expected.to validate_uniqueness_of(:name)}
    context "valid" do
      it {is_expected.to validate_length_of(:name).is_at_most(Settings.name_max)}
    end
    context "invalid" do
      before {subject.name = "a" * 50}
      it {is_expected.not_to be_valid}
    end
  end

  context "email" do
    it {is_expected.to validate_presence_of :email}
    it {is_expected.to validate_length_of(:email).is_at_most(Settings.email_max)}
    context "invalid" do
      emails = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      emails.each do |invalid_email|
        it {is_expected.not_to allow_value(invalid_email).for(:email)}
      end
      before {subject.email = FFaker::Internet.email(FFaker::Lorem.characters(255))}
      it {is_expected.not_to be_valid}
    end
    context "valid" do
      emails = %w[user@foo.COM A_US-ER@f.b.org first.last@foo.jp a+b@baz.cn]
      emails.each do |invalid_email|
        it {is_expected.to allow_value(invalid_email).for(:email)}
      end
    end
    context "unique" do
      it {is_expected.to validate_uniqueness_of(:email).case_insensitive}
    end
  end

  context "password" do
    context "valid" do
      it {is_expected.to validate_length_of(:password).is_at_least(Settings.pass_min)}
    end
    context "invalid" do
      before {subject.password = FFaker::Lorem.characters(5)}
      it {is_expected.not_to be_valid}
    end
  end

  context "associations" do
    it {is_expected.to belong_to :role}
    it {is_expected.to have_many :orders}
    it {is_expected.to have_one :parking}
    it {is_expected.to have_many :parkings}
  end

  context "column" do
    it {is_expected.to have_db_column(:role_id).of_type(:integer)}
    it {is_expected.to have_db_index(:role_id)}
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:email).of_type(:string)}
    it {is_expected.to have_db_column(:phone_number).of_type(:string)}
    it {is_expected.to have_db_column(:encrypted_password).of_type(:string)}
    it {is_expected.to have_db_column(:reset_password_token).of_type(:string)}
    it {is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime)}
    it {is_expected.to have_db_column(:remember_created_at).of_type(:datetime)}

  end

  describe "#downcase_email" do
    before :each do
      subject.email = "ADMIN123@GMAIL.COM"
    end
    it "downcase email of user before save" do
      expect(subject.send(:downcase_email)).to eq("admin123@gmail.com")
    end
  end
end
