require 'rails_helper'

describe Spree::User do

  context 'when new user sign up' do
    let(:user) { FactoryGirl.build(:user) }

    before(:each) do
      user.save!
    end

    it 'is inactive by default' do
      expect(user.active).to eq(false)
    end

    it 'has not the admin role' do
      expect(user.spree_roles.map(&:name)).not_to include('admin')
    end

    it 'genrates an api key' do
      expect(user.spree_api_key).to_not be_nil
    end

    it 'send an email to warn the administrators' do
      expect{
        Delayed::Worker.new.work_off
      }.to change{deliveries_with_subject("Un nouvel utilisateur viens de s'inscrire").count}.by 1
    end
  end

  context 'when creates an admin' do
    let(:admin) { FactoryGirl.build(:admin_user) }

    before(:each) do
      Spree::User.admin.destroy_all
      admin.save!
    end

    it 'is inactive by default' do
      expect(admin.active).to eq(false)
    end

    it 'genrates an api key' do
      expect(admin.spree_api_key).to_not be_nil
    end

    it 'has the admin role' do
      expect(admin.spree_roles.map(&:name)).to include('admin')
    end

    it 'sends an email to warn the administrators' do
      expect{
        Delayed::Worker.new.work_off
      }.to change{deliveries_with_subject("Un nouvel administrateur est inscrit").count}.by 1
    end
  end
end
