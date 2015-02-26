require 'rails_helper'

describe Spree::Admin::ContactsController do
  let(:contact) do
    Spree::Contact.create!(email: 'test@test.fr', subject: "C'est un test", content: 'Test test test')
  end

  describe '#show' do

    before(:each) do
      @routes = Spree::Core::Engine.routes
      controller.stub :spree_current_user => FactoryGirl.create(:admin_user)
      get :show, { id: contact.id }
    end

    it 'updates the contact to read' do
      expect(contact.reload.read).to eq(true)
    end
  end
end
