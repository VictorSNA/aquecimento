require 'sqlite3'
class Receita
    attr_accessor :nome, :tipo

    def initialize(nome:, tipo:)
      @nome = nome
      @tipo = tipo
    end

    def to_s
      "#{nome} - #{tipo}"
    end
    
    def include?(termo)
        nome.downcase.include?(termo.downcase)
    end

    def self.busca(receitas,busca)
        receitas.select do |receita|
            receita if receita.include?(busca)
        end
    end

    def self.save(receitas)
        db = SQLite3::Database.open('cookbook.db')

        db.execute <<-SQL, *receitas.last.nome,receitas.last.tipo
            insert into receitas(nome, tipo) values (?, ?)
        SQL
        db.close
    end

    def self.delete(excluir)
        db = SQLite3::Database.open('cookbook.db')
        db.execute <<-SQL, *excluir
            delete from receitas where nome=?
        SQL
        db.close

    end

    def self.load
        receitas = Array.new
        db = SQLite3::Database.open('cookbook.db')

        valores = db.execute2 <<-SQL
            SELECT * FROM receitas
        SQL
        db.close
        
        valores.each do |receita|
            nova_receita = Receita.new(nome: receita[0],tipo: receita[1])
            receitas << [nova_receita.nome, nova_receita.tipo]
        end
    end

  end