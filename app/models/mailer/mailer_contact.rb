class Mailer::MailerContact < Iso2022jpMailer

  include ApplicationHelper
  
  # 管理者に問い合わせ受付のメールを送信する
  def accepted_inquiry(contact, reply=nil)

    contact_result = "お問合せ項目 　： #{contact.contact_kind}\n"
    contact_result += "電話番号　　　 : #{contact.tel}\n"
    contact_result += "メールアドレス : #{contact.email}\n"
    contact_result += "問い合わせ内容 : \n"
    contact_result += "#{contact.contact_content}\n"
    
    @subject    = base64("【東淀川地域街づくりの会】お問い合わせありがとうございました。")
    @body       = {:name=>contact.name,:contact_result=>contact_result}
    @recipients = reply ? CONTACT_INQUIRY_RECIPIENTS : contact.email
    @from       = "【東淀川地域街づくりの会】<#{CONTACT_INQUIRY_RECIPIENTS}>"#get_control_value(CONFIG_SEND_MAIL_ADDRESS)
    @sent_on    =  Time.now
    @headers    = reply ? {'Reply-to' =>contact.email} :{}
  end
  
end
