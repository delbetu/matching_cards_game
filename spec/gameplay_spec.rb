require 'gameplay.rb'

describe Gameplay do
  describe '#click_card' do
    subject do
      #  Given an existing board of 2x2 with two different kinds of cards red and blue
      #  and the player already clicked the (1,1) position
      Gameplay.new(number_of_tries: 15, game_over: false, points: 0,
        board: Board.new({
          Position.new(1,1) => Card.with(type: :blue, visible: true),
          Position.new(1,2) => Card.with(type: :red,  visible: false),
          Position.new(2,1) => Card.with(type: :blue, visible: false),
          Position.new(2,2) => Card.with(type: :red,  visible: false)
        })
      )
    end
    before do
      subject.previously_clicked_position = Position.new(1, 1)
    end

    context 'when clicking a non-matching card' do

      it 'hides both cards' do
        subject.click_card(1, 2)

        clicked_card = subject.get_card(1, 2)
        previously_clicked_card = subject.get_card(1, 1)
        expect(previously_clicked_card).to be_hidden
        expect(clicked_card).to be_hidden
      end

      it 'decrements the number of tries' do
        expect {
          subject.click_card(1, 2)
        }.to change { subject.number_of_tries }.by(-1)
      end
    end

    context 'when clicking a matching card' do
      it 'shows both cards and they remain visible' do
        subject.click_card(2, 1)

        previously_clicked_card = subject.get_card(1, 1)
        clicked_card = subject.get_card(2, 1)

        expect(previously_clicked_card).to be_visible
        expect(clicked_card).to be_visible
      end

      it 'decrements the number of tries' do
        expect {
          subject.click_card(2, 1)
        }.to change { subject.number_of_tries }.by(-1)
      end

      it 'increment the number of points by 100' do
        subject.click_card(2, 1)
        expect(subject.points).to eq(100)
      end
    end
  end
end
