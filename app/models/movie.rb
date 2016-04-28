class Movie < ActiveRecord::Base
  has_many :reviews
  mount_uploader :poster_image_url, ImageUploader
  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: {only_integer: true}
  validates :description, presence: true
  validates :poster_image_url, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_past
  #scope defines a specificially for sql queries method name that the controller can use.
  #the first scope passes a variable arguement search so that you can use put params[:search] in at controller
  scope :titleordirector, -> (search) {where("title LIKE ? OR director LIKE ?", "#%#{search}%", "%#{search}%")}
  scope :durationunder90, -> {where("runtime_in_minutes < ?", 90)}
  scope :durationbetween, -> {where("runtime_in_minutes >= ? and runtime_in_minutes <= ?", 90, 120)}
  scope :durationover120, -> {where("runtime_in_minutes > ?", 120)}
  
  def review_average
    if reviews.size > 0
      return reviews.sum(:rating_out_of_ten)/reviews.size
    else
      return "No reviews yet!"
    end
  end

  def review_amount
    return reviews.size
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date,"should be in the past") if release_date > Date.today
    end
  end

end
