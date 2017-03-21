require "rainbow"

class Sort
  attr_reader :set
  def initialize(set)
    @set = set
  end

  def bubble
    swapped = false
    len = set.length
    print(set)
    loop do
      swapped = false
      (len -= 1).times do |i|
        print(set, subject: i, comparing: i + 1)
        if set[i] > set[i+1]
          set[i], set[i+1] = set[i+1], set[i]
          print(set, subject: i+1, comparing: i)
          swapped = true
        end
      end
      break if !swapped
    end
  end

  def print(set, subject:nil, comparing:nil, swapping:false)
    printable = set.map(&:to_s)
    if swapping
      subject, comparing = comparing, subject
    end

    if subject
      printable[subject] = Rainbow(printable[subject]).green
    end
    if comparing
      printable[comparing] = Rainbow(printable[comparing]).red
    end
    puts printable.join("+")
  end
end

Sort.new([5, 15, 25, 35, 45, 55, 65, 75, 85, 95, 100].shuffle).bubble
