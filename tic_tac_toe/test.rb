require 'test-unit'
require_relative './tic_tac_toe.rb'

class TestTicTacToe < Test::Unit::TestCase
  def test_tic_tac_toe
    game = TicTacToe.new

    assert_equal(
      game.state,
      'running'
    )
    assert(game.player1_move(0, 0), true)
    assert(game.player1_move(0, 1), false)
    assert(game.player2_move(0, 0), false)
    assert(game.player2_move(0, 1), true)
    assert_equal(
      game.state,
      'running'
    )
    assert(game.player1_move(1, 1), true)
    assert(game.player2_move(0, 2), true)
    assert(game.player1_move(2, 2), true)
    assert_equal(
      game.state,
      'player1 wins'
    )
  end
end
