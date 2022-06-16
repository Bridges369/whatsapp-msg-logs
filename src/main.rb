require_relative 'message.rb'; include Message


DATE = /^([0-9]{2}\/[0-9]{2}\/[0-9]{4})\s([0-9]{2}:[0-9]{2})(\s-\s)/i
WHO = /^([0-9]{2}\/[0-9]{2}\/[0-9]{4})\s([0-9]{2}:[0-9]{2})(\s[-]\s)(.*?:)/i
ACTION = /(\u200e)\w(.)*/i
MESSAGE = /^([0-9]{2}\/[0-9]{2}\/[0-9]{4})\s([0-9]{2}:[0-9]{2})\s(-)\s(.*?:)(.*)/i
TYPE = /\u200e/

open('./msg-logs/log1.txt','r') do |f|

  f.readlines.each do |s|

    date = * DATE.match(s)

    who = * WHO.match(s)

    action_msg = * ACTION.match(s)

    message = * MESSAGE.match(s)

    type = (TYPE =~ s)==19 ? :action : :message

    Message.push({
      :type => type,
      :who => who[-1] ?
        who[-1].to_s[0..-2] : "![system]",
      :date => date[0].to_s[0..15],
      :text => type == :action ?
        action_msg[0].to_s[1..] : (message[-1] ?
                                    message[-1] : s[19..-2]
                                  )
    }, "Lillian", "teste", 100, 37)
  end
end
