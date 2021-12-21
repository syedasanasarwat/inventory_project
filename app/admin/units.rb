ActiveAdmin.register Unit do
  Formtastic::FormBuilder.perform_browser_validations = true
  permit_params :name
  batch_action :destroy, false

  filter :name_contains, label: 'Search Unit'
  
  index do
    column :name
    column do |v|
			link_to 'View', "units/#{v.id}"  
		end
    column do |v|
			link_to 'Edit', "units/#{v.id}/edit"  
		end
	end

  form do |f|
		f.inputs do      
      f.input :name, input_html: {required: true}
		end
    actions
	end

end
