require 'json'
require 'digest/sha1'

class RespuestaAPI

  CODIGO_OK = "OK"
  CODIGO_ERROR = "ERROR"

  def self.ok(datos)
    { estatus: CODIGO_OK, 
      mensaje: "-", 
      datos: datos,
      fecha_hora: Time.now,
      sha1_sum: Digest::SHA1.hexdigest(datos.to_json)
    }.to_json
  end

  def self.error(mensaje)
    { estatus: CODIGO_ERROR, 
      mensaje: mensaje, 
      datos: "-",
      fecha_hora: Time.now,
      sha1_sum: "-"
    }.to_json
  end

end