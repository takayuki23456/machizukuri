class Contact < ActiveRecord::Base
  def validate
    errors.add(:name, "必須入力です")if self.name.to_s == ""
    errors.add(:email, "必須入力です")if self.email.to_s == ""
    errors.add(:tel, "必須入力です") if self.tel.to_s == ""
    #errors.add(:contact_content, "必須入力です") if self.contact_content.to_s == ""
  end
  class << self
    HUMANIZED_ATTRIBUTE_KEY_NAMES = {
      "name"=>"名前",
      "email"=>"メールアドレス",
      "tel"=>"電話番号",
      "contact_content"=>"問い合わせ内容",
    }
    def human_attribute_name(attribute_key_name)
      HUMANIZED_ATTRIBUTE_KEY_NAMES[attribute_key_name] || super
    end
  end
end
