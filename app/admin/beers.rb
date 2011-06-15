ActiveAdmin.register Beer do
  
  # Custom table display
  index do
    id_column
    column :name
    column("Brewery", :brewery, :sortable => :brewery_id)
    column :ibus
    column :alcohol
    default_actions
  end
  
  # Overrides default form to enable image upload
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details", :multipart => true do
      f.input :brewery, :as => :select, :collection => Brewery.all, :label_method => :name, :value_method => :id
      f.input :name
      f.input :description, :as => :text
      f.input :ibus
      f.input :alcohol
      f.input :logo_path, :as => :file
    end    
    f.buttons
  end
  
end
