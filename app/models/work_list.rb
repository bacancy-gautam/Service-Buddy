class WorkList < ApplicationRecord
    belongs_to :provider
    belongs_to :category
end
