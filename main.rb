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
    5 - Добавить вагон поезду.
    6 - Отсоединить вагон от поезда.
    7 - Передвигать поезд.
    8 - Показать станции и поезда.
    0 - Выйти из программы. "
  end

  def show_stations
    puts "Все доступные станции: "
    @stations.each_with_index do |station, index|
    puts "#{index + 1} - #{station.inspect}"
    end
  end

  def show_trains
    puts "Все доступные поезда: "
    @trains.each_with_index do |train, index|
    puts "#{index + 1} - #{train.inspect}"
    end
  end

  def select_train
    train_index = gets.chomp.to_i - 1
    train = @trains[train_index]
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
      add_wagon_to_train
    when 6
      detach_wagon_from_train
    when 7
      train_moving
    when 8
      show_stations
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
    if @stations.size < 2
      puts "Для создания маршрута требуется хотя бы две станции."
      return
    else
      show_stations
      puts "Введите индекс первой станции маршрута: "
      first_station = gets.chomp.to_i - 1
      puts "Введите индекс конечной станции маршрута:"
      last_station = gets.chomp.to_i - 1
      if last_station == first_station
        puts "Первая станция не может быть последней"
        return
      else
        route = Route.new(first_station, last_station)
        @routes << route
        puts "Маршрут создан успешно."
      end
    end
  end

  def add_station
    show_stations
    puts "Введите индекс станции для добавления в маршрут."
    station = gets.chomp.to_i
    @routes.insert(-2, station)
    puts "Станция #{station} успешно добавлена в маршрут."
  end

  def delete_station
    show_stations
    puts "Введите индекс станции для удаления из маршрута."
    station = gets.chomp.to_i
    if station = @routes.include?(station - 1)
     route.delete(station)
     puts "Станция #{station} успешно удалена из маршрута."
    else
     puts ("Такой станции нет")
    end
  end

  def train_route
    puts "Доступные поезда и маршруты: "
    @trains.each do |train|
      puts "#{train.inspect}"
    end
    @routes.each do |route|
      puts "#{route.inspect}"
    end

    puts "Введите индекс поезда и маршрута -  "
    select_train
    route_index = gets.chomp.to_i - 1
    route = @routes[route_index]
    train.set_route(route)
    puts "Маршрут задан успешно."
  end

  def add_wagon_to_train
    show_trains
    puts "Введите индекс поезда: "
    select_train
    puts "Введите тип вагона 1 - грузовой, 2 - пассажирский: "
      wagon_type = gets.chomp.to_i
      case wagon_type
      when 1
        wagon = CargoWagon.new
        puts "Введите вагон для присоединения:"
        wagon = gets.chomp
        train.add_wagon(wagon)
        puts "Грузовой вагон добавлен успешно."
      when 2
        wagon = PassangerWagon.new
        puts "Введите вагон для присоединения:"
        wagon = gets.chomp
        train.add_wagon(wagon)
        puts "Пассажирский вагон добавлен успешно."
      end
  end

  def detach_wagon_from_train
    show_trains
    puts "Введите индекс поезда: "
    select_train
    puts "Введите вагон для удаления:"
    wagon = gets.chomp
    remove_wagon(wagon)
    puts "Вагон отсоединён успешно."
  end

  def train_moving
    show_trains
    puts "Введите индекс поезда: "
    select_train
    puts "Введите 1 для движения поезда вперед, 2 для движения назад."
    action = gets.chomp.to_i
    case action
      when 1
        train.move_forward
        puts "Поезд проехал вперед."
      when 2
        train.move_back
        puts "Поезд проехал назад."
      end
  end

  def show_stations_and_trains
    @stations.each do |station|
      puts "Все станции и поезда на них: #{station.inspect}"
      end
  end

end

main = Main.new
main.start
