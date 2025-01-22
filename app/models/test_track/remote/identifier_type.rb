class TestTrack::Remote::IdentifierType
  include TestTrack::Resource

  attribute :name

  validates :name, presence: true

  def save
    return false unless valid?

    body = { name: }
    connection.post("api/v1/identifier_type", body) unless faked?
    true
  end

  def fake_save_response_attributes
    nil # :no_content is the expected response type
  end
end
