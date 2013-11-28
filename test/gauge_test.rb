require_relative 'test_helper'

class ResqueGaugeTest < MiniTest::Unit::TestCase
  def test_reports_pending_jobs
    instrumentor = Harness::ResqueGauge.new
    instrumentor.log

    assert_gauge 'resque.jobs.pending'
  end

  def test_reports_processed_jobs
    instrumentor = Harness::ResqueGauge.new
    instrumentor.log

    assert_gauge 'resque.jobs.processed'
  end

  def test_reports_failed_jobs
    instrumentor = Harness::ResqueGauge.new
    instrumentor.log

    assert_gauge 'resque.jobs.failed'
  end

  def test_reports_total_workers
    instrumentor = Harness::ResqueGauge.new
    instrumentor.log

    assert_gauge 'resque.workers.total'
  end

  def test_reports_total_workers
    instrumentor = Harness::ResqueGauge.new
    instrumentor.log

    assert_gauge 'resque.workers.working'
  end

  def test_logs_all_metrics_in_given_namespace
    instrumentor = Harness::ResqueGauge.new 'foo'
    instrumentor.log

    assert_gauge 'foo.resque.jobs.processed'
    assert_gauge 'foo.resque.jobs.pending'
    assert_gauge 'foo.resque.jobs.failed'
    assert_gauge 'foo.resque.workers.total'
    assert_gauge 'foo.resque.workers.working'
  end
end
