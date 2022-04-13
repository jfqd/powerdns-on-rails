# See #SPF

# = Text Record (SPF)
#
# In computing, Sender Policy Framework (SPF) allows software to identify
# messages that are or are not authorized to use the domain name in the SMTP
# HELO and MAIL FROM (Return-Path) commands, based on information published in a
# sender policy of the domain owner. Forged return paths are common in e-mail
# spam and result in backscatter. SPF is defined in RFC 4408
#
# Obtained from http://en.wikipedia.org/wiki/Sender_Policy_Framework
#
class TLSA < Record

  validates :content, format: { with: /\A\d{1} \d{1} \d{1} .*\Z/, message: "Format is: 3 1 1 hashvalue" }

end
