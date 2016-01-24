class ChangeDataTypeForMessageInTestimonialRequests < ActiveRecord::Migration
  def self.up
    change_table :testimonial_requests do |t|
      t.change :message, :text
    end
  end
  def self.down
    change_table :testimonial_requests do |t|
      t.change :message, :string
    end
  end
end
