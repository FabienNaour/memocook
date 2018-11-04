
ActiveAdmin.register User do
  index do
    selectable_column
    id_column
    column :email
    # column :current_sign_in_at
    # column :sign_in_count
    column :created_at
    actions
  end
end

ActiveAdmin.register User do
  form do |f|
    f.inputs  do
      f.input :email
    end
    f.actions
  end

  permit_params  :email
end

