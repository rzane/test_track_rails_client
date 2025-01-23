class TestTrack::Remote::SplitDetail
  include TestTrack::Resource

  attribute :name
  attribute :hypothesis
  attribute :assignment_criteria
  attribute :description
  attribute :owner
  attribute :location
  attribute :platform

  attr_reader :variant_details

  def self.from_name(name)
    result = TestTrack::Client.request(
      method: :get,
      path: "api/v1/split_details/#{name}",
      fake: fake_instance_attributes(name)
    )

    new(result)
  end

  def self.fake_instance_attributes(name)
    {
      name:,
      hypothesis: "fake hypothesis",
      assignment_criteria: "fake criteria for everyone",
      description: "fake but still good description",
      owner: "fake owner",
      location: "fake activity",
      platform: "mobile",
      variant_details: fake_variant_details
    }
  end

  def self.fake_variant_details
    [
      {
        name: "fake first variant detail",
        description: "There are FAQ links in a sidebar"
      },
      {
        name: "fake second variant detail",
        description: "There are FAQ links in the default footer"
      }
    ]
  end

  def variant_details=(values)
    @variant_details = values.map(&:symbolize_keys)
  end
end
