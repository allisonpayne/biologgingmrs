library(shiny)
library(jsonlite)

#define ui
overview_ui <- navbarPage(
  #app title
  "Data standardization for animal welfare", 
  #panels
  tabPanel("Overview", 
           fluidPage(
             #add title
             fluidRow(
               column(4, 
                      h2("Minimum reporting standards can promote animal welfare and data quality in biologging research"), 
                      p("This app provides a tool for reporting metadata about biologging instruments. 
                        It should be used by researchers who do not provide metadata through another avenue, such as Movebank.
                        When you have filled out the checklist, you will be able to download your answers as a .json file, 
                        which can be included as supplemental material with your article."),
                      p("Using generalizations from the known effects of biologging instruments across taxa, 
                        we collated a list of instrument characteristics for consideration throughout the process 
                        of instrument development, deployment, and data dissemination. Reporting characteristics such as the ratio between 
                        instrument/animal body mass or the ratio between instrument/animal cross-sectional area, 
                        can help to evaluate, update, and develop “rules of thumb” that can be useful when 
                        developing new instruments and instrumenting new species."), 
                      p("As biologging researchers, we are aware of the burden of additional bureaucracy imposed by 
                        reporting standards. We have attempted to be thoughtfully exclusive in selecting the reporting 
                        checklist categories so as to decrease the burden on researchers who may adopt it. The 
                        categories aim to provide structure and facilitate transparency, balancing the complexity of 
                        biologging tools with the highest priorities for future research.")
               ), 
               column(8, 
                      img(src = "https://allisonpayne.github.io/projects/biologging-impacts/figure1_final.png", 
                          width = "100%"), 
                      h4(strong("About")),
                      p(
                        "This checklist is associated with Payne et al.:", 
                        a(href = "https://ecoevorxiv.org/repository/view/6784/", "Towards a minimum reporting standard to promote animal welfare and data quality in biologging research.")),
                      p("The application was developed by ",
                        a(href = "https://www.allisonpayne.github.io/", "Allison Payne,"),
                        " adapted from similar applications created for the",
                        a(href = "https://github.com/BalazsAczel/TransparencyChecklist", "Transparency Checklist"),
                        "and the ", 
                        a(href = "https://prisma.shinyapps.io/checklist/", "PRISMA Checklist"),
                        "The full source code for the Shiny app is available via the ",
                        a(href = "https://github.com/allisonpayne", "GitHub repository.") #TO UPDATE
                      ),)
             ), 
           )), 
  tabPanel("Checklist", 
           fluidPage(
             ##ANIMAL CHARACTERISTICS SECTION##
             h2("Animal characteristics"), 
             h3("Species information"), 
             textInput(inputId = "sciname", 
                       label = "Scientific name", 
                       width = "70%"), 
             textInput(inputId = "commonname", 
                       label = "Common name", 
                       width = "70%"),
             h3("Number of deployments"), 
             numericInput(inputId = "noanimals", 
                          label = "Number of animals instrumented in this configuration as part of this study.", 
                          value = 1, min = 1, max = 10000, step = 1, 
                          width = "70%"), 
             numericInput(inputId = "nodevices", 
                          label = "Number of devices deployed on each animal", 
                          value = 1, min = 1, max = 10, step = 1, 
                          width = "70%"), 
             p("The number of instruments the animal is carrying during this deployment, including devices for which data are not analyzed in the current analysis."), 
             h3("Animal handling"), 
             numericInput(inputId = "handletime", 
                          label = "Animal handling time",
                          value = 10, min = 1, max = 1000, step = 1, 
                          width = "70%"),
             selectInput(inputId = "handleunits", 
                         label = "Animal handling time units",
                         choices = c("seconds", "minutes", "hours"), 
                         selected = "minutes",
                         multiple = FALSE,
                         width = "70%"), 
             h3("Animal measurements"), 
             numericInput(inputId = "anweight", 
                          label = "Animal weight", 
                          value = 10, min = 1, max = 10000, step = 1, 
                          width = "70%"), 
             selectInput(inputId = "anweightunits", 
                         label = "Animal weight units",
                         choices = c("milligrams", "grams", "kilograms"), 
                         selected = "grams",
                         multiple = FALSE,
                         width = "70%"), 
             selectInput(inputId = "sex", 
                         label = "Animal sex",
                         choices = c("male", "female", "other", "unknown"), 
                         selected = "unknown",
                         multiple = TRUE,
                         width = "70%"), 
             selectInput(inputId = "ageclass", 
                         label = "Animal age class",
                         choices = c("juvenile", "adult"), 
                         selected = "adult",
                         multiple = TRUE,
                         width = "70%"), 
             ##DEVICE CHARACTERISTICS SECTION##
             h2("Device characteristics"), 
             textInput(inputId = "type", 
                       label = "Type of instrument", 
                       width = "100%"), 
             p("A general description of the type of instrument being deployed."), 
             numericInput(inputId = "tagweight", 
                          label = "Instrument weight", 
                          value = 10, min = 1, max = 10000, step = 1, 
                          width = "70%"), 
             selectInput(inputId = "tagweightunits", 
                         label = "Instrument weight units",
                         choices = c("milligrams", "grams", "kilograms"), 
                         selected = "grams",
                         multiple = FALSE,
                         width = "70%"), 
             numericInput(inputId = "addtlweight", 
                          label = "Additional hardware weight", 
                          value = 10, min = 1, max = 10000, step = 1, 
                          width = "70%"), 
             p("Weight of any additional hardware, such as a harness, collar, or housing."), 
             selectInput(inputId = "addtlweightunits", 
                         label = "Additional hardware weight units",
                         choices = c("milligrams", "grams", "kilograms"), 
                         selected = "grams",
                         multiple = FALSE,
                         width = "70%"),
             numericInput(inputId = "percentrule", 
                          label = "Percentage of animal bodyweight", 
                          value = 10, min = 1, max = 10000, step = 1, 
                          width = "70%"), 
             p("Calculate this by dividing the instrument mass by the average animal mass."),
             h3("Device dimensions"), 
             p("These dimensions should not include the antenna, if present."), 
             numericInput(inputId = "taglength", 
                          label = "Instrument length", 
                          value = 10, min = 1, max = 10000, step = 1, 
                          width = "70%"), 
             numericInput(inputId = "tagwidth", 
                          label = "Instrument width", 
                          value = 10, min = 1, max = 10000, step = 1, 
                          width = "70%"), 
             numericInput(inputId = "tagheight", 
                          label = "Instrument height", 
                          value = 10, min = 1, max = 10000, step = 1, 
                          width = "70%"), 
             selectInput(inputId = "tagdimensunits", 
                         label = "Instrument dimension units",
                         choices = c("millimeters", "centimeters", "meters"), 
                         selected = "centimeters",
                         multiple = FALSE,
                         width = "70%"), 
             h3("Antennae dimensions"), 
             checkboxGroupInput(inputId = "antennaeyn", 
                                label = "Flexible or stiff antennae", 
                                choices = c("No antennae", "Flexible", "Stiff"), 
                                selected = "No antennae", 
                                width = "70%"),
             numericInput(inputId = "antlength", 
                          label = "Antenna length", 
                          value = 10, min = 1, max = 10000, step = 1, 
                          width = "70%"), 
             selectInput(inputId = "antlengthunits", 
                         label = "Antennae length units",
                         choices = c("millimeters", "centimeters"), 
                         selected = "centimeters",
                         multiple = FALSE,
                         width = "70%"), 
             numericInput(inputId = "antdiameter", 
                          label = "Antenna diameter", 
                          value = 10, min = 1, max = 10000, step = 1, 
                          width = "70%"), 
             selectInput(inputId = "antdiameterunits", 
                         label = "Antennae diameter units",
                         choices = c("millimeters", "centimeters"), 
                         selected = "centimeters",
                         multiple = FALSE,
                         width = "70%"), 
             h3("Device description"), 
             textInput(inputId = "shape", 
                       label = "Cross sectional shape", 
                       width = "100%"), 
             p("An estimate of the cross sectional shape of the instrument. These may be rounded, square, cylindrical, etc. Include whether the instrument is streamlined or complex."), 
             textInput(inputId = "material", 
                       label = "Material for instrument housing", 
                       width = "100%"),
             textInput(inputId = "manufacturer", 
                       label = "Instrument manufacturer", 
                       width = "100%"),
             textInput(inputId = "model", 
                       label = "Instrument name or model number", 
                       width = "100%"), 
             textInput(inputId = "crosssection", 
                       label = "Cross-sectional shape", 
                       width = "100%"), 
             p("An estimate of the cross sectional shape of the instrument. These may be rounded, square, cylindrical, etc. Include whether the instrument is streamlined or complex."),
             selectInput(inputId = "buoyancy", 
                         label = "Buoyancy", 
                         choices = c("Positive", "Negative", "Neutral", "Not applicable"),
                         multiple = FALSE,
                         width = "100%"), 
             selectInput(inputId = "buoyancytype", 
                         label = "Buoyancy test type", 
                         choices = c("Saltwater", "Freshwater", "Not applicable"),
                         multiple = FALSE,
                         width = "100%"), 
             checkboxGroupInput(inputId = "signals",
                                label = "Signal Production",
                                choices = c("Light", "Sound", "Magnetism", "Other"),
                                selected = "Light"),
             checkboxGroupInput(inputId = "sensors",
                                label = "Sensors",
                                choices = c("Location", "Intrinsic", "Environmental"),
                                selected = "Location"), 
             selectInput(inputId = "orientation", 
                         label = "Orientation", 
                         choices = c("Antennae forwards", "Antennae backwards", "Not applicable"),
                         multiple = FALSE,
                         width = "100%"),
             ##DEPLOYMENT CHARACTERISTICS SECTION##
             h2("Deployment characteristics"), 
             textInput(inputId = "location", 
                       label = "Location on body", 
                       width = "100%"), 
             checkboxGroupInput(inputId = "archivetransmit", 
                                label = "Archival or transmitting", 
                                choices = c("Archival", "Transmitting"),
                                selected = "Transmitting",
                                width = "100%"), 
             textInput(inputId = "photos", 
                       label = "Link to photographs", 
                       width = "100%"), 
             numericInput(inputId = "deployed", 
                          label = "Instrument deployments", 
                          value = 10, min = 1, max = 10000, step = 1, 
                          width = "70%"), 
             p("Number of deployments in this study."),
             numericInput(inputId = "recovered", 
                          label = "Instrument recovery", 
                          value = 10, min = 1, max = 10000, step = 1, 
                          width = "70%"), 
             p("Number of recoveries in this study."), 
             textInput(inputId = "attachment", 
                       label = "Attachment method", 
                       width = "100%"),
             textInput(inputId = "detachment", 
                       label = "Detachment method", 
                       width = "100%"),
             textInput(inputId = "handling", 
                       label = "Handling process", 
                       width = "100%"),
             textInput(inputId = "duration", 
                       label = "Average deployment duration", 
                       width = "100%"), 
             ##DATA CHARACTERISTICS SECTION##
             h2("Data characteristics"),
             checkboxGroupInput(inputId = "dataformat", 
                                label = "Instrument data format", 
                                choices = c(".wch", "Other"),
                                selected = ".wch",
                                width = "100%"), 
             textInput(inputId = "datalocation", 
                       label = "Instrument data location", 
                       width = "100%"), 
             textInput(inputId = "metadatalocation", 
                       label = "Additional metadata location", 
                       width = "100%"),
             textInput(inputId = "notes", 
                       label = "Additional notes", 
                       width = "100%"), 
             ##DOWNLOAD##
             br(),
             downloadButton('report', 'Download Checklist', 
                            class = "btn-primary btn-lg"),
             br(),
             helpText("The \"Download Checklist\" button will generate a report with all your entered information.")
           ))
)

#define server
overview_server <- function(input, output) {
  
  # Download handler for the checklist report
  output$report <- downloadHandler(
    filename = function() {
      paste("biologging_checklist_", Sys.Date(), ".json", sep = "")
    },
    content = function(file) {
      
      # Create the report as a structured list
      report_data <- list(
        metadata = list(
          report_type = "Biologging Instrument Checklist",
          generated_date = as.character(Sys.Date()),
          generated_time = as.character(Sys.time())
        ),
        animal_characteristics = list(
          species_information = list(
            scientific_name = input$sciname %||% "",
            common_name = input$commonname %||% ""
          ),
          deployments = list(
            number_of_animals = input$noanimals,
            devices_per_animal = input$nodevices
          ),
          handling = list(
            handling_time = input$handletime,
            handling_time_units = input$handleunits
          ),
          measurements = list(
            weight = input$anweight,
            weight_units = input$anweightunits,
            sex = input$sex,
            age_class = input$ageclass
          )
        ),
        device_characteristics = list(
          basic_info = list(
            instrument_type = input$type %||% "",
            manufacturer = input$manufacturer %||% "",
            model = input$model %||% ""
          ),
          weight = list(
            instrument_weight = input$tagweight,
            instrument_weight_units = input$tagweightunits,
            additional_hardware_weight = input$addtlweight,
            additional_hardware_weight_units = input$addtlweightunits,
            percentage_of_bodyweight = input$percentrule
          ),
          dimensions = list(
            length = input$taglength,
            width = input$tagwidth,
            height = input$tagheight,
            dimension_units = input$tagdimensunits
          ),
          antennae = list(
            type = input$antennaeyn,
            length = input$antlength,
            length_units = input$antlengthunits,
            diameter = input$antdiameter,
            diameter_units = input$antdiameterunits
          ),
          description = list(
            cross_sectional_shape = input$shape %||% "",
            material = input$material %||% "",
            buoyancy = input$buoyancy,
            buoyancy_test_type = input$buoyancytype,
            signal_production = input$signals,
            sensors = input$sensors,
            orientation = input$orientation
          )
        ),
        deployment_characteristics = list(
          location_on_body = input$location %||% "",
          archive_or_transmit = input$archivetransmit,
          photos_link = input$photos %||% "",
          deployments_count = input$deployed,
          recoveries_count = input$recovered,
          attachment_method = input$attachment %||% "",
          detachment_method = input$detachment %||% "",
          handling_process = input$handling %||% "",
          average_deployment_duration = input$duration %||% ""
        ),
        data_characteristics = list(
          data_format = input$dataformat,
          data_location = input$datalocation %||% "",
          metadata_location = input$metadatalocation %||% "",
          additional_notes = input$notes %||% ""
        )
      )
      
      # Convert to JSON and write to file
      json_output <- jsonlite::toJSON(report_data, pretty = TRUE, auto_unbox = TRUE)
      writeLines(json_output, file)
    }
  )
}

# Helper function for null coalescing
`%||%` <- function(x, y) if (is.null(x) || length(x) == 0 || x == "") y else x

shinyApp(ui = overview_ui, server = overview_server)