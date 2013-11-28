require "resque/harness/version"
require "active_support/core_ext/string"

require 'resque'
require 'harness'

module Resque
  module Plugins
    module Harness
      def around_perform_send_stats
        job_name = name.underscore.gsub '/', '.'
        ::Harness.time "resque.#{job_name}" do
          yield
        end

        ::Harness.increment "resque.job"
      end
    end
  end
end

module Harness
  class ResqueGauge
    include Instrumentation

    def initialize(namespace = nil)
      @namespace = namespace
    end

    def log
      info = ::Resque.info

      gauge namespaced('resque.jobs.pending'), info.fetch(:pending)
      gauge namespaced('resque.jobs.processed'), info.fetch(:processed)
      gauge namespaced('resque.jobs.failed'), info.fetch(:failed)

      gauge namespaced('resque.queues.total'), info.fetch(:queues)
      gauge namespaced('resque.workers.total'), info.fetch(:workers)
      gauge namespaced('resque.workers.working'), info.fetch(:working)

      ::Resque.queues.each do |queue|
        gauge namespaced("resque.queues.#{queue}.depth"), ::Resque.size(queue)
      end
    end

    private
    def namespaced(name)
      [@namespace, name].compact.join '.'
    end
  end
end
