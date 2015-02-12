require 'sinatra'
#require 'mysql2'
require 'json'
require "sinatra/reloader" if development?


require './lib/respuesta_api'
require './lib/token'
require './lib/usuario_api'

before do
  content_type 'application/json' #considerar otros formatos
end

post '/autenticar' do
  if UsuarioAPI.autenticar(params[:app_id], params[:clave])
    return RespuestaAPI.ok({ token: Token.generar })
  else
    return RespuestaAPI.error("No está autorizado")
  end
end

get '/estudiantes_y_asignaturas_en_periodo_academico/:periodo_academico_id' do
  
  token = request.env["HTTP_CONEST_TOKEN"]
  if !Token.es_valido?(token)
    return RespuestaAPI.error("Token no válido")
  end

  RespuestaAPI.ok({
    periodo_academico_id: params[:periodo_academico_id],  
    carreras: [
      { 
        id: "C",
        nombre: "COMPUTACION", 
        plan_nombre: "PLAN COMPUTACION",
        estudiantes: [
          { 
            cedula: "123",
            primer_nombre: "Luis",
            segundo_nombre: "",
            primer_apellido: "Torres",
            segundo_apellido: "Armas",
            promedio_general: 12.5,
            eficiencia: 0.9,
            nro_creditos_aprobados: 156,
            materias: [
              {
                codigo: "6014",
                nombre: "Probabilidad y Estadistica",
                nombre_seccion: "C1",
                tipo_materia_id: "O",
                nro_creditos: 5,
                tipo_status_materia: "SC"
              }
            ] #materias
          }
        ] #estudiantes
      }
    ] #carreras
  })  
end

get '/asignaturas_en_periodo_academico/:periodo_academico_id' do
  
  token = request.env["HTTP_CONEST_TOKEN"]
  if !Token.es_valido?(token)
    return RespuestaAPI.error("Token no válido")
  end

  RespuestaAPI.ok({
    periodo_academico_id: params[:periodo_academico_id],
    organizaciones: [
      {
        id: "C",
        nombre: "ESCUELA DE COMPUTACION",
        carreras: [
          {
            id: "C",
            nombre: "COMPUTACION",
            plan_nombre: "PLAN EN COMPUTACION",
            materias: [
              {
                codigo: "6014",
                nombre: "Probabilidad y Estadistica",
                tipo_materia_id: "O",
                grupo_nota_id: "N20",
                coordinador: {
                  cedula: "122",
                  primer_nombre: "Luis",
                  segundo_nombre: "",
                  primer_apellido: "Torres",
                  segundo_apellido: "Armas"
                },
                secciones: [
                  nombre: "C1",
                  docente: {
                    cedula: "122",
                    primer_nombre: "Luis",
                    segundo_nombre: "",
                    primer_apellido: "Torres",
                    segundo_apellido: "Armas"
                  },
                  promedio_general: 9.8,
                  nro_estudiantes: 25,
                  nro_estudiantes_retirados: 2,
                  nro_estudiantes_aprobados: 10,
                  nro_estudiantes_equivalencia: 0,
                  nro_estudiantes_suficiencia: 2,
                  nro_estudiantes_repararon: 1,
                  nro_estudiantes_aplazados: 3,
                  tipo_status_calificacion_id: "C"
                ] #secciones
              }
            ] #materias
          }
        ] #carreras
      }
    ] #organizaciones
  })
end

