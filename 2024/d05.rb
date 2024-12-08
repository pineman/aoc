input = File.readlines("input/05", chomp: true)

ex = [
  "47|53",
  "97|13",
  "97|61",
  "97|47",
  "75|29",
  "61|13",
  "75|53",
  "29|13",
  "97|29",
  "53|29",
  "61|53",
  "97|53",
  "61|29",
  "47|13",
  "75|47",
  "97|75",
  "47|61",
  "75|61",
  "47|29",
  "75|13",
  "53|13",
  "",
  "75,47,61,53,29",
  "97,61,53,29,13",
  "75,29,13",
  "75,97,47,61,53",
  "61,13,29",
  "97,13,75,29,47"
]

require "active_support"
require "active_support/core_ext"

def parse(input)
  i = input.find_index("")
  rules, updates = input[...i], input[i+1..]
  rules = rules.each_with_object({}) { |r, h|
    b, a = r.split("|")
    h[b] ||= []
    h[b] << a
  }
  updates.map! { |u| u.split(",") }
  [rules, updates]
end

def correct?(rules, u)
  index_hash = u.each_with_object({}).with_index { |(n, h), i|
    h[n] = i
  }
  u.each.with_index.all? { |page, page_i|
    pages_after = rules[page]&.filter { |a| index_hash[a] }
    next true unless pages_after
    pages_after.all? { |a| index_hash[a] > page_i }
  }
end

def part_one(input)
  rules, updates = parse(input)
  updates
    .filter { |u| correct?(rules, u) }
    .sum { |u| u[u.size/2].to_i } # hash keys/values preserve insertion order
end

puts part_one(input) # 6498

def fix(rules, update)
  res = []
  rules = update.to_h { |u| [u, rules[u]&.intersection(update) || []] } # TODO: can use rules[u] & update ?
  # there seems to always be only *exactly* one page that has no rules.
  # I thought it'd be many... seems particular of this dataset.
  while res.size < update.size
    pages_without_rules = (update - res).filter { rules[_1].empty? }
    res.prepend(*pages_without_rules)
    rules.transform_values! { |v| v - pages_without_rules }
  end
  res
end

def part_two(input)
  rules, updates = parse(input)
  updates
    .reject { |u| correct?(rules, u) }
    .map { |u| fix(rules, u) }
    .sum { |u| u[u.size/2].to_i } # could early out in fix once we're half way
end

puts part_two(input) # 5017
