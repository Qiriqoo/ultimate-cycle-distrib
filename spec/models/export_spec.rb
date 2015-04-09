require 'rails_helper'

describe Spree::Export do

  describe 'when creates' do

    shared_examples 'Export data' do

      it 'creates a job in the right queue' do
        expect{
          subject
        }.to change{Delayed::Job.count}.by 1
        expect(Delayed::Job.last.queue).to eq("#{subject.source}-exports")
      end

      it 'sends an email to the administrators' do
        expect{
          subject
          Delayed::Worker.new.work_off
        }.to change{deliveries_with_subject("Export de vos #{subject.source.capitalize} - #{Date.today.to_s}").count}.by 1
      end

      it 'sends an email with a correct attachment' do
        subject
        Delayed::Worker.new.work_off
        attachments = ActionMailer::Base.deliveries.last.attachments.map(&:filename)

        expect(attachments).to_not be_empty
        expect(attachments).to include("#{subject.source}-#{Date.today.to_s}.xlsx")
      end

      it 'updates the export to available after' do
        expect{
          subject
          Delayed::Worker.new.work_off
        }.to change {subject.reload.status}.to eq('available')
      end
    end

    describe 'when its a newsletters export' do

      it_behaves_like 'Export data' do
        subject do
          export = Spree::Export.create!(source: :newsletters)
          export.launch_export
          export
        end
      end
    end

    describe 'when its an orders export' do

      it_behaves_like 'Export data' do
        let(:order) { Spree::Order.create(email: 'test@example.com') }

        before do
          order.update_column :state, 'complete'
        end

        subject do
          export = Spree::Export.create!(source: :orders)
          export.launch_export
          export
        end
      end
    end
  end
end
