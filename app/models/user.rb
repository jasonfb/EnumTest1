class User < ApplicationRecord
  enum status: {
    pending: 'Is Pending',
    active: 'Is active',
    archived: 'Is Archived',
    disabled: 'is Disabled',
    waiting: 'waiting'
  }

  def name
    id
  end
end
