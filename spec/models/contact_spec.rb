require 'rails_helper'

describe Spree::Contact do

  context 'when creates' do

    before(:all) do
      FactoryGirl.create(:admin_user)
    end

    it 'send an email to warn the administrators' do
      expect{
        Spree::Contact.create!(email: 'test@test.fr', subject: "C'est un test", content: 'Test test test')
      }.to change{deliveries_with_subject('Un nouveau contact à été enregistré').count}.by 1
    end
  end
end
