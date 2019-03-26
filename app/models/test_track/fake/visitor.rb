class TestTrack::Fake::Visitor
  attr_reader :id

  Assignment = Struct.new(:split_name, :variant, :unsynced, :context)

  class << self
    def visitors
      @visitors ||= Hash.new { |hash, key| hash[key] = new(key) }
    end

    def for_id(id)
      visitors[id]
    end
  end

  def initialize(id)
    @id = id
  end

  def assignments
    default_assignments.merge(assignment_overrides).values
  end

  def assignment_overrides
    @assignment_overrides ||= {}
  end

  def default_assignments
    @default_assignments ||= _default_assignments
  end

  def split_registry
    TestTrack::Fake::SplitRegistry.instance.to_h
  end

  def save_assignment_override(params)
    assignment_overrides[params[:split_name].to_s] = build_assignment(params[:split_name], params[:variant])
  end

  private

  def _default_assignments
    split_registry.keys.each_with_object({}) do |split_name, memo|
      variant = TestTrack::VariantCalculator.new(visitor: self, split_name: split_name).variant
      memo[split_name.to_s] = build_assignment(split_name, variant)
    end
  end

  def build_assignment(split_name, variant)
    Assignment.new(split_name, variant, false, "the_context")
  end
end
