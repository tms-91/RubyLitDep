require 'modelwork/modelworkerregistry'
class ModelWorkerDispatcher
  
  def initialize
    @registry = ModelWorkerRegistry.new
  end
  
  def register_modelworker(modelworker)
    @registry.add_entry(modelworker)
  end
  
  def refine(manual)
    puts 'starting modelwork' 
	  
    @registry.get_entries.each { |modelworker|  
      manual = modelworker.refine(manual)
    }
    
    puts 'modelwork finished'
    return manual
  end
end
