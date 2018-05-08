module TestTrack::Controller
  extend ActiveSupport::Concern

  included do
    class_attribute :test_track_identity

    helper_method :test_track_session, :test_track_visitor
    helper TestTrack::ApplicationHelper
    around_action :manage_test_track_session
  end

  private

  def test_track_session
    @test_track_session ||= TestTrack::Session.new(self)
  end

  def test_track_visitor
    test_track_session.visitor_dsl
  end

  def manage_test_track_session
    RequestStore[:test_track_session] = test_track_session
    test_track_session.manage do
      yield
    end
  end
end
