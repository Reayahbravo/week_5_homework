class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :body, presence: true

end

  # The following are instance methods that are
  # added to this class by `belongs_to :question`
  # method call above:

  # question
  # question=(associate)
  # build_question(attributes = {})
  # create_question(attributes = {})
  # create_question!(attributes = {})
  # reload_question