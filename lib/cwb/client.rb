module Cwb
  class Client
    def attribute(*args)
      ""
    end

    def submit_metric(metric_definition_id, time, value)
      puts "#{metric_definition_id},#{time},#{value}"
    end
  end
end
