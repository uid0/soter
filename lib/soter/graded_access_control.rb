
module GradedAccessControl
    extend ActiveSupport::Concern
  
    # This will store metadata for each field's grade.
    included do
      class_attribute :field_grades, instance_writer: false, default: {}
    end
  
    module ClassMethods
      # Allows a model to tag its fields with grades
      def grade_field(field_name, *grades)
        self.field_grades[field_name.to_sym] = grades.map(&:to_sym)
      end
    end
  
    # This is where the access control and audit logic will be applied
    def check_access(user, field_name)
      grades = self.class.field_grades[field_name.to_sym]
      return true if grades.nil? || grades.empty?
  
      grades.all? { |grade| user.has_role_for_grade?(grade) }
    end
  
    # Auditing method: logs every access attempt
    def log_access(user, field_name)
      AccessAudit.create!(
        user: user,
        model: self.class.name,
        record_id: self.id,
        field_name: field_name,
        accessed_at: Time.current
      )
    end
  end
  

