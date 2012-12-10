# Emperor

## Preparação do ambiente de desenvolvimento Ruby.

### Instação via pacotes precompilados (ambientes baseados em Fedora/CentOS/HedRat).

#### Compilador C/C++
yum install gcc-c++

#### Dependências do RVM
yum install git curl bison patch make

#### Dependências do Ruby
yum install readline readline-devel zlib zlib-devel libyaml-devel libffi-devel iconv-devel

#### Pacotes adicionais que podem ser requeridos em alguns frameworks como Rails e Padrino
yum install libxslt-devel sqlite-devel openssh openssl-devel

### É de suma importância não instalar o RVM, Ruby e Gems como root.

#### Instalando RVM - Ruby Version Manager
bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)

#### Recarregue seu ambiente shell ou feche e abra o terminal
source ~/.bash_profile

#### Instalando Ruby.

rvm install 1.9.3

Este comando instala:

* Ruby 1.9.3p125
* IRB 0.9.6
* RubyGems 1.8.17
* Bundler 1.0.22

Caso dê o erro: "ERROR: rvm requires autoreconf to install the selected ruby interpreter however autoreconf was not found in the PATH." instale o pacore automake.

sudo apt-get install automake

#### Carregando o ruby e definindo uma versão padrão
rvm use 1.9.3 --default

Caso dê o erro: "RVM is not a function, selecting rubies with 'rvm use ...' will not work." vá até o menu Editar - Perfis do Terminal. Clique em editar e na aba "Título e Comando" marque o checkbox "Executar comando como shell de sessão".

-----

### Instação via compilação do código fonte

#### Instalando libyaml

$ wget http://pyyaml.org/download/libyaml/yaml-0.1.4.tar.gz

$ tar xzvf yaml-0.1.4.tar.gz

$ cd yaml-0.1.4

$ ./configure --prefix=/usr/local

$ make

$ sudo make install

#### Instalando Ruby 1.9.3-p0

$ wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p0.tar.gz

$ tar xzvf ruby-1.9.3-p0.tar.gz

$ cd ruby-1.9.3-p0

$ ./configure --prefix=/usr/local --enable-shared --disable-install-doc --with-opt-dir=/usr/local/lib

$ make

$ sudo make install

### Instalando Ruby-Gems

$ wget http://rubyforge.org/frs/download.php/75711/rubygems-1.8.15.tgz

$ tar -zxvf rubygems-1.8.15.tgz

$ cd rubygems-1.8.15

$ sudo ruby setup.rb

#### Instalando Bundle
$ gem install bundler

----

### Instalando Padrino
gem install padrino

### Configuração do git
* http://help.github.com/linux-set-up-git/
* http://git.or.cz/course/svn.html

### Download do Projeto
git clone git@github.com:mgalvao/emperor.git

### Instalação do Projeto

### Entre na pasta do projeto
cd emperor

### Baixar dependências do projeto
bundle install

### Criação do esquema de dados
padrino rake ar:migrate

### Povoamento de dados
padrino rake seed

### Execução
padrino start

### Aplicação disponível na URL [http://localhost:3000](http://localhost:3000)
