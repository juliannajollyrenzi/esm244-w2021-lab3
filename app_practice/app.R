# This is my app!
# MUST be named "app.R"
# also can include a sub folder for a theme
# www MUST be the name of the subfolder for style

library(tidyverse) # built-in dataset we'll use
library(shiny)

# make a user interface
ui <- fluidPage(theme = "ocean.css", # fluid page means it changes when you expand/contract it. theme is for the CSS in the www subfolder

  navbarPage("THIS IS MY TITLE",
             tabPanel("Thing 1",
                      sidebarLayout(
                        sidebarPanel("WIDGETS!",
                                     checkboxGroupInput(inputId = "pick_species", # ID for ui
                                                        label = "Choose species", # what the user sees
                                                        choices = unique(starwars$species)) # create widgets within panel
                                     ),
                        mainPanel("OUTPUT!",
                                  plotOutput("sw_plot") # THIS IS THE LAST THING!! Put this in after you do output in server
                                  )
                      ) # want a widget and a graph (i.e. sidebar and a main panel)
                      ),
             tabPanel("Thing 2"),
             tabPanel("Thing 3")

  ) # create a navigation bar for tabs and names of tabs

)

# make a server for creating outputs from ui
server <- function(input, output) {

  sw_reactive <- reactive({
    starwars %>%
      filter(species %in% input$pick_species)
  }) # reactive dataframe for the species the user selected (input$pick_species is now a vector of the user selections)

  output$sw_plot <- renderPlot(
    ggplot(data = sw_reactive(), aes(x = mass, y = height)) +
      geom_point(aes(color = species)) # don't forget parenthesis after calling reactive dataset!
  )

}

shinyApp(ui = ui, server = server)






### NOTE: to start do this:
# make a user interface
#ui <- fluidPage()

# make a server for creating outputs from ui
#server <- function(input, output) {}

#shinyApp(ui = ui, server = server)
