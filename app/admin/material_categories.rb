ActiveAdmin.register MaterialCategory do
  Formtastic::FormBuilder.perform_browser_validations = true
  permit_params :material_category_name, :category_id
  batch_action :destroy, false

  index do
	  column :material_category_name
    column :category_id do |m|
      link_to m.category_id.nil? ? nil : Category.find(m.category_id).name, "categories/#{m.category_id}"
    end
    column do |v|
			link_to 'View', "material_categories/#{v.id}"  
		end
    column do |v|
			link_to 'Edit', "material_categories/#{v.id}/edit"  
		end
	end

  form do |f|
		f.inputs do
      f.input :category_id, as: :select, collection: Category.all.map{|x| [x.name, x.id]}, input_html: {required: true}      
      f.input :material_category_name, input_html: {required: true}
		end
    actions
	end
  
end
