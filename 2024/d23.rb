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

def something(input)
  l = []
  input.each { |i|
    a, b = i.split(?-)
    a_exist = l.find_index { it.include?(a) }
    b_exist = l.find_index { it.include?(b) }
    pp [a, b, l]
    if a_exist && b_exist
      next if a_exist == b_exist
      l[a_exist].merge(l[b_exist])
      l.delete_at(b_exist)
      p 1
    elsif !a_exist && b_exist
      p 2
      l[b_exist].add(a)
    elsif a_exist && !b_exist
      p 3
      l[a_exist].add(b)
    else
      p 4
      l << Set.new([a, b])
    end
  }
  pp l
  nil
end

def part_one(input)
  l = Hash.new { |h, k| h[k] = [] }
  input.each { |i|
    a, b = i.split(?-)
    l[a] << b
    l[b] << a
  }
  s = Set.new
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
#puts part_one(input) # 1512

def iter(adj, clique, nodes, cliques, k)
  if clique.size == k
    cliques << clique
    return
  end
  
  nodes.each_with_index { |node, i|
    cont = nodes[i+1..].filter { |n|
      adj[node].include?(n) && clique.all? { |c| adj[n].include?(c) }
    }
    iter(adj, clique + [node], cont, cliques, k)
  }
end

def part_one(input)
  adj = Hash.new { |h, k| h[k] = Set.new }
  input.each { |i|
    a, b = i.split(?-)
    adj[a] << b
    adj[b] << a
  }

  cliques = []
  iter(adj, [], adj.keys.sort, cliques, 3)
  cliques.count { |list| list.any? { it.start_with?(?t) } }
end

puts part_one(input) # 1512

def part_two(input)
  adj = Hash.new { |h, k| h[k] = Set.new }
  input.each { |i|
    a, b = i.split(?-)
    adj[a] << b
    adj[b] << a
  }

  max_clique = []
  iter = lambda do |clique, nodes|
    if clique.size > max_clique.size
      max_clique = clique
    end
    
    nodes.each_with_index { |node, i|
      cont = nodes[i+1..].filter { |n|
        adj[node].include?(n) && clique.all? { |c| adj[n].include?(c) }
      }
      iter.call(clique + [node], cont)
    }
  end
  iter.call([], adj.keys.sort)
  max_clique.sort.join(?,)
end

puts part_two(input) # ac,ed,fh,kd,lf,mb,om,pe,qt,uo,uy,vr,wg
