ActiveAdmin.register StoreStatus do
  Formtastic::FormBuilder.perform_browser_validations = true
  permit_params :record_id, :store_status, :date_updated, :active
  batch_action :destroy, false

  preserve_default_filters!
  remove_filter :record
  filter :record_description_contains, as: :string, label: 'Search Record'
  filter :active, as: :check_boxes

  index do
    column :record_id do |m|
      link_to m.record_id.nil? ? nil : Record.find(m.record_id).description, "records/#{m.record_id}" 
		end
    column :store_status
    column :date_updated
    column :active
    column do |v|
			link_to 'View', "store_statuses/#{v.id}"  
		end
    column do |v|
			link_to 'Edit', "store_statuses/#{v.id}/edit"  
		end
	end
  
  form do |f|
		f.inputs do      
      f.input :record_id, as: :select, collection: Record.all.map{|x| [x.description, x.id]}, input_html: {required: true}
      f.input :store_status, input_html: {required: true}
      f.input :active, as: :radio
		end
    actions
	end

  show :title => "Store Status" do
		attributes_table do
			row :record_id do |m|
        m.record_id.nil? ? nil : Record.find(m.record_id).description
      end
			row :store_status
      row :date_updated
      row :active
		end
		active_admin_comments
	end

end
