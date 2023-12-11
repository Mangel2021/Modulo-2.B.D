

# EL siguiente origen de los datos es OpenSource o Bigdata 1pts -----------

#https://geoportalgasolineras.es/geoportal-instalaciones/DescargarFicheros

El origen de los datos es opensource principalmente porque no has tenido
que aceptar ciertos permisos de uso. Tienes libertad completa para hacer
uso de los datos de la forma que lo consideres. Otra pista que nos dice
que es open data es el hecho de que son datos aportados por un organismo 
público. En adición,el dataset no tiene el volumen necesario para ser bigdata.
Se cita explicitamente la posibilidad de la utilización de los datos de forma libre. 

# Obtenga los datos de forma remota y léalos en el estudio ----------------
Lo haces a través de la api

install.packages('tidyverse', 'jsonlite', 'janitor','dplyr')
install.packages('janitor')
library('tidyverse')
library('jsonlite')
library('janitor')
library('dplyr')

jsonlite::fromJSON('https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/')
install.packages('Rtools')
No iba, puso ed delante, pasó algo, y luego lo quitó y lo corrió. 
EL ed sirve para comprobar el tipo de error y ver de quien es el problema

ds <- fromJSON('https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/')
ds%>%view
ds_chicha <- ds$ListaEESSPrecio %>%view

# EDA ---------------------------------------------------------------------

## Los datos contienen espacios, acentos, símbolos y caracteres extraños,
## Los numéricos deberian ser reales o integer y no char


# Limpieza de Datos -------------------------------------------------------

ds_chicha %>% clean_names() %>% as_tibble() %>% glimpse()

##si no va: 
  
ds_chicha %>% janitor::clean_names() %>% as_tibble() %>% glimpse()

ds_cleaned <- ds_chicha %>% clean_names() %>% as_tibble() %>% as_tibble()

##Es todo tipo char, hay que arreglarlo
locale()
## vemos el encoding, y ahora hay que ver el encoding que están utilizando. Así como otros parametros
## Como todos los números tienen la coma, no sale. No coincide con el formato España.
##si no va locale, hacemos los siguiente: 

locale <- locale(decimal_mark= ",")
locale(decimal_mark = ",")
type.convert(ds_cleaned, locale = locale(decimal_mark = ",")) %>% glimpse()
ds_cleaned_num <- type.convert(ds_cleaned, locale = locale(decimal_mark = ",")) %>% glimpse()


# Gasolinera más barata ---------------------------------------------------
ds_cleaned_num %>% select(precio_gasoleo_a, rotulo, direccion, localidad) %>%
filter(localidad =='ALCOBENDAS') %>% arrange(precio_gasoleo_a) %>% top_n(-10) %>% view
#el top es para ver los 10 más baratas

# Preguntas ---------------------------------------------------------------








