RSpec.describe GamePackage::Janken do

  it "has a version number" do
    expect(GamePackage::VERSION).not_to be nil
  end

  describe "#start" do
    subject(:start) { described_class.start }
    
    let(:output_character) do
      "ジャンケン...\n\nあなたの出す手を決めてください\n---------------\nグー(0)\nチョキ(1)\nパー(2)\n---------------\nポン\n" +
      "---------------\nあなた #{player_hand}\nあいて #{computer_hand}\n---------------\n\nあなたの#{judgment}です\n"
    end
  
    context 'プレイヤーがグー' do
      let(:player_hand) { 'グー' }

      before { allow(ARGF).to receive(:gets) { 0 } }
      
      
      context 'コンピューターがグーの場合' do
        it '標準出力が想定通りであること' do
          # TODO: 無限ループしてしまう為、保留
        end
      end
      context 'コンピューターがチョキの場合' do
        let(:computer_hand) { 'チョキ' }
        let(:judgment) { '勝ち' }

        it '標準出力が想定通りであること' do
          allow(described_class).to receive(:computer_hand).and_return(1)
          expect { start }.to output(output_character).to_stdout
        end
      end
      context 'コンピューターがパーの場合' do
        let(:computer_hand) { 'パー' }
        let(:judgment) { '負け' }

        it '標準出力が想定通りであること' do
          allow(described_class).to receive(:computer_hand).and_return(2)
          expect { start }.to output(output_character).to_stdout
        end
      end
    end

    context 'プレイヤーがチョキ' do
      let(:player_hand) { 'チョキ' }
      before { allow(ARGF).to receive(:gets) { 1 } }
      
      context 'コンピューターがチョキの場合' do
        it '標準出力が想定通りであること' do
          # TODO: 無限ループしてしまう為、保留
        end
      end
      context 'コンピューターがパーの場合' do
        let(:computer_hand) { 'パー' }
        let(:judgment) { '勝ち' }
      
        it '標準出力が想定通りであること' do
          allow(described_class).to receive(:computer_hand).and_return(2)
          expect { start }.to output(output_character).to_stdout
        end
      end
      context 'コンピューターがグーの場合' do
        let(:computer_hand) { 'グー' }
        let(:judgment) { '負け' }
  
        it '標準出力が想定通りであること' do
          allow(described_class).to receive(:computer_hand).and_return(0)
          expect { start }.to output(output_character).to_stdout
        end
      end
    end
    
    context 'プレイヤーがパー' do
      let(:player_hand) { 'パー' }
      before { allow(ARGF).to receive(:gets) { 2 } }
      
      context 'コンピューターがパーの場合' do
        it '標準出力が想定通りであること' do
          # TODO: 無限ループしてしまう為、保留
        end
      end
      context 'コンピューターがグーの場合' do
        let(:computer_hand) { 'グー' }
        let(:judgment) { '勝ち' }

        it '標準出力が想定通りであること' do
          allow(described_class).to receive(:computer_hand).and_return(0)
          expect { start }.to output(output_character).to_stdout
        end
      end
      context 'コンピューターがチョキの場合' do
        let(:computer_hand) { 'チョキ' }
        let(:judgment) { '負け' }

        it '標準出力が想定通りであること' do
          allow(described_class).to receive(:computer_hand).and_return(1)
          expect { start }.to output(output_character).to_stdout
        end
      end
    end
  end
end
