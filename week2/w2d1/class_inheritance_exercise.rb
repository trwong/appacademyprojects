class Employee
  attr_reader :salary

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    bonus = @salary * multiplier
  end
end

class Manager < Employee
  attr_reader :salary

  def initialize(name, title, salary, boss, all_employees)
    super(name, title, salary, boss)
    @all_employees = all_employees
  end

  def bonus(multiplier)
    sum = 0
    @all_employees.each do |employee|
      if employee.is_a?(Manager)
        sum += employee.bonus(1)
      end
        sum += employee.salary
    end
    sum * multiplier
  end
end

david = Employee.new("David", "TA", 10_000, 'darren')
shawna = Employee.new("Shawna", "TA", 12_000, 'darren')
darren = Manager.new("Darren","TA Manager", 78_000, 'ned', [shawna, david])
ned = Manager.new("Ned", "Founder", 1_000_000, nil, [darren])
p ned.is_a?(Employee)
p david.bonus(3) # => 30_000
p darren.bonus(4) # => 88_000
p ned.bonus(5) # => 500_000
