class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
    @members = Member.all
  end

  def show
    # You can use the @member instance variable to display member details
  end

  def new
    @user = User.new
    @member = Member.new
  end

  def create
    @user = User.find_by(email: user_params[:email])
  
    if @user.nil?
      # If user doesn't exist, create a new user
      @user = User.new(user_params)
      # @user.skip_confirm_change_password = true
      @user.save
    else
      # If user already exists, update their attributes
      @user.update(user_params)
    end
  
    @member = Member.new(member_params)
    @member.user_id = @user.id
    @member.tenant_id = current_tenant.id
  
    if @member.save
      flash[:notice] = "New member added and invitation email sent to #{user_params[:email]}."
      redirect_to root_path
    else
      flash[:error] = "Errors occurred!"
      render :new
    end
  end
  
  def edit
    # You can use the @member instance variable to populate the edit form
  end

  def update
    if @member.update(member_params)
      redirect_to @member, notice: 'Member was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @member.destroy
    redirect_to members_url, notice: 'Member was successfully destroyed.'
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:first_name, :last_name, :tenant_id, :user_id)
  end


  def user_params()
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
