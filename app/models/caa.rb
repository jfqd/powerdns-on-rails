# See #A

# = DNS Certification Authority Authorization (CAA) Resource Record
#
# Defined in RFC 6844
#
class CAA < Record

  validates :content, format: { with: /\A0 (issue|issuewild|iodef) ".*"\Z/, message: 'CAA records must be in the form: 0 issue|issuewild|iode "<ca>"' }

end
