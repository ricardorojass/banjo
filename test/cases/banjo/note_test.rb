require 'test_helper'

class NoteTest < Test::Unit::TestCase
  def channel
    @channel ||= Banjo::Channel.new
  end

  def note
    @note ||= Banjo::Note.new(channel, 2)
  end

  def test_at
    Banjo.tick = 1
    mock(note).play.once
    note.at(1)
  end

  def test_at_dont_play
    Banjo.tick = 1
    mock(note).play.never
    note.at(2)
  end

  def test_every
    mock(note).play.times(4)
    (0..12).each do |i|
      Banjo.tick = i
      note.every(4)
    end
  end

  def test_with_velocity
    assert_equal note, note.with_velocity(3)
    assert_equal 3, note.velocity
  end

  def test_for
    assert_equal note, note.for(5)
    assert_equal 5, note.duration
  end

  def test_play
    mock(channel).play_note!(2, 100, 0.5)
    note.play
  end
end
