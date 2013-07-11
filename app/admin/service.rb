ActiveAdmin.register Service do
  index do
    column :name
  end

  form :html => {:enctype => "multipart/form-data" } do |f|
    f.semantic_errors :base
    f.inputs "Service Details", :multipart => true do
      f.input :name
      f.has_many :upload_files do |file|
        file.input :filename, :as => :file, :label => 'Image'
        file.input :id, :as => :hidden
      end
    end
    f.actions
  end

  controller do
    def create
       @service = Service.new(service_params)
       if @service.save
        redirect_to admin_service_url(@service), notice: 'Service was successfully created.'
       else
        render :new
      end
    end
    def update
      @service = Service.find(params[:id])
      if @service.update(service_params)
        redirect_to edit_admin_service_url(@service), notice: 'Service was successfully updated.'
      else
        render :edit
      end
    end

    private
    def service_params
      params.require(:service).permit(:name, upload_files_attributes: [:filename, :id])
    end
  end
end