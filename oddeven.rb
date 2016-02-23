
(2..100).each do |i|
  even_count = 0
  odd_count = 0

  1000.times do
    if 0 == (1..i).to_a.shuffle!.pop(2).reduce(:+) % 2
      even_count += 1
    else
      odd_count += 1
    end
  end

  puts "SET OF #{i}:"
  puts "  even: #{even_count} (#{(100.0 * even_count / (even_count + odd_count)).round(1)}%)"
  puts "  odd: #{odd_count} (#{(100.0 * odd_count / (even_count + odd_count)).round(1)}%)"
end



# 1 + 2 = 3 = Odd
# 1 + 3 = 4 = Even
# 2 + 1 = 3 = Odd
# 2 + 3 = 5 = Odd
# 3 + 1 = 4 = Even
# 3 + 2 = 5 = Odd
#             (2x even, 4x odd)
#
#
# 1 + 2 = 3 = Odd
# 1 + 3 = 4 = Even
# 1 + 4 = 5 = Odd
# 2 + 1 = 3 = Odd
# 2 + 3 = 5 = Odd
# 2 + 4 = 6 = Even
# 3 + 1 = 4 = Even
# 3 + 2 = 5 = Odd
# 3 + 4 = 7 = Odd
# 4 + 1 = 5 = Odd
# 4 + 2 = 6 = Even
# 4 + 3 = 7 = Odd
#             (4x even, 8x odd)


