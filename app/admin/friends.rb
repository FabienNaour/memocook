ActiveAdmin.register Friend do
  index do
    selectable_column
    id_column
    column :name
    column :user
    column :email
    column :telephone
        column :created_at
    actions
  end
end

ActiveAdmin.register Friend do
  form do |f|
    f.inputs "Identity" do
      f.input :name
      f.input :user
      f.input :email
      f.input :telephone
    end
    f.actions
  end

  permit_params  :name, :email, :telephone, :user
end
