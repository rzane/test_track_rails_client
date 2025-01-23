class TestTrack::Remote::SplitRegistry
  include TestTrack::Resource

  CACHE_KEY = 'test_track_split_registry'.freeze

  attribute :splits
  attribute :experience_sampling_weight

  class << self
    def fake_instance_attributes(_)
      ::TestTrack::Fake::SplitRegistry.instance.to_h
    end

    def instance
      result = TestTrack::Client.request(
        method: :get,
        path: "api/v3/builds/#{TestTrack.build_timestamp}/split_registry",
        fake: fake_instance_attributes(nil)
      )

      new(result)
    end

    def reset
      Rails.cache.delete(CACHE_KEY)
    end

    def to_hash
      if TestTrack::Client.fake?
        instance.attributes.freeze
      else
        fetch_cache { instance.attributes }.freeze
      end
    rescue *TestTrack::SERVER_ERRORS => e
      Rails.logger.error "TestTrack failed to load split registry. #{e}"
      fetch_cache { nil } # cache the missing registry for 5 seconds if we can't get one
    end

    private

    def fetch_cache(&block)
      Rails.cache.fetch(CACHE_KEY, expires_in: 5.seconds, &block)
    end
  end
end
