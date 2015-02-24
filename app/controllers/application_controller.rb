class ApplicationController < ActionController::API
  # includes Rails modules we want that rails-api doesn't provide
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  include ActionView::Layouts

  ## Default CRUD methods

  # GET /api/:resource
  def index
    @resources = resource.all
    render :index, status: :ok
  end

  # GET /api/:resource/:id
  def show
    @resource = set_resource

    if @resource
      render :show, status: :ok
    else
      render "errors/not_found", status: :not_found
    end
  end

  # POST /api/:resource
  def create
    @resource = resource.new(resource_params)

    before_create_hook
    if @resource.save
      after_create_hook
      render :show, status: :created
    else
      render "errors/invalid_parameters", status: :bad_request
    end
  end

  # PUT   /api/:resource/:id
  # PATCH /api/:resource/:id
  def update
    @resource = set_resource

    if @resource.update_attributes(resource_params)
      render :show, status: :ok
    else
      if @resource
        render "errors/invalid_parameters",
               status: :bad_request
      else
        render "errors/not_found",
               status: :not_found
      end
    end
  end

  # DELETE /api/:resource/:id
  def destroy
    @resource = set_resource

    if @resource
      before_destroy_hook
      @resource.deleted = true
      @resource.save
      after_destroy_hook
      render :show, status: :ok
    else
      render "errors/not_found",
             status: :not_found
    end
  end

  protected

    # Get the class of the resource with which we are dealing.
    def resource
      self.class.to_s.split('::')
          .last.split('sController')
          .first.constantize
    end

    # Finds the desired Resource instance by :id
    def set_resource
      resource.find_by_public_id(params[:id])
    end

    def resource_params
      raise "Must implement resource_params method"
    end

    # Customization hook methods.

    def before_create_hook
    end

    def after_create_hook
    end

    def before_destroy_hook
    end

    def after_destroy_hook
    end

    # You can add more hooks if desired.
end
