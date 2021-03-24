module StateMashine::ReportStateMashine
  extend ActiveSupport::Concern
  included do
    state_machine :state, initial: :new do
      event :start_work do
        transition new: :in_process
      end
      event :is_ready do
        transition in_process: :done
      end
    end
  end
end
