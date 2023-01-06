#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#change lat and long
library(shiny)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)


function(input, output, session) {
  #colourpalette
  myPal  <- colorNumeric(palette = "Spectral", domain = mydata$values, na.color = "transparent")
  
  #Label on a pop-up window
  LABELS <- paste(mydata$NAME_LATN, tgs00007_shp$values)
  
  output$map <- renderLeaflet({
    mydata %>%
    st_transform(crs = 4326) %>%
    leaflet() %>%
      addProviderTiles(providers$Esri.WorldGrayCanvas) %>%
        setView(lng = 25.5, lat = 45.5, zoom = 6) %>%
          addPolygons(weight = 1,
                  color = "white",
                  fillColor = ~myPal(values),
                  fillOpacity = 0.7, 
                  label = LABELS) %>%
            addLegend("topright", pal = myPal, values = ~values,
                  title = "",
                  opacity = 0.7)
  })

# Show a popup at the given location
showregPopup <- function(region, lat, lng) {
  selectedreg <- mydata[mydata$NUTS_ID == NUTS_ID,]
  content <- as.character(tagList(
    sprintf("Random data: %s", as.integer(selectedreg$norm)), tags$br(),
    sprintf("Employment data: %s%%", as.integer(selectedreg$values))
  ))
  leafletProxy("map") %>% addPopups(lng, lat, content, layerId = region)
}

# When map is clicked, show a popup with city info
observe({
  leafletProxy("map") %>% clearPopups()
  event <- input$map_shape_click
  if (is.null(event))
    return()
  
  isolate({
    showregPopup(event$id, event$lat, event$lng)
  })
})


}
