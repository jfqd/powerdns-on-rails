class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def to_xml(options = {}, &block)
    hash = JSON.parse(self.to_json)
    hash.to_xml(options)
  end
end