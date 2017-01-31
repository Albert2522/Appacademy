class Employee
  attr_accessor :name, :title, :sallary, :boss

  def initialize(name, sallary, title, boss = nil)
    @name = name
    @title = title
    @sallary = sallary
    @boss = boss
    if !boss.nil?
      @boss.add_employee(self)
    end
  end

  def bonus(mult)
    @sallary * mult
  end

end

class Manager < Employee
  attr_accessor :employees

  def initialize(name, sallary, title, boss = nil)
    @employees = []
    super
  end

  def add_employee(emp)
    self.employees << emp
  end

  def bonus(mult)
    acc = 0
    q = @employees.dup
    until q.empty?
      person = q.shift
      acc += person.sallary * mult
      q += person.employees if person.is_a? Manager
    end
    acc
  end

end

n = Manager.new("Ned", 1_000_000, "Founder")
da = Manager.new("Darren", 78_000, "TA Manager", n)
s = Employee.new("Shawna", 12_000, "TA", da)
d = Employee.new("David", 10_000, "TA", da)


p n.bonus(5) == 500_000
p da.bonus(4) == 88_000
p d.bonus(3) == 30_000
