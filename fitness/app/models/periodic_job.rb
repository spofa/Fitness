class PeriodicJob < ActiveRecord::Base
  # Runs a job and updates the +last_run_at+ field.
  def run!
    begin
      eval(self.job)
    rescue Exception
      logger.error "'#{self.job}' could not run: #{$!.message}\n#{$!.backtrace}"
    end
    self.last_run_at = Time.now.utc
    self.save

  end
end
