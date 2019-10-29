module Errors
  # Custom error for itself dependency
  class ItselfDependent < StandardError
    def initialize(msg = "Job can’t depend on themselves")
      super(msg)
    end
  end
end

