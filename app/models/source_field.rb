class SourceField < ActiveRecord::Base
  belongs_to :source

  validates :key_name, presence: true, length: { in: 3..40 }, uniqueness: {scope: [:source_id]}
  validates :field_type, presence: true

end
