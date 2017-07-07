# An example file to demonstrate how to use the BowlingScore class

require_relative 'bowling_score'

# Less than a full game
example_1 = BowlingScore.new('XXX')
puts example_1.total_score
# => 60

example_2 = BowlingScore.new('95/X')
puts example_2.total_score
# => 39

# For a full game
example_3 = BowlingScore.new('XXXXXXXXXXXX', true) # 2nd parameter must be true if playing a full game
puts example_3.total_score
# => 300

example_4 = BowlingScore.new('4-8/425/7/X43X4/4/X', true)
puts example_4.total_score
# => 139
