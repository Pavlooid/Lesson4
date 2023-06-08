class Train
  attr_accessor :speed
  attr_reader :wagons, :type

  def initialize(number)
    @speed = 0
    @number = number
    @wagons = []
  end

  def stop
    self.speed = 0
  end

  def add_wagon(wagon)
    wagons << wagon if (speed == 0) && wagon.type == type
  end

  def remove_wagon(wagon)
      if @speed == 0 && @wagons.size > 0
        @wagons.delete(wagon)
      end
  end

  def route(route)
    @route = route
    route.stations.first.add_train(self)
    @index = 0
  end

  def move_forward
    current_station.send_train(self)
    current_station.add_train(self)
    @index += 1
  end

  def move_back
    current_station.send_train(self)
    current_station.add_train(self)
    @index -= 1
  end

  def current_station
    route.stations[@index]
  end

  def next_station
    route.stations[@index + 1]
  end

  def last_station
    route.stations[@index - 1]
  end

end
