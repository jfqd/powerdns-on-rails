# See #A

# = DNS Certification Authority Authorization (CAA) Resource Record
#
# Defined in RFC 6844
#
class CAA < Record

  validates_presence_of :content

end
