require 'rails_helper'

describe Spree::StockItem do

  context 'when count on hand change' do

    let(:stock_location) { FactoryGirl.create(:stock_location_with_items) }
    subject { stock_location.stock_items.order(:id).first }

    context 'when there are still items' do
      it 'does not send an email to warn the administrators' do
        expect{
          subject.set_count_on_hand(1)
          Delayed::Worker.new.work_off
        }.to change{deliveries_with_subject("Le stock de produit pour #{subject.variant_name} est désormais vide").count}.by 0
      end
    end

    context 'when there are no items anymore' do
      it 'sends an email to warn the administrators' do
        expect{
          subject.set_count_on_hand(0)
          Delayed::Worker.new.work_off
        }.to change{deliveries_with_subject("Le stock de produit pour #{subject.variant_name} est désormais vide").count}.by 1
      end
    end
  end
end
