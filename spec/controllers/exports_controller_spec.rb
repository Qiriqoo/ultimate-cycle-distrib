require 'rails_helper'

describe Spree::Admin::ExportsController do

  describe '#index' do

    let(:export_newsletter) do
      Spree::Export.create!(source: :newsletters, status: :available)
    end
    let(:export_order) do
      Spree::Export.create!(source: :orders)
    end

    before(:each) do
      @routes = Spree::Core::Engine.routes
      controller.stub :spree_current_user => FactoryGirl.create(:admin_user)
    end

    subject { get :index }

    it 'assigns the lastest exports date' do
      export_order
      export_newsletter
      subject

      expect(assigns(:last_exports)).to match_array(:newsletters => Spree::Export.newsletters.maximum(:created_at), :orders => nil)
    end

    it 'assigns exports in progress' do
      export_order
      subject
      expect(assigns(:exports_in_progress)).to match_array(:newsletters => false, :orders => true)
    end
  end

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
