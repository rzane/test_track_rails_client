require 'faraday'

module TestTrack::Persistence
  extend ActiveSupport::Concern

  module ClassMethods
    def create!(attributes)
      new(attributes).tap(&:save!)
    end
  end

  def save
    return false unless valid?

    persist!
    true
  rescue Faraday::UnprocessableEntityError
    errors.add(:base, 'could not be saved')
    false
  end

  def save!
    save or raise(ActiveModel::ValidationError, self)
  end

  private

  def persist!
    raise NotImplementedError
  end
end
