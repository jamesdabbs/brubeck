class Formula::Atom < Formula
  attr_reader :property, :value

  def initialize property, value
    # TODO: coerce these between ints, bools & models on demand
    @property = property
    @value    = value
  end

  def to_s &block
    block ? block.call(self) : "#{@property} = #{@value}"
  end

  # FIXME: factor out printer object
  def pretty_print
    case value.name
    when "True"
      property.name
    when "False"
      "¬ #{property.name}"
    else
      to_s
    end
  end

  def subformulae
    self
  end

  def atoms
    [self]
  end

  def to_atom
    self
  end

  def ~
    # FIXME: handling of value negation for non-booleans
    # FIXME: negating booleans should not require a database hit
    Atom.new @property, Value.find(@value.compliment).first
  end

  def spaces where=true
    if where.nil?
      set = @property.traits.pluck :space_id
      Space.where('id NOT IN (?)', set).pluck :id
    elsif where
      @property.traits.where(value_id: @value.id).pluck :space_id
    else
      @property.traits.where(value_id: @value.compliment).pluck :space_id
    end
  end

  def verify space
    witness = space.traits.where(property: @property, value: @value).first
    witness.nil? ? false : [witness]
  end

  def force space, assumptions
    description = assumptions.flatten.map { |a| "* #{a.assumption_description}" }.join "\n"
    space.traits.create! property: @property, value: @value, description: description, deduced: true
  end

  def self.load str
    p,v = str.split('=').map &:strip
    property = Atom.parse_name_or_id p, Property
    value    = Atom.parse_name_or_id v, Value
    new property, value
  end

  def self.parse_name_or_id str, klass
    str.to_i.zero? ? klass.where(name: str).first! : klass.find
  rescue => e
    raise ParseError.new "Unrecognized #{klass}: #{str}"
  end
end