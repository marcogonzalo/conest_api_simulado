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
          },
          { 
            cedula: "18132323",
            primer_nombre: "Gonzalo",
            segundo_nombre: "",
            primer_apellido: "Torres",
            segundo_apellido: "Ramírez",
            promedio_general: 12.23,
            eficiencia: 0.86,
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
          },
          { 
            cedula: "14516831",
            primer_nombre: "Adela",
            segundo_nombre: "Aylin",
            primer_apellido: "Mires",
            segundo_apellido: "Dahn",
            promedio_general: 17.5,
            eficiencia: 0.96,
            nro_creditos_aprobados: 142,
            materias: [
              {
                codigo: "6014",
                nombre: "Probabilidad y Estadistica",
                nombre_seccion: "C2",
                tipo_materia_id: "O",
                nro_creditos: 5,
                tipo_status_materia: "SC"
              }
            ] #materias
          },
          { 
            cedula: "17765685",
            primer_nombre: "Luis",
            segundo_nombre: "Andrés",
            primer_apellido: "Torrenegra",
            segundo_apellido: "Armas",
            promedio_general: 12,
            eficiencia: 1,
            nro_creditos_aprobados: 157,
            materias: [
              {
                codigo: "6014",
                nombre: "Probabilidad y Estadistica",
                nombre_seccion: "C1",
                tipo_materia_id: "O",
                nro_creditos: 5,
                tipo_status_materia: "SC"
              },
              {
                codigo: "6221",
                nombre: "APLIC.CON LA TEC.INTERNET",
                tipo_materia_id: "E",
                nombre_seccion: "C1",
                nro_creditos: 5,
                tipo_status_materia: "SC"
              },
              {
                codigo: "6201",
                nombre: "Algoritmos y Estructuras de Datos",
                tipo_materia_id: "O",
                nombre_seccion: "C1",
                nro_creditos: 5,
                tipo_status_materia: "SC"
              }
            ] #materias
          },
          { 
            cedula: "21258123",
            primer_nombre: "Manuela",
            segundo_nombre: "Alicia",
            primer_apellido: "Vergara",
            segundo_apellido: "Torres",
            promedio_general: 15.5,
            eficiencia: 1,
            nro_creditos_aprobados: 162,
            materias: [
              {
                codigo: "6221",
                nombre: "APLIC.CON LA TEC.INTERNET",
                tipo_materia_id: "E",
                nombre_seccion: "C1",
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
		            cedula: "12243532",
		            primer_nombre: "Luis",
		            segundo_nombre: "Rafael",
		            primer_apellido: "Armas",
		            segundo_apellido: "Armas"
                },
                secciones: [
					{
		              nombre: "C1",
		              docente: {
		                cedula: "12243532",
		                primer_nombre: "Luis",
		                segundo_nombre: "Rafael",
		                primer_apellido: "Armas",
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
					},
					{
		              nombre: "C2",
		              docente: {
		                cedula: "17458565",
		                primer_nombre: "Andrés",
		                segundo_nombre: "Rafael",
		                primer_apellido: "Ramírez",
		                segundo_apellido: "Armas"
		              },
		              promedio_general: 10.85,
		              nro_estudiantes: 18,
		              nro_estudiantes_retirados: 2,
		              nro_estudiantes_aprobados: 10,
		              nro_estudiantes_equivalencia: 0,
		              nro_estudiantes_suficiencia: 2,
		              nro_estudiantes_repararon: 1,
		              nro_estudiantes_aplazados: 3,
		              tipo_status_calificacion_id: "C"
					}
                ] #secciones
              },
              {
                codigo: "6201",
                nombre: "Algoritmos y Estructuras de Datos",
                tipo_materia_id: "O",
                grupo_nota_id: "N20",
                coordinador: {
                  cedula: "4259862",
                  primer_nombre: "Luis",
                  segundo_nombre: "",
                  primer_apellido: "Fernández",
                  segundo_apellido: "Armas"
                },
                secciones: [
                  nombre: "C1",
                  docente: {
                    cedula: "4259862",
                    primer_nombre: "Luis",
                    segundo_nombre: "",
                    primer_apellido: "Fernández",
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
              },
              {
                codigo: "6221",
                nombre: "APLIC.CON LA TEC.INTERNET",
                tipo_materia_id: "E",
                grupo_nota_id: "N20",
                coordinador: {
                  cedula: "9864565",
                  primer_nombre: "Luis",
                  segundo_nombre: "",
                  primer_apellido: "Torres",
                  segundo_apellido: "Armas"
                },
                secciones: [
                  nombre: "C1",
                  docente: {
                    cedula: "9864565",
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
              },
              {
                codigo: "6536",
                nombre: "LAB. GEN ( BASE DE DATOS)",
                tipo_materia_id: "L",
                grupo_nota_id: "N20",
                coordinador: {
                  cedula: "11255865",
                  primer_nombre: "Félix",
                  segundo_nombre: "",
                  primer_apellido: "Tovar",
                  segundo_apellido: "Armas"
                },
                secciones: [
                  nombre: "C1",
                  docente: {
		              cedula: "11255865",
		              primer_nombre: "Félix",
		              segundo_nombre: "",
		              primer_apellido: "Tovar",
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

