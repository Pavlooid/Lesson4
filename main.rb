require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'passanger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passanger_wagon'

class Main
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def start
  puts "Здравствуйте! Добро пожаловать в интерфейс управления железной дорогой."
  loop do
    commands
    print "Укажите номер требуемой команды: "
    command = gets.chomp.to_i
    break if command == 0
    do_command(command)
    end
  end

  private #private, потому что методы используются только в классе Main

  def commands
    puts "Доступные команды:
    1 - Создать станцию.
    2 - Создать поезд.
    3 - Управление маршрутом.
    4 - Назначить маршрут поезду.
    5 - Управление вагонами.
    6 - Перемещение поезда.
    7 - Просмотреть список станций и поездов на станции.
    0 - Выйти из программы. "
  end

  def do_command(number)
    case number
    when 1
      create_station
    when 2
      create_train
    when 3
      manage_route
    when 4
      train_route
    when 5
      create_wagons
    when 6
      train_moving
    when 7
      show_stations_and_train
    end
  end

  def create_station
    puts "Введите название для станции:"
    station_name = gets.chomp.to_s
    station = Station.new(station_name)
    puts "Станция #{station_name} успешно создана."
    @stations << station
  end

  def create_train
    puts "Введите 1 для создания грузового поезда, 2 для пассажирского."
    train_type = gets.chomp.to_i
    puts "Введите номер поезда:"
    train_number = gets.chomp.to_i
    if train_type == 1
      cargo_train = CargoTrain.new(train_number)
      @trains << cargo_train
      puts "Создан поезд #{train_number} грузового типа."
    elsif train_type == 2
      passanger_train = PassangerTrain.new(train_number)
      @trains << passanger_train
      puts "Создан поезд #{train_number} пассажирского типа."
    end
  end

  def manage_route
    puts "Введите требуемую команду:
    1 - Создать маршрут.
    2 - Добавить станцию в существующий маршрут.
    3 - Удалить станцию из существующего маршрута."
    action = gets.chomp.to_i
    case action
      when 1
        create_route
      when 2
        add_station
      when 3
        delete_station
      end
  end

  def create_route
    puts "#{@stations} - все доступные станции. Введите первую станцию маршрута: "
    first_station = gets.chomp.to_s
    #if first_station = @stations.include?(first_station)
      #puts ("Первая станция установлена - #{first_station}.")
    #else
      #puts ("Такой станции нет.")
      #break
    puts "Введите конечную станцию маршрута:"
    last_station = gets.chomp.to_s
    if last_station = @stations.include?(last_station)
      #puts ("Последняя станция установлена - #{last_station}.")
    #else
      #puts ("Такой станции нет.")
      #break
    route = Route.new(first_station, last_station)
    @routes << route
    puts "Маршрут #{route.inspect} создан успешно."
  end

  def add_station
    puts "Введите название станции для добавления в маршрут."
    station = gets.chomp.to_s
    puts "Введите расположение станции цифрой от начала."
    position = gets.chomp.to_i
    #@routes.insert(position, station)
    puts "Станция #{station} успешно добавлена в маршрут."
  end

  def delete_station
    puts "Введите название станции для удаления из маршрута."
    station = gets.chomp.to_s
    if station = @routes.include(station)
     #@routes.delete(station)
     #puts "Станция #{station} успешно удалена из маршрута."
    #else
     #puts ("Такой станции нет")
    #end
  end

  def train_route(train, route)
  end

  def create_wagons
  end

  def train_moving
  end

  def show_stations_and_train
    print "Все станции: "
    @stations.each do |station|
      print "#{station}, "
      #дописать поезда
  end

end

main = Main.new
main.start
