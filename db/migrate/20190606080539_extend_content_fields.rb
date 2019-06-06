class ExtendContentFields < ActiveRecord::Migration
  def self.up
    change_column(:macro_steps,      :content, :string, limit: 500)
    change_column(:record_templates, :content, :string, limit: 500)
    change_column(:records,          :content, :string, limit: 500)
  end

  def self.down
    change_column(:macro_steps,      :content, :string, limit: 255)
    change_column(:record_templates, :content, :string, limit: 255)
    change_column(:records,          :content, :string, limit: 255)
  end
end
