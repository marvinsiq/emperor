# Helper methods defined here can be accessed in any controller or view in the application

Emperor.helpers do

  def todos_clas_select
    clas = [['Selecione...', nil]]
    Cla.all.each do |c|
      clas << [c.nome, c.id]
    end

    return clas
  end

  def gera_codigo_ativacao(tamanho=50)
    grupo = %w{ 0 1 2 3 4 5 6 7 8 9 A a B b C c D d E e F f G g H h I i J j K k L l M m N n O o P p Q q R r S s T t U u V v W w X x Y y Z z}
    (0...tamanho).map{ grupo.sample }.join
  end

end
