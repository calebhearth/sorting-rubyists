require "rainbow"

class Sort
  attr_reader :set
  def initialize(set)
    @set = set
    print
  end

  def bubble
    swapped = false
    loop do
      swapped = false
      (0...set.length).each do |i|
        print(subject: i, comparing: i + 1)
        if set[i] > set[i+1]
          set[i], set[i+1] = set[i+1], set[i]
          print(subject: i+1, comparing: i)
          swapped = true
        end
      end
      break if !swapped
    end
  end

  def insertion
    set.each_with_index do |subject, i|
      insert_before = i
      print(subject: i)
      (i - 1).downto(0).each do |j|
        comparing = set[j]
        print(subject: i, comparing: j)
        if subject > comparing
          break
        end
        insert_before = j
      end
      if insert_before != i
        set.insert(insert_before, set.delete_at(i))
        print(subject: insert_before)
      end
    end
    print
  end

  def print(subject: nil, comparing: nil, swapping: false)
    printable = set.map(&:to_s)
    if swapping
      subject, comparing = comparing, subject
    end

    if comparing
      printable[comparing] = Rainbow(printable[comparing]).red
    end
    if subject
      printable[subject] = Rainbow(printable[subject]).green
    end
    puts printable.join("+")
  end
end

Sort.new([5, 15, 25, 35, 45, 55, 65, 75, 85, 95, 100].shuffle).insertion
