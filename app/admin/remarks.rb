ActiveAdmin.register Remark do
  Formtastic::FormBuilder.perform_browser_validations = true
  permit_params :record_id, :remarks, :date_updated, :active
  actions :all

  preserve_default_filters!
  remove_filter :record
  filter :record_description_contains, as: :string, label: 'Search Record'

  index do
    selectable_column
    column :record_id do |m|
      link_to m.record_id.nil? ? nil : Record.find(m.record_id).description, "records/#{m.record_id}" 
		end
    column :remarks
    column :date_updated
    column :active
    column do |v|
			link_to 'View', "remarks/#{v.id}"  
		end
    column do |v|
			link_to 'Edit', "remarks/#{v.id}/edit"  
		end
    column do |v|
			link_to "Delete", "remarks/#{v.id}", method: :delete, data: { confirm: 'Are you sure you want to delete this Content?' }  
		end
	end

  form do |f|
		f.inputs do
      f.input :record_id, as: :select, collection: Record.all.map{|x| [x.description, x.id]}, input_html: {required: true}
      f.input :remarks, as: :string, input_html: {required: true}
      f.input :active, as: :radio
		end      
    actions
	end

  show :title => :id do
		attributes_table do
			row :record_id do |m|
        m.record_id.nil? ? nil : Record.find(m.record_id).description
      end
			row :remarks
      row :date_updated
      row :active
		end
		active_admin_comments
	end
  
end
