module Spree
  class Promotion
    module Rules
      class WeightTotal < PromotionRule
        preference :weight_min, :decimal, default: 100.00
        preference :operator_min, :string, default: '>'
        preference :weight_max, :decimal, default: 500.00
        preference :operator_max, :string, default: '<'


        OPERATORS_MIN = ['gt', 'gte']
        OPERATORS_MAX = ['lt','lte']

        def applicable?(promotable)
          promotable.is_a?(Spree::Order)
        end

        def eligible?(order, options = {})
          weight_total = order.weight_total

          lower_limit_condition = weight_total.send(preferred_operator_min == 'gte' ? :>= : :>, BigDecimal.new(preferred_weight_min.to_s))
          upper_limit_condition = weight_total.send(preferred_operator_max == 'lte' ? :<= : :<, BigDecimal.new(preferred_weight_max.to_s))

          eligibility_errors.add(:base, ineligible_message_max) unless upper_limit_condition
          eligibility_errors.add(:base, ineligible_message_min) unless lower_limit_condition

          eligibility_errors.empty?
        end

        private
          def ineligible_message_max
            if preferred_operator_max == 'gte'
              eligibility_error_message(:weight_total_more_than_or_equal, weight: preferred_weight_max.to_s)
            else
              eligibility_error_message(:weight_total_more_than, weight: preferred_weight_max.to_s)
            end
          end

          def ineligible_message_min
            if preferred_operator_min == 'gte'
              eligibility_error_message(:weight_total_less_than, weight: preferred_weight_min.to_s)
            else
              eligibility_error_message(:weight_total_less_than_or_equal, weight: preferred_weight_min.to_s)
            end
          end

      end
    end
  end
end
