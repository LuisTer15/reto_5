=begin
  1. Bienvenida a la aplicacion, se abre el mensaje y el usuario pulsa enter 
  para empezar el juego
  2. se muestra la primera pregunta.
  3. si la repsuesta es correcta,  aparece un aviso de correcto y 
  se pasa a la siguiente pregunta
  4. si la respuesta es incorrecta, aparece un aviso de incorrecto y se 
  espera el ingreso de la respuesta correcta
  5. si responde las 5 preguntas seguidas de forma correcta se le 
  felicita y se cierra el juego
=end

require 'yaml'

class YamlReader
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def content
    YAML.load_file(filename)
  end
end

class Question
  def initialize(statement, answer)
    @statement = statement
    @answer = answer
  end

  def ask
    puts @statement
  end

  def check_answer(player_answer)
    @answer == player_answer
  end
end

yaml_content = YamlReader.new('questions.yml').content
questions = yaml_content.map { |statement, answer| Question.new(statement, answer) }

puts "Bienvenido a Reto5, una forma divertida de poner a prueba tus conocimientos!!!"
puts
puts "Solo debes responder de manera correcta las preguntas, para empezar a jugar ingresa tu nombre y pulsa la tecla ENTER..."
puts
print "Ingresa tu nombre: "

player_name = gets.chomp

questions.each do |question|
  player_answer = ''

  while question.check_answer(player_answer) == false
    puts
    question.ask
    puts
    print "Ingresa la respuesta correcta: "
    player_answer = gets.chomp

    if question.check_answer(player_answer)
      puts
      puts "Respuesta correcta, bien hecho #{player_name}!!!"
    else
      puts
      puts "Respuesta incorrecta, vuelve a intentarlo #{player_name}!!!"
    end
  end
end

puts
puts "Felicitaciones has terminado el juego!!!"
puts