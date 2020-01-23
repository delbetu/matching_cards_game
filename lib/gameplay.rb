require 'values'

class Board
  def initialize(elements_hash)
    @elements_hash = elements_hash
  end

  def get_card(position)
    @elements_hash[position]
  end

  def click_position(position, on_match:)
    if get_card(previously_clicked_position) == get_card(position)
      # show both ( previously_clicked_position is already visible )
      swap_visibility_of(position)
      on_match.call
    else
      # hide both ( position is already hidden )
      swap_visibility_of(previously_clicked_position)
    end
  end

  def previously_clicked_position=(position)
    @previously_clicked_position ||= position
  end

  def previously_clicked_position
    @previously_clicked_position
  end

  private

  def set_card(x, y, new_card)
    @elements_hash[Position.new(x, y)] = new_card
  end

  def swap_visibility_of(position)
    new_card = get_card(position).click
    set_card(position.x, position.y, new_card)
  end
end

class Position < Value.new(:x, :y)
end

class Card < Value.new(:type, :visible)
  def hidden?
    !visible
  end

  def visible?
    !!visible
  end

  def click
    Card.new(type, !visible)
  end

  def ==(other)
    type == other.type
  end
end

class Gameplay
  attr_reader :number_of_tries, :points # temporal
  def initialize(number_of_tries:, game_over:, points:, board:)
    @number_of_tries = number_of_tries
    @game_over = game_over
    @points = points
    @board = board
  end

  def click_card(x, y)
    @board.click_position(
      Position.new(x, y),
      on_match: -> { @points += 100 }
    )
    @number_of_tries -= 1
  end

  # temporal getter
  def get_card(x, y)
    @board.get_card(Position.new(x, y))
  end

  def previously_clicked_position=(position)
    @board.previously_clicked_position = position
  end
end
