require 'modelwork/modelworkerregistry'
class ModelWorkerDispatcher
  
  def initialize
    @registry = ModelWorkerRegistry.new
  end
  
  def register_modelworker(modelworker)
    @registry.add_entry(modelworker)
  end
  
  def refine(manual)
    @registry.get_entries.each { |modelworker|  
      manual = modelworker.refine(manual)
    }
    
    return manual
  end
end
