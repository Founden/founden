# Handles application pages
class PagesController < AuthenticatedController
  # Check if user has the promo code
  before_filter :check_promo_code, :except => [:waiting]

  # Shows main dashboard
  def dashboard
  end

  # Shows a waiting page
  def waiting
    code = params[:user] ? user_params[:promo_code] : nil
    if code and Founden::Config.promo_codes.include?(code)
      current_account.update_attributes(user_params)
      notice = _('Code worked! Carry on.')
      redirect_to root_path, :notice => notice
    else
      flash[:alert] = _('Sorry, the code did not work.') if code
    end
  end

  private

  # Handle users without promo code
  def check_promo_code
    if current_account.promo_code.blank?
      redirect_to waiting_pages_path
    end
  end

  # Allowed params for updating user
  def user_params
    params.require(:user).permit(:promo_code)
  end

end
