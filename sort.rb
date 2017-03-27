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

  def quick(set: @set.dup, lesser_before: [], greater_before: [])
    if set.empty?
      return set
    end
# 5+15+95+45+55+85+25+75+100+65+35
# 15+95+45+55+85+25+75+100+65+35
    pivot = (set.length / 2).to_i
    print(set: lesser_before + set + greater_before, subject: pivot)
    pivot_value = set.delete_at(pivot)
    greater, lesser = *(set.partition { |v| v > pivot_value })
    intermediate = lesser_before + lesser + [pivot_value] + greater + greater_before
    print(set: intermediate, subject: intermediate.find_index(pivot_value))
    less = []
    more = []
    if lesser.length > 1
      less = quick(
        set: lesser,
        greater_before: [pivot_value] + greater + greater_before,
        lesser_before: lesser_before
      )
    end
   if greater.length > 1
    more = quick(
      set: greater,
      lesser_before: lesser_before + lesser + [pivot_value],
      greater_before: greater_before
    )
   end
   less + [pivot_value] + more
  end

  def print(set: @set, subject: nil, comparing: nil, swapping: false, newline: true)
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
    Kernel.print printable.join("+")
    if newline
      puts
    end
  end
end

puts Sort.new([5, 15, 25, 35, 45, 55, 65, 75, 85, 95, 100].shuffle).quick.inspect
