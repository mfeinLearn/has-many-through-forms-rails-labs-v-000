class Post < ActiveRecord::Base
    belongs_to :category
    validates :title, presence: true
    validates :content, presence: true

    accepts_nested_attributes_for :category, reject_if: :all_blank
end
