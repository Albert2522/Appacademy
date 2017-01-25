class Card
  attr_accessor :face_val, :face_status


  def initialize(face_val)
    @face_val = face_val
    @face_status = "closed"
  end
end
