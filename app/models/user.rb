class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews

  def full_name
    "#{firstname} #{lastname}"
  end

  # def self.search(search)
  #   if search
  #     where('name LIKE ?', "%#{search}%")
  #   else
  #     scoped
  #   end
  # end
end
