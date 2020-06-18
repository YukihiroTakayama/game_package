require "game_package/version"

module GamePackage
  module SanmokuNarabe
    
    WHITE = '○'
    BLACK = '●'
    
    class << self
    
      def start
        bord_info = [nil]*9
        puts "三目並べをはじめます\n"
        puts "先攻か後攻かランダムか決めてください\n"
        puts "先攻：0\n後攻：1\nランダム: 2"
        player_order = gets.to_i
        player_order = [0, 1].sample if player_order == 2
        puts "あなたは#{convert_player_order(player_order)}です。"

        if player_order == 0
          loop do
            bord_info = player_turn(bord_info, player_order)
            break judgement(bord_info, player_order) unless judgement(bord_info, player_order) == 'continu'
            bord_info = computer_turn(bord_info, player_order)
            break judgement(bord_info, player_order) unless judgement(bord_info, player_order) == 'continu'
          end
        else
          loop do
            bord_info = computer_turn(bord_info, player_order)
            break judgement(bord_info, player_order) unless judgement(bord_info, player_order) == 'continu'
            bord_info = player_turn(bord_info, player_order)
            break judgement(bord_info, player_order) unless judgement(bord_info, player_order) == 'continu'
          end
        end
      end
      
      def convert_player_order(player_order)
        return '先攻' if player_order.zero?
        
        '後攻'
      end
      
      def current_bord(bord_info)
        conversion_bord = conversion_bord_info(bord_info)
  
        <<-EOS
        | #{conversion_bord[0]} | #{conversion_bord[1]} | #{conversion_bord[2]} |
        |-----------|
        | #{conversion_bord[3]} | #{conversion_bord[4]} | #{conversion_bord[5]} |
        |-----------|
        | #{conversion_bord[6]} | #{conversion_bord[7]} | #{conversion_bord[8]} |
        EOS
      end
      
      def conversion_bord_info(bord_info)
        bord_info.map.with_index do |stone, i|
          if stone == 'w'
            WHITE
          elsif stone == 'b'
            BLACK
          else
            i
          end
        end
      end
      
      def player_turn(bord_info, player_order)
        puts 'あなたの番です'

        select_number = loop do
          puts current_bord(bord_info)
          puts 'どこを選択しますか？'
          select_number = gets.to_i
          break select_number if (0..8).to_a.include?(select_number) && bord_info[select_number].nil?
  
          puts "選択した場所はすでに選択されているか存在しません\nもう一度選択してください"
        end
        bord_info[select_number] = player_order.zero? ? 'w' : 'b'
        bord_info
      end
      
      def computer_turn(bord_info, player_order)
        puts 'コンピューターの番です'
        3.times { |i| puts '.'; sleep(1) }
        select_number = computer_select(bord_info)
        bord_info[select_number] = player_order.zero? ? 'b' : 'w'
        puts "コンピューターは#{select_number}を選択しました"
        bord_info
      end
      
      def computer_select(bord_info)
        unspecified_space = bord_info.map.with_index { |space, i| i if space.nil? }
        unspecified_space.compact.sample
      end
      
      def check_bord(bord_info)
        bord_lines = bord_info.each_slice(3).to_a
        bord_columns = bord_columns(bord_lines)
        bord_oblique = bord_oblique(bord_lines)
        bord_lines.concat(bord_columns).concat(bord_oblique)

        judgement = { align: false, color: nil }
        bord_lines.each do |line|
          if line.all?('w') || line.all?('b')
            judgement[:align] = true
            judgement[:color] = line.all?('w') ? 'w' : 'b'
          end
        end
        judgement
      end
      
      def bord_columns(bord_lines)
        bord_columns = []
        bord_columns[0] = bord_lines.map { |line| line[0] }
        bord_columns[1] = bord_lines.map { |line| line[1] }
        bord_columns[2] = bord_lines.map { |line| line[2] }
        bord_columns
      end
      
      def bord_oblique(bord_lines)
        bord_oblique = []
        bord_oblique[0] = bord_lines.map.with_index { |line, i| line[i] }
        bord_oblique[1] = bord_lines.reverse.map.with_index { |line, i| line[i] }
        bord_oblique
      end
      
      def judgement(bord_info, player_order)
        return 'draw' unless bord_info.include?(nil)

        judgement = check_bord(bord_info)
        return 'win' if judgement[:align] && player_order == 0 && judgement[:color] == 'w' ||
                        judgement[:align] && player_order == 1 && judgement[:color] == 'b'
        return 'lose' if judgement[:align] && player_order == 0 && judgement[:color] == 'b' ||
                         judgement[:align] && player_order == 1 && judgement[:color] == 'w'
        
        'continu'
      end
    end
      
    private_class_method :convert_player_order, :current_bord, :conversion_bord_info, :player_turn,
                         :computer_turn, :check_bord, :bord_columns, :bord_oblique, :judgement
  end
end