module StateMashines::ReportStateMashine
  extend ActiveSupport::Concern
  included do
    state_machine :state, initial: :new do
      event :start do
        transition new: :in_process
      end
      event :finish do
        transition in_process: :done
      end
    end
  end
end
