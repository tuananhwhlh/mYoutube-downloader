class Video < ApplicationRecord
  belongs_to :videoable, polymorphic: true

  validates :display_id, presence: true, length: { maximum: 11, message: 'Invalid id' }

  def display_id=(value)
    super(value&.split('?v=')&.last)
  end
end
