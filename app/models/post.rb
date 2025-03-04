class Post < ActiveRecord::Base
  belongs_to :author
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction), message: "%{value} is not a valid category." }
  validate :clickbait?

  CLICKBAIT = [
    /Won't Believe/,
    /Secret/,
    /Top [0-9]/,
    /Guess/,
  ]

  def clickbait?
    if CLICKBAIT.none? { |click| click.match title }
      errors.add(:title, "must be clickbait")
    end
  end
end
