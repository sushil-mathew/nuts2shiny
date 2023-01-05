#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

# Choices for drop-downs: Have it in this format, perhaps add countries
#vars <- c(
#  "Is SuperZIP?" = "superzip",
#  "Centile score" = "centile",
#  "College education" = "college",
#  "Median income" = "income",
#  "Population" = "adultpop"
#)

#x <- runif(n1) where n is the number of nuts2
#y <- runif(n2) same as above

#do the same for 


navbarPage("Interactive Maps", id="nav",
           
           tabPanel("NUTS2",
                    div(class="outer",
                        
                        tags$head(
                          # Include our custom CSS
                          includeCSS("styles.css"),
                          includeScript("gomap.js")
                        ),
                        
                        # If not using custom CSS, set height of leafletOutput to a number instead of percent
                        leafletOutput("map", width="100%", height="100%"),
                        
                        # Change the adultpop to region, and add a default country and variable
                        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                      draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                      width = 330, height = "auto",
                                      selectInput("country", "Country", vars),
                                      selectInput("region", "Region", vars, selected = "adultpop"),
                                      selectInput("var", "Variable", vars, selected = "index"),
                        ),
                        
                        tags$div(id="cite",
                                 'Data compiled for ', tags$em('Index'), ' by Sushil Mathew(2022)'
                        )
                    )
           ),
           
           tabPanel("NUTS2",
                    div(class="outer",
                        
                        tags$head(
                          # Include our custom CSS
                          includeCSS("styles.css"),
                          includeScript("gomap.js")
                        ),
                        
                        # If not using custom CSS, set height of leafletOutput to a number instead of percent
                        leafletOutput("map", width="100%", height="100%"),
                        
                        # Change the adultpop to region, and add a default country and variable
                        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                      draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                      width = 330, height = "auto",
                                      selectInput("country", "Country", vars),
                                      selectInput("region", "Region", vars, selected = "adultpop"),
                                      selectInput("var", "Variable", vars, selected = "index"),
                        ),
                        
                        tags$div(id="cite",
                                 'Data compiled for ', tags$em('Index'), ' by Sushil Mathew(2022)'
                        )
                    )
           )
)