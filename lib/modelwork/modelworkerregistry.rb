class ModelWorkerRegistry
  def initialize
    @entries = Array.new
  end
  
  def add_entry(modelworker)
    if(modelworker.kind_of?(ModelWorker))
      @entries.push(modelworker)
    end
  end
  
  def get_entries
    return @entries
  end
  
end
