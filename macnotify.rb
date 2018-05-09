require "terminal-notifier"

Plugin.create(:macnotify) do
  on_popup_notify do |user, text, &stop|
    text = text.to_s.encode(Encoding::UTF_8) if text.is_a? Message
    
    u = "mikumiku"
    icon = nil
    if user
      u = "@#{user[:idname]} (#{user[:name]})"
      icon = user.icon.perma_link.to_s
    end
    u = u.encode(Encoding::UTF_8)

    if text.valid_encoding? && u.valid_encoding?
      TerminalNotifier.notify(
        text,
        :title=>u,
        :sender=>'org.macosforge.xquartz.X11',
        :appIcon=> Skin.photo('icon.png').path,
        :contentImage=> icon
      )
    end
    stop.call
  end
end
