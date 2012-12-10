# encoding: utf-8

Dado /^que o usuário '(.+)' não existe$/ do |usuario|
  u = Usuario.where(:nome => usuario).first
  u.destroy unless u.nil?
end

Dado /^que eu acesso a página inicial$/ do
  visit '/'
end

Então /^eu devo ver a página de registro de jogador$/ do
  pending
end

Então /^eu devo ver a página inicial$/ do
  pending
end
