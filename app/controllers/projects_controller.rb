class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :set_tenant, only:  %i[show edit update destroy new create indexy]
  # before_action :verify_tenant
  # GET /projects or /projects.json
  def index
    @projects = Project.all
    @members = @tenant.members
  end

  # GET /projects/1 or /projects/1.json
  def show
    @artifacts = Artifact.all
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    # binding.pry
    respond_to do |format|
      if @project.save
        format.html { redirect_to root_url, notice: "Project was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to root_url, notice: "Project was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:title, :details, :expected_completion_date, :tenant_id)
    end

    def set_tenant
      @tenant = Tenant.find(params[:tenant_id])
    end
    
    # def verify_tenant
    #   @tenant = Tenant.find(params[:tenant_id])
    #   unless params[:tenant_id] == @tenant.current_tenant.id.to_s
    #     redirect_to :root, flash: {error: 'you are not authorised to access any organization other than your own'}
    #   end
    # end
end
