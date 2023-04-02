
def count_trees(map, stepx, stepy)
  res = 0
  pos = [0, 0]
  while pos[1] < map.length - stepy
    x, y = pos

    x += stepx
    y += stepy

    if x >= map[y].length
      x %= map[y].length
    end

    if map[y][x] == '#'
      res +=1
    end
    pos = [x, y]
  end
  res
end

very_simple_map = [
  '..##.......',
  '#...#...#..',
  '.#....#..#.',
  '..#.#...#.#',
  '.#...##..#.',
  '..#.##.....',
  '.#.#.#....#',
  '.#........#',
  '#.##...#...',
  '#...##....#',
  '.#..#...#.#'
]

p count_trees(very_simple_map, 3, 1)
p count_trees(very_simple_map, 1, 1)
p count_trees(very_simple_map, 5, 1)
p count_trees(very_simple_map, 7, 1)
p count_trees(very_simple_map, 1, 2)

p (count_trees(very_simple_map, 3, 1) * count_trees(very_simple_map, 1, 1) *
    count_trees(very_simple_map, 5, 1) * count_trees(very_simple_map, 7, 1) *
    count_trees(very_simple_map, 1, 2))

map = File.read('input.txt').split
p (count_trees(map, 3, 1) * count_trees(map, 1, 1) *
    count_trees(map, 5, 1) * count_trees(map, 7, 1) *
    count_trees(map, 1, 2))
