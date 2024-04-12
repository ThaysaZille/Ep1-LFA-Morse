class TradutorCodigoMorse
	MORSE_PARA_ALFABETO = {
		".-" => "a", "-..." => "b", "-.-." => "c", "-.." => "d", " " => " ",
		"." => "e", "..-." => "f", "--." => "g", "...." => "h", "..--" => "u", 
		".." => "i", ".---" => "j", "-.-" => "k", ".-.." => "l", "----" => "ch",
		"--" => "m", "-." => "n", "---" => "o", ".--." => "p", ".-.-." => "",
		"--.-" => "q", ".-." => "r", "..." => "s", "-" => "t",
		"..-" => "u", "...-" => "v", ".--" => "w", "-..-" => "x",
		"-.--" => "y", "--.." => "z", ".----" => "1", "..---" => "2",
		"...--" => "3", "....-" => "4", "....." => "5", "-...." => "6",
		"--..." => "7", "---.." => "8", "----." => "9", "-----" => "0",
		"--..--" => ",", "-....-" => "-", ".-.-.-" => "."
	}

	def proximo_simbolo
		print "\nDigite o próximo símbolo Morse (se não deseja continuar, digite 'n'): "
		gets.chomp
	end

	def iniciar
		loop do
			puts "Máquina iniciada no estado: #{@estado_atual}"
			while true
				entrada = proximo_simbolo

				if entrada.downcase == 'n'
					if MORSE_PARA_ALFABETO.key?(@caractere_atual)
						if @estado_atual == "q12"
							puts "Aceito, código Morse encontrado"
							@frase_traduzida << MORSE_PARA_ALFABETO[@caractere_atual]
							puts "Caractere correspondente: \"vazio\""
							break
						else
							puts "Aceito, código Morse encontrado"
							@frase_traduzida << MORSE_PARA_ALFABETO[@caractere_atual]
							puts "Caractere correspondente: #{MORSE_PARA_ALFABETO[@caractere_atual]}"
							break
						end
					else
						puts "Erro, código Morse não encontrado"
						break
					end
				end

				unless entrada.match(/(\.| |-)/) || entrada.downcase == 'n'
					puts "Erro, símbolo Morse inválido. Por favor, insira apenas '.' (ponto), '-' (traço) ou espaço."
					next
				end

				# Verifica a transição de estado para o próximo caractere Morse
				transicoes = transicoes(@estado_atual)
				transicao = transicoes.find { |trans| entrada.match(/#{trans[0]}/) }

				if transicao
					@estado_atual = transicao[1]
					@caractere_atual << entrada
				end
			end
		end
		puts "\nFrase traduzida: #{@frase_traduzida}"
	end

	def transicoes(estado)
		case estado
		when "q0"
			[["\\.", "q1"], ["-", "q6"], [" ", "q12"]]
		when "q1"
			[["\\.", "q2"], ["-", "q7"], ["", "q1"]]
		when "q2"
			[["\\.", "q3"], ["-", "q8"], ["", "q2"]]
		when "q3"
			[["\\.", "q4"], ["-", "q9"], ["", "q3"]]
		when "q4"
			[["\\.", "q5"], ["-", "q10"], ["", "q4"]]
		when "q5"
			[["", "q5"]]
		when "q6"
			[["-", "q7"], ["\\.", "q2"], ["", "q6"]]
		when "q7"
			[["-", "q8"], ["\\.", "q3"], ["", "q7"]]
		when "q8"
			[["-", "q9"], ["\\.", "q4"], ["", "q8"]]
		when "q9"
			[["-", "q10"], ["\\.", "q5"], ["", "q9"]]
		when "q10"
			[["", "q10"]]
		when "q12"
			[["", "q12"]]
		else
			[]
		end
	end
end

tradutor = TradutorCodigoMorse.new
tradutor.iniciar
