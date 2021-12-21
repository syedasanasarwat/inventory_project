ActiveAdmin.register Record do
  Formtastic::FormBuilder.perform_browser_validations = true
  permit_params :description, :make_id, :unit_id, :detail, :material_category, :date_updated, :active
  batch_action :destroy, false

  preserve_default_filters!
  remove_filter :description
  remove_filter :detail
  filter :description_contains, label: 'Desciption'
  filter :detail_contains, label: 'Detail'
  filter :material_category, as: :select, collection: -> {
    MaterialCategory.all.map { |m| [m.material_category_name, m.id] }
  }
  filter :active, as: :check_boxes

  index do
	  column :description
    column :make_id do |m|
      if m.make_id == nil
        raw("<span class='empty'>Nil</span>")
      else
        link_to Make.find(m.make_id).name, "makes/#{m.make_id}"
      end
    end
    column :unit_id do |m|
      link_to m.unit_id.nil? ? nil : Unit.find(m.unit_id).name, "units/#{m.unit_id}"
    end
    column :material_category do |m|
      link_to m.material_category.nil? ? nil : MaterialCategory.find(m.material_category).material_category_name, "material_categories/#{m.material_category}"
    end

    column :detail
    column :date_updated
    column :active

    column do |v|
			link_to 'View', "records/#{v.id}"  
		end
    column do |v|
			link_to 'Edit', "records/#{v.id}/edit"  
		end
	end

  form do |f|
		f.inputs do
      f.input :description, as: :string, required: true, input_html: {required: true} 
      f.input :make_id, as: :select, collection: Make.all.map{|x| [x.name, x.id]}, required: false, input_html: {required: false} #can't seem to let it submit null
      f.input :unit_id, as: :select, collection: Unit.all.map{|x| [x.name, x.id]}, selected: object.unit_id, required: true, input_html: {required: true}
      f.input :detail, as: :string
      f.input :material_category, as: :select, collection: MaterialCategory.all.map{|x| [x.material_category_name, x.id]}, required: true, input_html: {required: true} 
      f.input :active, as: :radio
		end
    actions
	end
  
end
