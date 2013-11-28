require_relative 'test_helper'

class ResqueTest < MiniTest::Unit::TestCase
  class DummyJob
    extend Resque::Plugins::Harness
  end

  def tests_times_the_given_job
    DummyJob.around_perform_send_stats do

    end

    assert_timer "resque.resque_test.dummy_job"
  end

  def tests_logs_a_counter_of_all_jobs
    DummyJob.around_perform_send_stats do

    end

    assert_increment "resque.job"
  end

  def test_lints
    Resque::Plugin.lint Resque::Plugins::Harness
  end
end
