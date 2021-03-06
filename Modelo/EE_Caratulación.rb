  #encoding: utf-8
  # Alta de documento GEDO
  #############################################################
  require 'watir-webdriver'
  require 'logger'
  #Levantar las constantes declaradas
  require '../constantes.rb'
  # Genera los dorectorios de logs
  require '../0000_Directorios_GEDO.rb'
  require './login.rb'
  # Clases de expediente
  require './expediente.rb'

  #Recibe por parámetro la ruta del archivo de configuración y el módulo al cual ingresar
  login = Login.new("C:/Users/cargauto/Documents/GitHub/AutomatizacionesGEDO/json/configuraciones.json","EE")
  login.ingresar()
  browser = login.getBrowser()

  expediente = Expediente.new(browser)
  expediente.vincularDocumentoPorNumeroSADE()
  #expediente.paseDestinoIniciacion()

  #expediente.paseDestinoComunicacion()
  #expediente.paseDestinoTramitacion()
  expediente.paseDestinoGuardaTemporalFinal('Pase automatizado')
  #expediente.caratularInterno()
  ##########
  expediente.consultaExpedientesPorNumeroSADE("2016", "00090646", "CHARLY")
  expediente.tramitarEjecutarTarea() # Funciona OK
  #
  # NUEVOS MÉTODOS PARA REALIZAR PASES
  #expediente.paseDestinoIniciacionDestinoUsuario('Pase automatizado') # OK
  #expediente.paseDestinoIniciacionDestinoSector('Pase automatizado') # OK
  #expediente.paseDestinoIniciacionDestinoMesaDeLaReparticion('Pase automatizado') # OK
  expediente.paseDestinoTramitacionDestinoMesaDeLaReparticion('Pase automatizado') # OK
  expediente.paseDestinoEjecucionDestinoMesaDeLaReparticion('Pase automatizado') # OK
  expediente.paseDestinoSubsanacionDestinoMesaDeLaReparticion('Pase automatizado') # OK
  expediente.paseDestinoComunicacionDestinoUsuario('Pase automatizado') # OK
  #expediente.paseDestinoSubsanacionDestinoMesaDeLaReparticion('Pase automatizado') # OK
  #expediente.tramitarAdquirirTareaEjecutar() # OK
  expediente.realizarPaseSinCambioEstadoDestinoUsuario('Pase automatizado') # OK
  #expediente.realizarPaseSinCambioEstadoDestinoMesaDeLaReparticion('Pase automatizado')  # OK
  expediente.realizarPaseSinCambioEstadoDestinoSector('Pase automatizado') # OK
  

  #
  expediente.tramitarEjecutarTarea()
  expediente.realizarPaseSinCambioEstadoDestinoSector('Pase automatizado')
  ####
  expediente.realizarPaseSinCambioEstadoDestinoUsuario('Pase automatizado')
  
  ##########
  #expediente.tramitarAdquirirTarea()


  imagenes = browser.images
  imagenes.each do |imagen|
    if imagen.title == "Ver expediente"
      imagen.click
    end
  end

      botonera = browser.spans(:class => 'z-label') 
      botonera.each do |boton|
        if (boton.title == "Tramitar Expediente")
          boton.click
        end
      end

      botonera = self.getBrowser().lis(:class => 'z-menu-item')
      botonera.each do |boton|
        if (boton.title == "Tramitar Expediente")
          boton.click
        end
      end

      browser.lis(:class => 'z-menu-item')[8].click

  expediente.parsearBotonesTramitarExpediente()

######
      botonesImagenes = self.getBrowser().div(:class => 'z-window-highlighted-cnt').images
      botonesImagenes.each do |imagen|
        rutaImagenSplit = imagen.src.split('/')
        nombreImagen = rutaImagenSplit[rutaImagenSplit.length - 1]
        botoneraEE = self.getBotoneraEEParseo()
        #
        if nombreImagen == botoneraEE['botonera']['transversal']['RealizarPase']
            imagen.click
          end
        end
######
expediente.getBrowser().text_field(:class => 'z-bandbox-inp')[5]
#####

#$('.z-bandbox-inp').size

  browser.spans(:class => 'z-tab-text').find(browser.span(:class => 'z-tab-text').text == "Consultas")
  browser.spans(:class => 'z-button')[1].click()

  botonera = browser.spans(:class => 'z-tab-text') 
  botonera.each do |boton|
    if (boton.text == "Consultas")
      boton.click
    end
  end

  #############################################################