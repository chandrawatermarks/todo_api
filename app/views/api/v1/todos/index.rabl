collection @todos
attributes :id, :title, :description, :status, :created_at
child :tags => :tags do
  attributes :id, :name 
end