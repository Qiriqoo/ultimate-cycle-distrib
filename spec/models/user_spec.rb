require 'rails_helper'

describe Spree::User do

  context 'when new user sign up' do
    let(:user) { FactoryGirl.build(:user) }

    before(:each) do
      user.spree_roles = [Spree::Role.find_by(name: 'enterprise') || create(:role, name: 'enterprise')]
    end

    it 'is inactive by default' do
      user.save!
      expect(user.active).to eq(false)
    end

    it 'send an email to warn the administrators' do
      expect{
        user.save!
      }.to change{deliveries_with_subject("Un nouvel utilisateur viens de s'inscrire").count}.by Spree::User.admin.count
    end
  end

  context 'when creates an admin' do
    let(:admin) { FactoryGirl.build(:admin_user) }

    it 'is active by default' do
      admin.save!
      expect(admin.active).to eq(true)
    end

    it 'does not send an email to warn the administrators' do
      expect{
        admin.save!
      }.to change{deliveries_with_subject("Un nouvel utilisateur viens de s'inscrire").count}.by 0
    end
  end
end
