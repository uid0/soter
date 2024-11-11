class User < ApplicationRecord
    has_many :roles
  
    # Returns true if the user has the specified role for the given grade
    def has_role_for_grade?(grade)
      roles.exists?(grade: grade)
    end
  end
  