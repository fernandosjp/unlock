class Gateway < ActiveRecord::Base
  belongs_to :initiative
  validates :module_name, uniqueness: { scope: :initiative_id }
  validates_presence_of :initiative, :module_name
  store_accessor :settings

  after_initialize :include_gateway_module

  state_machine initial: :draft do

    state :draft
    state :sandbox
    state :production

    # TODO: only enable this event if the gateway has a sandbox configuration. Delegate this to the gateway to decide
    event :use_sandbox do
      transition [:draft, :production] => :sandbox
    end

    event :use_production do
      transition [:draft, :sandbox] => :production
    end

    event :revert_to_draft do
      transition [:sandbox, :production] => :draft
    end

  end

  private

  def include_gateway_module
    return unless module_name = self.module_name
    class_eval do
      include "#{module_name}::ActiveRecord::Gateway".constantize
    end
  end

end
