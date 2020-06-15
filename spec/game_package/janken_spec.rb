RSpec.describe GamePackage::Janken do
  describe "#start" do
    subject(:start) { described_class.start }
  
    context 'プレイヤーがグー' do
      before { allow(ARGF).to receive(:gets) { 0 } }

      context 'コンピューターがグーの場合' do
        it '' do
          # TODO: 無限ループしてしまう為、保留
        end
      end
      context 'コンピューターがチョキの場合' do

        it '' do
          allow(described_class).to receive(:computer_hand).and_return(1)
          is_expected.to eq 'win'
        end
      end
      context 'コンピューターがパーの場合' do

        it '' do
          allow(described_class).to receive(:computer_hand).and_return(2)
          is_expected.to eq 'lose'
        end
      end
    end
    context 'プレイヤーがチョキ' do
      before { allow(ARGF).to receive(:gets) { 1 } }
      
      context 'コンピューターがチョキの場合' do
        it '' do
          # TODO: 無限ループしてしまう為、保留
        end
      end
      context 'コンピューターがパーの場合' do
      
        it '' do
          allow(described_class).to receive(:computer_hand).and_return(2)
          is_expected.to eq 'win'
        end
      end
      context 'コンピューターがグーの場合' do
  
        it '' do
          allow(described_class).to receive(:computer_hand).and_return(0)
          is_expected.to eq 'lose'
        end
      end
    end
    context 'プレイヤーがパー' do
      before { allow(ARGF).to receive(:gets) { 2 } }
      
      context 'コンピューターがパーの場合' do
        it '' do
          # TODO: 無限ループしてしまう為、保留
        end
      end
      context 'コンピューターがグーの場合' do

        it '' do
          allow(described_class).to receive(:computer_hand).and_return(0)
          is_expected.to eq 'win'
        end
      end
      context 'コンピューターがチョキの場合' do

        it '' do
          allow(described_class).to receive(:computer_hand).and_return(1)
          is_expected.to eq 'lose'
        end
      end
    end
  end
end
