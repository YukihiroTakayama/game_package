require 'byebug'
RSpec.describe GamePackage::SanmokuNarabe do
  describe "#start" do
    subject(:start) { described_class.start }
    
    let(:player_order) { 0 }
    let(:player_color) { 'w' }
    let(:computer_color) { 'b' }
    let(:player_select_list) { [player_order, 0, 3, 6] }
    let(:computer_select_list) { ((0..8).to_a - player_select_list).slice(3, 8) }

    before do
      allow(described_class).to receive(:gets) do
        player_select_list.shift
      end
      allow(described_class).to receive(:computer_select) do
        computer_select_list.shift
      end
    end
    
    xdescribe 'ラインが揃った場合にループ処理が終了するか検証' do
      context '左縦一列' do
        it '戻り値が想定通りであること' do
          is_expected.to eq 'win'    
        end
      end
      context '中縦一列' do
        let(:player_select_list) { [player_order,  1, 4, 7] }
        
        it '戻り値が想定通りであること' do
          is_expected.to eq 'win'    
        end
      end
      context '右縦一列' do
        let(:player_select_list) { [player_order,  2, 5, 8] }
        
        it '戻り値が想定通りであること' do
          is_expected.to eq 'win'    
        end
      end
      context '左横一列' do
        let(:player_select_list) { [player_order,  0, 1, 2] }

        it '戻り値が想定通りであること' do
          is_expected.to eq 'win'    
        end
      end
      context '中横一列' do
        let(:player_select_list) { [player_order,  3, 4, 5] }
        let(:computer_select_list) { [0, 1, 6]  }
        
        it '戻り値が想定通りであること' do
          is_expected.to eq 'win'    
        end
      end
      context '下縦一列' do
        let(:player_select_list) { [player_order,  6, 7, 8] }
        
        it '戻り値が想定通りであること' do
          is_expected.to eq 'win'    
        end
      end
      context '右上がり斜め' do
        let(:player_select_list) { [player_order,  2, 4, 6] }
        
        it '戻り値が想定通りであること' do
          is_expected.to eq 'win'    
        end
      end
      context '左上がり斜め' do
        let(:player_select_list) { [player_order,  0, 4, 8] }
        
        it '戻り値が想定通りであること' do
          is_expected.to eq 'win'    
        end
      end
    end
    context 'コンピューターが先攻' do
      let(:player_order) { 0  }
      
      context 'コンピュターが勝つ場合' do
        let(:player_select_list) { [player_order, 0, 3, 8] }
        let(:computer_select_list) { [1, 4, 7]  }

        it '戻り値が想定通りであること' do
          is_expected.to eq 'lose'    
        end
      end
    end
    describe '引き分けの場合の検証' do
      let(:player_select_list) { [0, 0, 1, 8, 7, 3] }
      let(:computer_select_list) { ((0..8).to_a - player_select_list) }
      
      it '戻り値が想定通りであること' do
        is_expected.to eq 'draw'    
      end
    end
  end
end
