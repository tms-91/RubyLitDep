require 'modelwork/modelworkerregistry'
class ModelWorkerDispatcher
  
  def initialize
    @registry = ModelWorkerRegistry.new
  end
  
  def register_modelworker(modelworker)
    @registry.add_entry(modelworker)
  end
  
  def refine(script)
    @registry.get_entries.each { |modelworker|  
      script = modelworker.refine(script)
    }
    
    return script
  end
end
