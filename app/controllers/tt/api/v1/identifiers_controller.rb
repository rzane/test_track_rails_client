class Tt::Api::V1::IdentifiersController < Tt::Api::V1::ApplicationController
  def create
    @visitor = TestTrack::FakeServer.visitor_by_id(params[:visitor_id])
  end
end
