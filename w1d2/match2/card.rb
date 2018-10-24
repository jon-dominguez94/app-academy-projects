class Card
  attr_reader :face_down, :face_value
  def initialize(face_value)
    @face_value = face_value
    @face_down = true
  end
  
  def face_down?
    @face_down
  end
  
  def display_card_info
    @face_value unless face_down?
  end
  
  def reveal
    @face_down = false
  end
  
  def hide
    @face_down = true
  end
  
  
  def matches?(card)
    @face_value == card.face_value
  end
end