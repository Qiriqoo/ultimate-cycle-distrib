require 'spec_helper'

describe Spree::Promotion::Rules::WeightTotal do
  let(:rule) { Spree::Promotion::Rules::WeightTotal.new }
  let(:order) { double(:order) }

  before { rule.preferred_weight_min = 50 }
  before { rule.preferred_weight_max = 60 }

  context "preferred operator_min set to gt and preferred operator_max set to lt" do
    before do
      rule.preferred_operator_min = 'gt'
      rule.preferred_operator_max = 'lt'
    end

    context "and item total is lower than prefered maximum weight" do

      context "and item total is higher than prefered minimum weight" do
        it "should be eligible" do
          allow(order).to receive_messages weight_total: 51
          expect(rule).to be_eligible(order)
        end
      end

      context "and item total is equal to the prefered minimum weight" do

        before { allow(order).to receive_messages weight_total: 50 }

        it "should not be eligible" do
          expect(rule).to_not be_eligible(order)
        end

        it "set an error message" do
          rule.eligible?(order)
          expect(rule.eligibility_errors.full_messages.first).
            to eq "Cette promotion n'est pas applicable sur une commande inférieur ou égale à 50.0kg"
        end
      end

      context "and item total is lower to the prefered minimum weight" do
        before { allow(order).to receive_messages weight_total: 49 }

        it "should not be eligible" do
          expect(rule).to_not be_eligible(order)
        end

        it "set an error message" do
          rule.eligible?(order)
          expect(rule.eligibility_errors.full_messages.first).
            to eq "Cette promotion n'est pas applicable sur une commande inférieur ou égale à 50.0kg"
        end
      end
    end

    context "and item total is equal to the prefered maximum weight" do
      before { allow(order).to receive_messages weight_total: 60 }

      it "should not be eligible" do
        expect(rule).to_not be_eligible(order)
      end

      it "set an error message" do
        rule.eligible?(order)
        expect(rule.eligibility_errors.full_messages.first).
          to eq "Cette promotion n'est pas applicable sur une commande supérieur à 60.0kg"
      end
    end

    context "and item total is higher than the prefered maximum weight" do
      before { allow(order).to receive_messages weight_total: 61 }

      it "should not be eligible" do
        expect(rule).to_not be_eligible(order)
      end

      it "set an error message" do
        rule.eligible?(order)
        expect(rule.eligibility_errors.full_messages.first).
          to eq "Cette promotion n'est pas applicable sur une commande supérieur à 60.0kg"
      end
    end

  end

  context "preferred operator set to gt and preferred operator_max set to lte" do
    before do
      rule.preferred_operator_min = 'gt'
      rule.preferred_operator_max = 'lte'
    end

    context "and item total is lower than prefered maximum weight" do

      context "and item total is higher than prefered minimum weight" do
        it "should be eligible" do
          allow(order).to receive_messages weight_total: 51
          expect(rule).to be_eligible(order)
        end
      end

      context "and item total is equal to the prefered minimum weight" do

        before { allow(order).to receive_messages weight_total: 50 }

        it "should not be eligible" do
          expect(rule).to_not be_eligible(order)
        end

        it "set an error message" do
          rule.eligible?(order)
          expect(rule.eligibility_errors.full_messages.first).
            to eq "Cette promotion n'est pas applicable sur une commande inférieur ou égale à 50.0kg"
        end
      end

      context "and item total is lower to the prefered minimum weight" do
        before { allow(order).to receive_messages weight_total: 49 }

        it "should not be eligible" do
          expect(rule).to_not be_eligible(order)
        end

        it "set an error message" do
          rule.eligible?(order)
          expect(rule.eligibility_errors.full_messages.first).
            to eq "Cette promotion n'est pas applicable sur une commande inférieur ou égale à 50.0kg"
        end
      end
    end

    context "and item total is equal to the prefered maximum weight" do
      before { allow(order).to receive_messages weight_total: 60 }

      it "should not be eligible" do
        expect(rule).to be_eligible(order)
      end
    end

    context "and item total is higher than the prefered maximum weight" do
      before { allow(order).to receive_messages weight_total: 61 }

      it "should not be eligible" do
        expect(rule).to_not be_eligible(order)
      end

      it "set an error message" do
        rule.eligible?(order)
        expect(rule.eligibility_errors.full_messages.first).
          to eq "Cette promotion n'est pas applicable sur une commande supérieur à 60.0kg"
      end
    end
  end

  context "preferred operator set to gte and preferred operator_max set to lt" do
    before do
      rule.preferred_operator_min = 'gte'
      rule.preferred_operator_max = 'lt'
    end

    context "and item total is lower than prefered maximum weight" do

      context "and item total is higher than prefered minimum weight" do
        it "should be eligible" do
          allow(order).to receive_messages weight_total: 51
          expect(rule).to be_eligible(order)
        end
      end

      context "and item total is equal to the prefered minimum weight" do

        before { allow(order).to receive_messages weight_total: 50 }

        it "should not be eligible" do
          expect(rule).to be_eligible(order)
        end
      end

      context "and item total is lower to the prefered minimum weight" do
        before { allow(order).to receive_messages weight_total: 49 }

        it "should not be eligible" do
          expect(rule).to_not be_eligible(order)
        end

        it "set an error message" do
          rule.eligible?(order)
          expect(rule.eligibility_errors.full_messages.first).
            to eq "Cette promotion n'est pas applicable sur une commande inférieur à 50.0kg"
        end
      end
    end

    context "and item total is equal to the prefered maximum weight" do
      before { allow(order).to receive_messages weight_total: 60 }

      it "should not be eligible" do
        expect(rule).to_not be_eligible(order)
      end

      it "set an error message" do
        rule.eligible?(order)
        expect(rule.eligibility_errors.full_messages.first).
          to eq "Cette promotion n'est pas applicable sur une commande supérieur à 60.0kg"
      end
    end

    context "and item total is higher than the prefered maximum weight" do
      before { allow(order).to receive_messages weight_total: 61 }

      it "should not be eligible" do
        expect(rule).to_not be_eligible(order)
      end

      it "set an error message" do
        rule.eligible?(order)
        expect(rule.eligibility_errors.full_messages.first).
          to eq "Cette promotion n'est pas applicable sur une commande supérieur à 60.0kg"
      end
    end

  end

  context "preferred operator set to gte and preferred operator_max set to lte" do
    before do
      rule.preferred_operator_min = 'gte'
      rule.preferred_operator_max = 'lte'
    end

    context "and item total is lower than prefered maximum weight" do
      context "and item total is higher than prefered minimum weight" do
        it "should be eligible" do
          allow(order).to receive_messages weight_total: 51
          expect(rule).to be_eligible(order)
        end
      end

      context "and item total is equal to the prefered minimum weight" do

        before { allow(order).to receive_messages weight_total: 50 }

        it "should not be eligible" do
          expect(rule).to be_eligible(order)
        end
      end

      context "and item total is lower to the prefered minimum weight" do
        before { allow(order).to receive_messages weight_total: 49 }

        it "should not be eligible" do
          expect(rule).to_not be_eligible(order)
        end

        it "set an error message" do
          rule.eligible?(order)
          expect(rule.eligibility_errors.full_messages.first).
            to eq "Cette promotion n'est pas applicable sur une commande inférieur à 50.0kg"
        end
      end
    end

    context "and item total is equal to the prefered maximum weight" do
      before { allow(order).to receive_messages weight_total: 60 }

      it "should not be eligible" do
        expect(rule).to be_eligible(order)
      end
    end

    context "and item total is higher than the prefered maximum weight" do
      before { allow(order).to receive_messages weight_total: 61 }

      it "should not be eligible" do
        expect(rule).to_not be_eligible(order)
      end

      it "set an error message" do
        rule.eligible?(order)
        expect(rule.eligibility_errors.full_messages.first).
          to eq "Cette promotion n'est pas applicable sur une commande supérieur à 60.0kg"
      end
    end
  end
end
