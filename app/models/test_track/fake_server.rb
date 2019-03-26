class TestTrack::FakeServer
  class << self
    def split_registry
      TestTrack::Fake::SplitRegistry.instance.splits
    end

    def split_details(name)
      TestTrack::Fake::SplitDetail.new(name).details
    end

    def visitor_by_id(id)
      TestTrack::Fake::Visitor.for_id(id)
    end

    def visitor_details
      TestTrack::Fake::VisitorDetail.instance
    end

    def assignments_for_visitor_id(id)
      visitor_by_id(id).assignments
    end
  end
end
