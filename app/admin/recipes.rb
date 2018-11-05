ActiveAdmin.register Recipe do
  index do
    selectable_column
    id_column
    column :name
    column :link
    column :description
    column :image
    column :logo
    column :photo
    column :created_at
    actions
  end
end

ActiveAdmin.register Recipe do
  form do |f|
    f.inputs "Identity" do
      f.input :name
      f.input :link
      f.input :description
      f.input :image
      f.input :logo
      f.input :photo
    end
    f.actions
  end

  permit_params  :name, :link, :description, :image, :logo
end


