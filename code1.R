# Load the necessary packages
library(shiny)
library(leaflet)

# Define UI elements
ui <- fluidPage(
  titlePanel("My Map App"),
  sidebarLayout(
    sidebarPanel(
      helpText("Click a marker to see more information"),
    ),
    mainPanel(
      leafletOutput("map")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Create a data frame with some sample data
  data <- data.frame(
    lng = c(36.8219, 37.0789, 36.8356),
    lat = c(-1.2921, -1.0388, -1.1714), 
    name = c("London", "New York City", "Paris"),
    info = c("Capital of England", "Largest city in the United States", "Capital of France")
  )
  
  # Render the map
  output$map <- renderLeaflet({
    leaflet(data) %>% 
      # Add tiles
      addTiles() %>% 
      # Add markers for each location
      addMarkers(
        ~lng, 
        ~lat,
        # Customize the popup
        popup = paste("<strong>", data$name, "</strong><br>", data$info)
      )
  })
}

# Run the app
shinyApp(ui = ui, server=server)

