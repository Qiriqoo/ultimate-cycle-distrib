require 'rails_helper'

describe Spree::Admin::ExportsController do

  describe '#create' do

    before(:each) do
      @routes = Spree::Core::Engine.routes
      controller.stub :spree_current_user => FactoryGirl.create(:admin_user)
    end

    subject { post :create, export: { source: 'newsletters' } }

    it 'creates an Export' do
      expect{
        subject
      }.to change{Spree::Export.count}.by 1
    end

    it 'redirects to the index' do
      expect(subject).to redirect_to admin_exports_path
    end

    it 'flashes a message' do
      expect(subject.request.flash[:notice]).to_not be_nil
    end
  end
end
