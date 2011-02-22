module DocumentBase
  def authors
    result = []
    result += by_people if self.respond_to?('by_people')
    result += by_organisations if self.respond_to?('by_organisations')
    result
  end

  def subjects
    result = []
    result += about_people if self.respond_to?('about_people')
    result += about_organisations if self.respond_to?('about_organisations')
    result += about_productions if self.respond_to?('about_productions')
    result
  end
  
  def author_relations
    result = []
    by_people_method = "#{self.class.name.underscore}_by_people"
    result += self.send(by_people_method) if self.respond_to?(by_people_method)
    by_organisations_method = "#{self.class.name.underscore}_by_organisations"
    result += self.send(by_organisations_method) if self.respond_to?(by_organisations_method)
    result
  end
  
  def subject_relations
    self.send("#{self.class.name.underscore}_about_people") + self.send("#{self.class.name.underscore}_about_organisations") + self.send("#{self.class.name.underscore}_about_productions")
  end
end