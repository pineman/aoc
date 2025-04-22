input = File.readlines("input/23", chomp: true)

ex = <<-EX.split("\n")
kh-tc
qp-kh
de-cg
ka-co
yn-aq
qp-ub
cg-tb
vc-aq
tb-ka
wh-tc
yn-cg
kh-ub
ta-co
de-co
tc-td
tb-wq
wh-td
ta-ka
td-qp
aq-cg
wq-ub
ub-vc
de-ta
wq-aq
wq-vc
wh-yn
ka-de
kh-ta
co-tc
wh-qp
tb-vc
td-yn
EX

def part_one(input)
  l = Hash.new { |h, k| h[k] = [] }
  s = Set.new
  input.each { |i|
    a, b = i.split(?-)
    l[a] << b
    l[b] << a
  }
  l.each { |node1, list1|
    list1.each { |node2| 
      list2 = l[node2]
      nodes_connected_to_both = (list1-[node2]) & list2
      if nodes_connected_to_both.any?
        nodes_connected_to_both.each { |node3|
          s << [node1, node2, node3].sort
        }
      end
    }
  }
  s.count { |list| list.any? { it.start_with?(?t) } }
end

#puts part_one(ex)
puts part_one(input) # 1512
