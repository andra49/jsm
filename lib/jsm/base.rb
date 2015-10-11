module Jsm::Base
  def column(column)
    @column = column
  end

  def state(name, params = {})
    @states ||= Jsm::States.new
    @states.add_state(name, initial: params[:initial])
  end

  def states
    @states.list
  end

  def initial_state
    @states.initial_state
  end

  def event(name, &block)
    @events ||= {}
    if !@events[name].nil?
      raise Jsm::InvalidEventError, "event #{name} has been registered"
    end

    @events[name] = Jsm::Event.new(name, states: @states, &block)
  end

  def events
    @events
  end
end