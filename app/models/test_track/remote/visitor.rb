class TestTrack::Remote::Visitor
  include TestTrack::Resource

  attribute :id
  attribute :assignments

  def self.find(id)
    result = TestTrack::Client.request(
      method: :get,
      path: "api/v1/visitors/#{id}",
      fake: fake_instance_attributes(nil)
    )

    new(result)
  end

  def self.from_identifier(identifier_type, identifier_value)
    raise "must provide an identifier_type" if identifier_type.blank?
    raise "must provide an identifier_value" if identifier_value.blank?

    result = TestTrack::Client.request(
      method: :get,
      path: "api/v1/identifier_types/#{identifier_type}/identifiers/#{identifier_value}/visitor",
      fake: fake_instance_attributes(nil)
    )

    new(result)
  end

  def self.fake_instance_attributes(_)
    {
      id: "fake_visitor_id",
      assignments: [
        TestTrack::Remote::Assignment.fake_instance_attributes(1),
        TestTrack::Remote::Assignment.fake_instance_attributes(2)
      ]
    }
  end

  def assignments=(values)
    assignments = values.map do |value|
      assignment = TestTrack::Remote::Assignment.new(value)
      assignment.clear_changes_information
      assignment
    end

    super(assignments)
  end

  def to_visitor
    TestTrack::Visitor.new(id: id, assignments: assignments)
  end
end
