require 'rspec/autorun'
require 'io/console'

class Spaceship
  def initialize(coords = [0, 0], speed = 0)
    @coords = coords
    @speed = speed
    @error = nil
  end

  def status
    [
      "(#{@coords[0]}, #{@coords[1]})",
      description,
      @error
    ].compact.join(' ')
  end

  def command(ch)
    @error = nil
    case ch
      when 'w'
        if @speed < 5
          @speed += 1
        else
          @error = 'maximum speed'
        end
      when 's'
        if @speed > 1
          @speed -= 1
        else
          @error = 'minimum speed'
        end
      when 'a'
        if @speed > 0
          @coords[0] -= 1
        else
          @error = 'still on Earth'
        end
      when 'd'
        if @speed > 0
          @coords[0] += 1
        else
          @error = 'still on Earth'
        end
    else
      @error = 'unknown command'
    end
    move
    @error.nil?
  end

  private

  def move
    @coords[1] += @speed
  end

  def description
    return 'ready to launch' if @coords[1] == 0
    return 'wrong trajectory' if @coords[0] > 5 || @coords[0] < -5
    return 'on the moon' if @coords[1] == 250 && @coords[0] == 0
    return 'contact lost' if @coords[1] > 250
  end
end

RSpec.describe Spaceship do
  subject { Spaceship.new }

  it 'flies to the moon' do
    expect(subject.status).to eq('(0, 0) ready to launch')
    expect(subject.command('s')).to eq(false)
    expect(subject.command('a')).to eq(false)
    expect(subject.command('d')).to eq(false)
    expect(subject.status).to eq('(0, 0) ready to launch still on Earth')
    expect(subject.command('w')).to eq(true)
    expect(subject.status).to eq('(0, 1)')
    expect(subject.command('w')).to eq(true)
    expect(subject.status).to eq('(0, 3)')
    expect(subject.command('w')).to eq(true)
    expect(subject.status).to eq('(0, 6)')
    expect(subject.command('w')).to eq(true)
    expect(subject.status).to eq('(0, 10)')
    expect(subject.command('w')).to eq(true)
    expect(subject.status).to eq('(0, 15)')
    expect(subject.command('w')).to eq(false)
    expect(subject.status).to eq('(0, 20) maximum speed')
    expect(subject.command('a')).to eq(true)
    expect(subject.status).to eq('(-1, 25)')
    expect(subject.command('d')).to eq(true)
    expect(subject.status).to eq('(0, 30)')
    expect(subject.command('d')).to eq(true)
    expect(subject.status).to eq('(1, 35)')
    expect(subject.command('s')).to eq(true)
    expect(subject.status).to eq('(1, 39)')
    expect(subject.command('d')).to eq(true)
    expect(subject.status).to eq('(2, 43)')
    expect(subject.command('d')).to eq(true)
    expect(subject.status).to eq('(3, 47)')
    expect(subject.command('d')).to eq(true)
    expect(subject.status).to eq('(4, 51)')
    expect(subject.command('d')).to eq(true)
    expect(subject.status).to eq('(5, 55)')
    expect(subject.command('d')).to eq(true)
    expect(subject.status).to eq('(6, 59) wrong trajectory')
    expect(subject.command('d')).to eq(true)
    expect(subject.status).to eq('(7, 63) wrong trajectory')
    expect(subject.command('a')).to eq(true)
    expect(subject.status).to eq('(6, 67) wrong trajectory')
    expect(subject.command('a')).to eq(true)
    expect(subject.status).to eq('(5, 71)')
    expect(subject.command('a')).to eq(true)
    expect(subject.status).to eq('(4, 75)')
    expect(subject.command('t')).to eq(false)
    expect(subject.status).to eq('(4, 79) unknown command')

  end

  context 'ship is far to the left' do
    subject { Spaceship.new([-6, 10], 5) }

    it 'prints wrong trajectory' do
      expect(subject.status).to eq('(-6, 10) wrong trajectory')
      expect(subject.command('d')).to eq(true)
      expect(subject.status).to eq('(-5, 15)')
    end
  end

  context 'ship is on the moon' do
    subject { Spaceship.new([0, 250], 5) }

    it 'prints wrong trajectory' do
      expect(subject.status).to eq('(0, 250) on the moon')
    end
  end

  context 'ship crashed' do
    subject { Spaceship.new([0, 246], 4) }

    it 'prints wrong trajectory' do
      expect(subject.command('w')).to eq(true)
      expect(subject.status).to eq('(0, 251) contact lost')
    end
  end

  context 'ship missed the moon' do
    subject { Spaceship.new([0, 246], 4) }

    it 'prints wrong trajectory' do
      expect(subject.command('d')).to eq(true)
      expect(subject.status).to eq('(1, 250)')
      expect(subject.command('a')).to eq(true)
      expect(subject.status).to eq('(0, 254) contact lost')
    end
  end
end

spaceship = Spaceship.new
while true
  status = spaceship.status
  puts status
  if status.include?('contact lost') || status.include?('on the moon')
    puts 'Bye!'
    exit(0)
  end

  command = STDIN.getch
  spaceship.command(command)
end

