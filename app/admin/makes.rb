ActiveAdmin.register Make do
  Formtastic::FormBuilder.perform_browser_validations = true
  permit_params :name, :description, :category_id
  batch_action :destroy, false

  index do
    column :name
    column :category_id do |m|
      link_to m.category_id.nil? ? nil : Category.find(m.category_id).name, "categories/#{m.category_id}" 
		end
    column :description
    column do |v|
			link_to 'View', "makes/#{v.id}"  
		end
    column do |v|
			link_to 'Edit', "makes/#{v.id}/edit"  
		end
	end
  
  form do |f|
		f.inputs do
      f.input :category_id, as: :select, collection: Category.all.map{|x| [x.name, x.id]}, input_html: {required: true}      
      f.input :name, input_html: {required: true}
      f.input :description, as: :string
		end
    actions
	end

end
