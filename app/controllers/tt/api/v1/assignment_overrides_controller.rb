class Tt::Api::V1::AssignmentOverridesController < Tt::Api::V1::ApplicationController
  def create
    visitor = TestTrack::FakeServer.visitor_by_id(params[:visitor_id])
    visitor.save_assignment_override(create_params)
    head :no_content
  end

  def create_params
    params.permit(:visitor_id, :split_name, :variant, :mixpanel_result, :context)
  end
end
