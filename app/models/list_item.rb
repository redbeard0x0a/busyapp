# Copyright 2010 Bryan Rehbein
# 
# Filename: list_item.rb
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class ListItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :list
  
  validates_presence_of :list_id
  validates_presence_of :user_id
  #validates_presence_of :name
  
  validates :name, :presence => true, :length => { :within => 1..40 }
  
  def mark_complete
    is_complete = true
    completed_at = DateTime.now
  end
  
  # TODO: if due_date and description is blank, try to parse due date from name
  # we only want the parsing on quick-input, not when due-date was intentionally not
  # filled out
  
  def overdue?
    due_date < Date.today
  end
  
  def due_today?
    due_date == Date.today
  end
  
  
  before_validation(:on => :create) do
    # Try to parse the due date from the name if due_date and description are blank
    if !due_date && !description
      if name.sub("due")
        
      end
      # TODO: Task Name due tomorrow
      # TODO: Task Name due 8/17
      # TODO: Task Name due 9-12
      # TODO: Task Name due 2010-09-09
      # TODO: Task Name due (next) monday
      # TODO: Fix problem due to misaligned feature (negative example)
    end
  end
  
end
