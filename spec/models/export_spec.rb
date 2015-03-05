require 'rails_helper'

describe Spree::Export do

  before(:all) do
    FactoryGirl.create(:admin_user)
  end

  describe 'when creates' do

    describe 'when is a newsletters export' do

      subject { Spree::Export.create!(source: 'newsletters') }

      it 'creates a job in the right queue' do
        expect{
          subject
        }.to change{Delayed::Job.count}.by 1
        expect(Delayed::Job.last.queue).to eq('newsletters-exports')
      end

      it 'sends an email to the administrators' do
        expect{
          subject
          Delayed::Worker.new.work_off
        }.to change{deliveries_with_subject("Export de vos Newsletters - #{Date.today.to_s}").count}.by 1
      end

      it 'sends an email with a correct attachment' do
        subject
        Delayed::Worker.new.work_off
        attachment = ActionMailer::Base.deliveries.last.attachments.first

        expect(attachment).to_not be_nil
        expect(attachment.filename).to eq("newsletters-#{Date.today.to_s}.xlsx")
      end

      it 'updates the export to available' do
        expect{
          subject
          Delayed::Worker.new.work_off
        }.to change {subject.reload.status}.to eq('available')
      end
    end
  end

end
