require 'rails_helper'

describe Spree::Admin::NewslettersController do

  describe '#export' do

    before(:each) do
      @routes = Spree::Core::Engine.routes
      controller.stub :spree_current_user => FactoryGirl.create(:admin_user)
    end

    subject { get :export }

    it 'creates an Export' do
      expect{
        subject
      }.to change{Spree::Export.count}.by 1
    end

    it 'redirects to the index' do
      expect(subject).to redirect_to admin_newsletters_path
    end

    it 'flashes a message' do
      expect(subject.request.flash[:notice]).to_not be_nil
    end
  end
end
