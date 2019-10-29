module Errors
  # My custome error for circular dependency
  class CircularDependency < StandardError
    def initialize(msg = "Jobs can’t have circular dependencies")
      super(msg)
    end
  end
end

