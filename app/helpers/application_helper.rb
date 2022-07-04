module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # A method that prints the class hierachy of an object and returns the class of the object. (For practise purposes)
  def print_hierarchy(obj = nil)   
    clazz = obj.class
    objClass = clazz.to_s
    level = 1
    while clazz != nil do
      puts "-" * level + clazz.to_s
      clazz = clazz.superclass
      level += 1
    end
    return objClass
  end

  def in_tz(date = Time.now, tz = "Africa/Johannesburg")
    return date.in_time_zone(tz)
  end
end
