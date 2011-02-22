module Antilope
  def antilope
    if self.issn
      "http://anet.ua.ac.be/services.phtml?desktop=ua&service=opacantilope&extra=nrissn=lvd:#{self.issn}"
    end
  end
end
