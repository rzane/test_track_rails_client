class Tt::Api::V1::IdentifierVisitorsController < Tt::Api::V1::ApplicationController
  def show
    # TODO map identifiers to visitors
    @visitor = TestTrack::FakeServer.visitor_by_id(SecureRandom.uuid)
  end
end
