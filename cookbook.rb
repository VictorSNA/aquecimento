require_relative "receita"

INSERE_RECEITA = 1.freeze
VISUALIZAR_RECEITA = 2.freeze
PESQUISAR_RECEITA = 3.freeze
DELETAR_RECEITA = 4.freeze
SAIR = 5.freeze

def bem_vindo()
  "Bem-vindo ao My Cookbook, sua rede social de receitas culinárias!"
end

def menu()
  puts "\n[#{INSERE_RECEITA}] Cadastrar uma receita"
  puts "[#{VISUALIZAR_RECEITA}] Ver todas as receitas"
  puts "[#{PESQUISAR_RECEITA}] Pesquisar Receita"
  puts "[#{DELETAR_RECEITA}] Deletar Receita"
  puts "[#{SAIR}] Sair"

  print "\nEscolha uma opção: "
  gets.to_i()
end

def inserir_receita
  print "\nDigite o nome da sua receita: "
  nome = gets.chomp
  print "Digite o tipo da sua receita: "
  tipo = gets.chomp

  puts "\nReceita de #{nome.capitalize} do tipo #{tipo.capitalize} cadastrada com sucesso!"
  Receita.new(nome: nome, tipo: tipo)
end

def imprimir_receitas(receitas)
  receitas.each_with_index do |receita, index|
    puts "\n| ID -      NOME      -     TIPO |" if index == 0
    puts "----------------------------------\n" if index == 0
    puts "##{index} - #{receita[0]} - #{receita[1]}" unless index == 0
  end
  puts "\nNenhuma receita cadastrada" if receitas.empty?
end

def atualizar_receitas()
  Receita.load
end

puts bem_vindo
opcao = menu()
receitas = atualizar_receitas()

while opcao != SAIR
  if opcao == INSERE_RECEITA
    receitas << inserir_receita
    Receita.save(receitas)
    receitas = atualizar_receitas()
  elsif opcao == VISUALIZAR_RECEITA
    imprimir_receitas(receitas)
  elsif opcao == PESQUISAR_RECEITA
    puts "Digite o nome da receita que deseja procurar: "
    busca = gets.chomp
    receitas = atualizar_receitas()
    receitas_encontradas = Receita.busca(receitas, busca)
    puts "Receita(s) encontrada(s) = #{receitas_encontradas.count}"
    puts receitas_encontradas
    puts "Nenhuma receita encontrada" if receitas_encontradas.empty?
  elsif opcao == DELETAR_RECEITA
    puts "Digite o nome da receita que você deseja excluir: "
  
    excluir = gets.chomp
    Receita.delete(excluir)
    receitas = atualizar_receitas()
  else
    puts "Opção inválida"
  end
  opcao = menu
end

puts "Obrigado por usar o Cookbook"