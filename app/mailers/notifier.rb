class Notifier < ActionMailer::Base

  def mail_message(datas)
    @datas = datas

    mail(
      :from    => "graines-de-sol@serre.grainesdesol.fr",
      :to      => @datas[:to],
      :subject => @datas[:subject]
    )
  end

  def welcome_message(datas)
    @datas = datas
    mail(
      :from    => "graines-de-sol@serre.grainesdesol.fr",
      :to      => @datas[:to],
      :subject => $conf.welcome_mail_subject,
      :body    => @datas[:body]) do |format|
        format.html
    end

  end

  def event_registration(datas)
    @datas = datas
    mail(
      :from    => "graines-de-sol@serre.grainesdesol.fr",
      :to      => @datas[:to],
      :subject => "#{t('email.new_registration')} #{@datas[:body][:event_name]}",
      :body    => @datas[:body]) do |format|
        format.html
    end

  end

  def newsletter(datas)
    @datas = datas
    mail(
      :from    => "graines-de-sol@serre.grainesdesol.fr",
      :to      => @datas[:to],
      :subject => @datas[:subject],
      :body    => @datas[:body]) do |format|
        format.html
    end

  end

end

