class Cell
  attr_accessor :state, :row, :col

  def initialize(state, row, col)
    self.state = state
    self.row, self.col = row, col
  end

  def is_alive?
    self.state == 1
  end
  
  def is_dead?
    !is_alive?
  end

  def generate_alive
    self.class.new(1, row, col)
  end

  def generate_dead
    self.class.new(0, row, col)
  end

  def neighbors(board)
    [
      board[row,col-1],
      board[row,col+1],
      board[row-1,col],
      board[row+1,col],
      board[row-1,col+1],
      board[row+1,col+1],
      board[row-1,col-1],
      board[row+1,col-1],
    ].compact
  end

  def generate_next_step(board)
    alive_count = neighbors(board).count(&:is_alive?)
    if self.is_alive?
      return generate_dead  if alive_count < 2
      return generate_dead  if alive_count > 3
      return generate_alive if alive_count.between?(2,3)
    else
      return generate_alive if alive_count == 3
      return generate_dead
    end
  end
  
  def to_s
    state.to_s
  end

  def to_string
    state.to_string
  end
end

class Board
  attr_accessor :grid

  def initialize(grid)
    self.grid = []
    grid.each_with_index do |row, row_index|
      new_row = []
      row.each_with_index do |entry, col_index|
        new_row << Cell.new(entry, row_index, col_index)
      end
      self.grid << new_row
    end
  end

  def step
    new_grid = []
    self.grid.each do |row|
      new_row = []
      row.each do |entry|
        new_row << entry.generate_next_step(self)
      end
      new_grid << new_row
    end
    self.grid = new_grid
  end

  def [](a,b)
    return nil if grid[a].nil?
    self.grid[a][b]
  end

  def []=(a,b,c)
    self.grid[a][b] = c
  end
end

