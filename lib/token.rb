#require 'mysql2'
require 'json'

class Token

  def self.generar
    "123"
  end

  def self.es_valido?(token)
    token == "123"
  end

end