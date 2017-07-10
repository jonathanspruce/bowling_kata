# frozen_string_literal: true

# BowlingScore used to take a single string showing the score of each throw of
# the game as input and calculate the total score
class BowlingScore
  attr_accessor :all_throws, :full_game

  def initialize(all_throws, full_game = false)
    @all_throws = all_throws.split('')
    @full_game = full_game
  end

  def total_score
    t_score = 0

    all_throws.each_with_index do |b_throw, i|
      # add score from this throw
      t_score += convert_throw(b_throw)

      # check if the final frame of the game (there are special rules)
      end_frame = full_game && i >= (all_throws.length - 3)

      # add any special scores if spare or strike
      next unless ['X', '/'].include? b_throw
      t_score += calculate_strike(i) if b_throw == 'X' && !end_frame
      t_score += calculate_spare(i, end_frame) if b_throw == '/'
      next
    end

    # return calculated score
    t_score
  end

  private

  def calculate_strike(index)
    # if the second additional throw was not a spare
    if all_throws[index + 2] != '/'
      convert_throw(all_throws[index + 1], all_throws[index + 2])
    else
      # just use the second throw because of the way spares are calculated
      convert_throw(all_throws[index + 2])
    end
  end

  def calculate_spare(index, end_frame)
    s_score = 0
    # take away score from previous throw (because add 10 for the spare)
    s_score -= convert_throw(all_throws[index - 1])
    # add next throw to score - don't do if end frame
    s_score += convert_throw(all_throws[index + 1]) unless end_frame
    s_score
  end

  def convert_throw(*throws)
    total = 0
    throws.each do |b_throw|
      total += case b_throw
      when 'X'
        10
      when '/'
        10
      when '-'
        0
      else
        b_throw.to_i
      end
    end

    total
  end
end
