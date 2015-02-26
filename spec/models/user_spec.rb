require 'rails_helper'

describe Spree::User do

  context 'when new user sign up' do
    let(:user) { FactoryGirl.build(:user) }

    before(:all) do
      FactoryGirl.create(:admin_user)
    end

    it 'is inactive by default' do
      user.save!
      expect(user.active).to eq(false)
    end

    it 'has not the admin role' do
      user.save!
      expect(user.spree_roles.map(&:name)).not_to include('admin')
    end

    it 'send an email to warn the administrators' do
      expect{
        user.save!
      }.to change{deliveries_with_subject("Un nouvel utilisateur viens de s'inscrire").count}.by 1
    end
  end

  context 'when creates an admin' do
    let(:admin) { FactoryGirl.build(:admin_user) }

    it 'is active by default' do
      admin.save!
      expect(admin.active).to eq(true)
    end

    it 'has the admin role' do
      admin.save!
      expect(admin.spree_roles.map(&:name)).to include('admin')
    end

    it 'does not send an email to warn the administrators' do
      expect{
        admin.save!
      }.to change{deliveries_with_subject("Un nouvel utilisateur viens de s'inscrire").count}.by 0
    end
  end
end