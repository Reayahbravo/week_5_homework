class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy 
    
    validates(:title, presence: true, uniqueness: true)

    validates(
        :title,
        presence: true,
          uniqueness: true
    )
        validates(
        :body,
        presence: true,
          length: {
              minimum: 50
          }
      )  
end


  # answers
  # answers<<(object, ...)
  # answers.delete(object, ...)
  # answers.destroy(object, ...)
  # answers=(objects)
  # answer_ids
  # answer_ids=(ids)
  # answers.clear
  # answers.empty?
  # answers.size
  # answers.find(...)
  # answers.where(...)
  # answers.exists?(...)
  # answers.build(attributes = {}, ...)
  # answers.create(attributes = {})
  # answers.create!(attributes = {})
  # answers.reload
