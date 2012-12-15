class Content::ContactController < Content::ContentController
  # 問い合わせフォーム
  def index
    @contact = session[:contact_front] ? session[:contact_front] :Contact.new(:contact_kind=>params[:id])
  end
  # 問い合わせ内容確認
  def confirm
    if request.post?
      @contact = Contact.new(params[:contact])
      unless @contact.valid?
        render :controller => :contact,:action=>:index
      else
        session[:contact_front] = @contact
      end
    end
  end
  def thanks
    unless params[:commit]
      return redirect_to(:action => 'index')
    end
    if request.post?
      @contact = Contact.new(params[:contact])
      if @contact.save
        # 顧客にメール送信
        begin
          Mailer::MailerContact.deliver_accepted_inquiry(@contact)
          Mailer::MailerContact.deliver_accepted_inquiry(@contact,true)
          logger.info("E-mail('accepted_inquiry') successfully sent. [ userid:#{@contact.id} ]")
        rescue Exception => e
          p e
          logger.error("Faild e-mail('accepted_inquiry'). [ userid:#{@contact.id} ] #{e}")
        end
        session[:contact_front] = nil
      else
        render :action => 'confirm'
      end
    else
      redirect_to :action => 'index'
    end
  end
end
