class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
    puts "Train #{train} arrived on station."
  end

  def trains_by_type(type)
    trains.select{|train| train.type == type}
  end

  def send_train(train)
    @trains.delete(train)
    puts "#{train} was succesfully send from station."
  end

 end
