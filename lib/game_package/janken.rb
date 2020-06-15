require "game_package/version"

module GamePackage
  module Janken
    class Error < StandardError; end
      
    GU = 0
    TYOKI = 1
    PA = 2
    
    class << self
      def start
        puts "ジャンケン..."
        jadgement = 'draw'

        while jadgement == 'draw' do
          player = player_hand
          computer = computer_hand
          jadgement = jadge(player, computer)
          puts "ポン\n"
          puts '-'*15
          puts "あなた #{convert_hand_into_string(player)}\nあいて #{convert_hand_into_string(computer)}"
          puts '-'*15
          puts ''
          return jadgement if ['win', 'lose'].include?(jadgement)
          
          puts 'あいこで...'
        end
      end
  
      def player_hand
        puts "\nあなたの出す手を決めてください"
        puts '-'*15
        puts "グー(0)\nチョキ(1)\nパー(2)"
        puts '-'*15
        gets.to_i
      end
      
      def jadge(player_hand, computer_hand)
        return 'draw' if player_hand == computer_hand
          
        return 'win' if player_hand == GU && computer_hand == TYOKI ||
          player_hand == TYOKI && computer_hand == PA ||
          player_hand == PA && computer_hand == GU
        
        'lose'
      end
      
      def computer_hand
        [GU, TYOKI, PA].sample
      end
      
      def convert_hand_into_string(hand)
        ['グー', 'チョキ', 'パー'][hand]
      end
    end
    
    private_class_method :player_hand, :jadge, :computer_hand, :convert_hand_into_string
  end
end
