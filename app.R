source('global_new_v2_1.R')
source('./R/additionalinfo.R')
source('./R/background.R')
source('./panels.R')
source('./R/report.R')
# source('gen_report.R')

### Maybe needed?
# install.packages('rmarkdown')
# install.packages('tinytex')
# tinytex::install_tinytex()  # install TinyTeX
###
ui <- fluidPage(
    tags$head(
        # Note the wrapping of the string in HTML()
        tags$style(HTML("
        input[type=number] {
              -moz-appearance:textfield;
        }
        input[type=number]::{
              -moz-appearance:textfield;
        }
        input[type=number]::-webkit-outer-spin-button,
        input[type=number]::-webkit-inner-spin-button {
              -webkit-appearance: none;
              margin: 0;
        }
        .border-my-text {
            border: 2px solid black;
            border-padding: 2px;
            background-color: #b4bfd1;
            text-align: center;
        }
        .border-my-class {
            border: 2px solid black;
            border-padding: 2px;
            background-color: black;
            color: white;
            text-align: center;
        }
        #reg_button {
            background-color:#94d9f2;
            padding: 7px;
            font-size: 110%;
            font-weight: bold;
            border-style: outset;
            
            box-shadow: 0 8px 12px 0 rgba(0,0,0,0.24), 0 1px 1px 0 rgba(0,0,0,0.19);
            transition-duration: 0.1s;
        }
        #reg_button:hover {
            background-color:#5d8b9c;
            color: black;
            border-style: solid;
            border-color: black;
            border-width: px;
        }
        #runmodel {
            background-color:#94d9f2;
            padding: 7px;
            font-size: 110%;
            font-weight: bold;
            border-style: outset;
            
            box-shadow: 0 8px 12px 0 rgba(0,0,0,0.24), 0 1px 1px 0 rgba(0,0,0,0.19);
            transition-duration: 0.1s;
        }
        #runmodel:hover {
            background-color:#5d8b9c;
            color: black;
            border-style: solid;
            border-color: black;
            border-width: px;
        }
        #report {
            background-color:#94d9f2;
            padding: 7px;
            font-size: 110%;
            font-weight: bold;
            border-style: outset;
            
            box-shadow: 0 8px 12px 0 rgba(0,0,0,0.24), 0 1px 1px 0 rgba(0,0,0,0.19);
            transition-duration: 0.1s;
        }
        #report:hover {
            background-color:#5d8b9c;
            color: black;
            border-style: solid;
            border-color: black;
            border-width: px;
        }
        .leaflet-popup-content {
            text-align: center;
        }


    "))
    ),

    titlePanel(
        div(
            class="jumbotron",
            h2(HTML(
                "Web application for the Beta Streamflow Duration Assessment Methods for the Northeast and Southeast 
        ")
            ),
            h4(HTML("<p>Version <a href=\"https://github.com/WSaulnier/NESE_Beta_SDAM/tree/beta_nese\">1.0.1</a> Release date: March 2023 </p>")),
            img(src="eph.jpg", style = "height: 400px"),
            img(src="int.jpg", style = "height: 400px"),
            img(src="per.jpg", style = "height: 400px")
        ),
        "SDAM Great Plains"
    ),
    fluidRow(
        column(
            12,
            tabsetPanel(
                id = "tabs",
                tabPanel(
                    "Background Info",
                    bkgrnd
                ),
                # Overview -----------------------------------------------------
                tabPanel(
                    "Enter Data", 
                    br(),
                    fluidRow(column(12, h3("Step 1: Enter reach coordinates or select reach location on map."), 
                                    )),
                    # coordinates----
                    fluidRow(
                      column(12,
                             selectInput(
                               "vol_region",
                               label = HTML("<b><i>Method for Assessing Reach Location</b></i>"),
                               choices = c(
                                 "Enter Coordinates",
                                 # "Select Eastern Region",
                                 "Select Location on Map"
                               ),
                               selected = "No",
                               width = '20%'
                             )
                      )
                    ),
                    fluidRow(
                        column(7,
                               HTML('<hr style="color: black; height: 1px; background-color: black;">')
                               )
                    ),
                    
                    conditionalPanel(
                        
                      condition = "input.vol_region == 'Enter Coordinates'",
                      fluidRow(
                          column(
                              4,
                              div(HTML('<b><i>Enter coordinates in decimal degrees to determine if the site is in the study area and if the site is in the Northeast or Southeast. </i></b>')),
                              div(id = "placeholder"),
                              div(id = "coords",
                                fluidRow(
                                  # div(id = "placeholder",
                                    column(4,
                                           numericInput("lat", label = NULL, value = 37)),
                                    column(1, h5("Latitude"))
                                ),
                                fluidRow(
                                    column(4,numericInput("lon", label = NULL, value = -78)),
                                    column(1, h5("Longitude"))
                                ),
                                fluidRow(
                                    column(4,
                                           br(),
                                           div(actionButton("reg_button", 
                                                            label=div("Assess Reach Location", icon('long-arrow-right'))
                                                            ) 
                                               ))
                                )
                              )
                          ),
                          column(
                              4,
                              conditionalPanel(
                                  condition = "input.reg_button != 0",
                                  
                                  uiOutput(outputId = "reg_class") %>%
                                      tagAppendAttributes(class = 'border-my-text')
                              )
                          )
                      )
                    ),
                    
                    # removed from NESE code due to the need to have valid lat/long for precip data
                    # conditionalPanel(
                    #   condition = "input.vol_region == 'Select Eastern Region'",
                    #   fluidRow(
                    #     column(12,
                    #            selectInput(
                    #              "user_region",
                    #              HTML("<b><i>Select Eastern Region if not entering coordinates:</b></i>"),
                    #              c(
                    #                "No Region Selected" = "No Region",
                    #                "Northeast" = "Northeast",
                    #                "Southeast" = "Southeast"
                    #              )
                    #            )
                    #     )
                    #   )
                    # ),
                    
                    ## leaflet map----
                    conditionalPanel(
                        condition = "input.vol_region == 'Select Location on Map'",
                        fluidRow(
                            column(6,
                                leafletOutput("map", height ='500px')
                            )
                        )
                    ),
                    ## break
                    fluidRow(
                        column(
                            12,
                            HTML('<hr style="color: black; height: 7px; background-color: black;">')
                        )
                    ),
                    
                    # NESE UI Split-------------

                    uiOutput("regionPanel"),
                    uiOutput("reportPanel"),
                      
                    # Report Inputs----   
                    
                    
                ),
                tabPanel(
                    "Additional Resources",
                    addinfo
                )
                
            )
        )
    )

)




# server-----------------------------------------------------------------------
server <- function(input, output, session) {
    
    # region -----

  
    region_class <- eventReactive(c(input$reg_button, input$map_click,input$vol_region),{
        if(!is.null(map_coords()) && input$vol_region == 'Select Location on Map'){
            x <- point_region(map_coords()[1], map_coords()[2])
        } else {
            x <- point_region(user_lat = input$lat, user_lon = input$lon)
        }
        x
    })
    
    output$regionSelection <- renderText({
      region_class()$region
    })

    # Render UI Panels ------
    ### region panel-----
    output$regionPanel <- renderUI({
      if (is.atomic(region_class())){
        # print(region_class())
        if (region_class() == 'Northeast'){
          ne_panel()
        } else  if (region_class() == 'Southeast' ){
          se_panel()
        }
      } else if (!is.atomic(region_class())){
        print(region_class()$region)
        if (region_class()$region == 'Northeast'){
          ne_panel()
        } else if (region_class()$region == 'Southeast' ){
          se_panel()
        }
      } else return(NULL)
    })
    
    ###report panel--------
    output$reportPanel <- renderUI({
      if(region_class()$region == 'Northeast' & input$runmodel != 0){
        ne_report
      } else if (region_class()$region == 'Southeast' & input$runmodel != 0){
        se_report
      }
    })
    
    observe({
        print(is.atomic(region_class()))
        if (is.atomic(region_class())){
            # print(region_class())
        } else {
        print(region_class()$region)
        }
    })
    
  # if site is out of GP regions, offer a URL to alternate SDAM.  If site out of SDAM
  # study areas, return warning message from global function
  observeEvent(c(input$reg_button, region_class()),{
      
      if (is.atomic(region_class())){
          output$reg_class <- renderUI ({
              h2(HTML(paste0("<b>Eastern Region: <br>", region_class(), "</b>")))
          })
      } else if (!is.atomic(region_class())){
   
        if (is.na(region_class()$region)){
          
          show_alert(
            title = "Location Error!",
            text = tagList(
              tags$p(HTML(paste0("The location of your site is outside of the SDAM study areas.",
                                 " Please check your latitude and longitude coordinates to ensure they are entered correctly.<br>")
              )
              )
            ),
            type = "error"
          )
          
        } else {
          
            if (region_class()$region != 'Northeast' && region_class()$region != 'Southeast' && !is.na(region_class()$region)){

                if (region_class()$URL != 'development' && region_class()$URL != 'planning'){
                    show_alert(
                        title = "Location Error!",
                        text = tagList(
                            tags$p(HTML(paste0("This site is outside of the Eastern SDAM study area  The site is located in the ",
                                               '<a href=\"', region_class()$URL, '">',
                                               region_class()$region), ' SDAM.</a>')
                            )
                        ),
                        type = "error"
                    )
                } else {
                    show_alert(
                        title = "Location Error!",
                        text = tagList(
                            tags$p(HTML(paste0("This site is located outside of the Great Plains SDAM study area.  The site is located in the <b>",
                                               region_class()$region, "</b> SDAM region.  The ",
                                               region_class()$region, " is in the <b>",
                                               region_class()$URL, "</b> stage. If you would like to proceed with running the Great Plains
                                     model, you may exit this dialogue and select a Great Plains region."))
                            )
                        ),
                        type = "error"
                    )
                }
  
            } else {
                output$reg_class <- renderUI ({
                    if(!is.na(region_class()$region)){
                        if(region_class()$region == 'Northeast' || region_class()$region == 'Southeast'){
                            h2(HTML(paste0("<b>Eastern Region: <br>", region_class()$region, "</b>")))
                        } else {
                            h2(HTML(paste0("<b>SDAM Region: <br>", region_class()$region, "</b>")))
                        }
                    }
                })
            }
        }
      }
  })

    # leaflet map render-----
    output$map <- renderLeaflet({
        factPal <- colorFactor(pal = rainbow(9), levels = regions_leaflet$SDAM)
        leaflet(regions_leaflet) %>%
            addPolygons(stroke = FALSE,
                        fillOpacity = 0.3,
                        smoothFactor = 2,
                        color = ~factPal(regions_leaflet$SDAM),
                        group = "SDAM Regions") %>%
            setView(lng = -78.5,
                    lat = 37.5,
                    zoom = 5) %>%
            addLegend("bottomright",
                      title = HTML("<b><u>SDAM Regions</u></b>"),
                      pal = factPal,
                      values = regions_leaflet$SDAM,
                      group = "SDAM Regions") %>%

            addProviderTiles(providers$Esri.NatGeoWorldMap,
                             group = 'NatGeo World (Default)') %>%
            addProviderTiles(providers$Esri.WorldImagery,
                             group = 'Imagery') %>%
            addLayersControl(
                baseGroups=c("NatGeo World (Default)", "Imagery"),
                overlayGroups = "SDAM Regions",
                options = layersControlOptions(collapsed = FALSE)) %>%
            leafem::addMouseCoordinates() %>%
            addFullscreenControl()
    })
  
    # coordinates 
    map_coords <- reactive({
        click = input$map_click
        if(is.null(click))
            return()
        coords = c(round(click$lat,4), round(click$lng,4))
        updateNumericInput(
            session,
            "lat",
            value = coords[1]
        )
        updateNumericInput(
            session,
            "lon",
            value = coords[2]
        )
        coords
    })
    
    # lat/long----
    latitude <- eventReactive(c(input$map_click,input$lat, input$lon),{
        if(is.null(map_coords())){
            latitude <- input$lat
        } else if (!is.null(map_coords())){
            latitude <- map_coords()[1]
        }
        latitude
    })
    longitude <- eventReactive(c(input$map_click,input$lat, input$lon),{
        if(is.null(map_coords())){
            longitude <- input$lon
        } else if (!is.null(map_coords())){
            longitude <- map_coords()[2]
        }
        longitude
    })
    observe({
        print(latitude())
        print(longitude())
    })

    # map click----
    observe({
        click = input$map_click
        if(is.null(click))
            return()
        region <- if(!is.na(region_class()$region)){
    
          if(region_class()$region == 'Southern' || region_class()$region == 'Northern'){
              paste0(region_class()$region, ' Great Plains')
          } else {
              paste0(region_class()$region, ' SDAM Region')
          }
          
        }

        text<-HTML(paste("<b><u>", region, "</u></b><br>",
            "Latitude: ", round(click$lat, 4), ", Longtitude: ", round(click$lng, 4)))
        text2<-paste("You've selected point ", text)
        map_proxy = leafletProxy("map") %>%
            clearPopups() %>%
            addPopups(round(click$lng, 4), round(click$lat, 4), text)

        print(paste0(click$lat, ', ', click$lng))
    })




    # percent shade calculation -----
    # dynamic UI output for length 1:12 for densiometer recordings
    output$densiUI <- renderUI({
        lapply(
            X = 1:input$select,
            FUN = function(i) {
                sliderInput(inputId = paste0("densi", i), label = i, min = 0, max = 17, value = i)
            }
        )
    })
    
    # dynamic UI list of inputs for densiometer recordings
    densi_list <- eventReactive(input$select, {
        lapply(
            X = 1:input$select,
            FUN = function(i) {
                input = paste0('densi', i)
            }
        )
    })
    
    # Densiometer input names for use in report possibly
    densi_inputs <- reactive({
        list_names <- c()
        for(x in 1:length(densi_list())){
            list_names[[x]] <- paste(densi_list()[x])
        }
        return(list_names)
    })
    
    # Densiometer input values
    densi_values <- reactive({
        list_values <- c()
        for(x in 1:length(densi_list())){
            list_values[[x]] <- input[[paste(densi_list()[[x]])]]
        }
        return(list_values)
    })
    
    # calculated shade percentage
    densi_shade_perc <- eventReactive(densi_values(),{
        round((Reduce("+", densi_values()) / (input$select* 17))*100,2)
    })
    densi_shade_dec <- eventReactive(densi_values(),{
        round((Reduce("+", densi_values()) / (input$select* 17)),2)
    })
    
    # Show user calculated percent value
    output$text <- renderUI ({
        
        h3(HTML(paste0("<b>Percent Shade: ", densi_shade_perc(), "%")))
        
    })
    
    # Bankfull width calculation----
    
    # dynamic UI output for length 1:3 for bankfull width recordings
    output$bankUI <- renderUI({
        lapply(
            X = 1:input$select_bank,
            FUN = function(i) {
                numericInput(inputId = paste0("bank", i),
                             label = paste0("Bankfull Measurement ", i), 
                             value = 0)
            }
        )
    })
    
    # dynamic UI list of inputs for bankfull width recordings
    bank_list <- eventReactive(input$select_bank, {
        lapply(
            X = 1:input$select_bank,
            FUN = function(i) {
                input = paste0('bank', i)
            }
        )
    })
    
    # Densiometer input names to be possibly used in report
    bank_inputs <- reactive({
        list_names <- c()
        for(x in 1:length(bank_list())){
            list_names[[x]] <- paste(bank_list()[x])
        }
        return(list_names)
    })
    
    # Densiometer input values
    bank_values <- reactive({
        list_values <- c()
        for(x in 1:length(bank_list())){
            list_values[[x]] <- input[[paste(bank_list()[[x]])]]
        }
        return(list_values)
    })
    
    # calculated shade percentage
    bank_mean <- eventReactive(bank_values(),{
        round((Reduce("+", bank_values()) / (input$select_bank)),2)
    })
    
    # Show user calculated percent value
    output$bank_text <- renderUI ({
        h3(HTML(paste0("<b>Bankful Width (m): ", bank_mean(), "</b>")))
        
    })
    
    # used to check all of the inputs
    # AllInputs <- reactive({
    #   x <- reactiveValuesToList(input)
    #   # data.frame(
    #   #   names = names(x),
    #   #   values = unlist(x, use.names = FALSE)
    #   # )
    # })
    # 
    # observeEvent(AllInputs(), {
    #   print(AllInputs())
    # })
    # 
    
    # retrive precip prism value for report
    precip <- eventReactive(c(input$lat, input$lon, region_class()),{
      prism_output(latitude(), longitude(), region_class()$region)
    })
    
    # print to console region appropriate mean precip (mm)
    # observe({
    #   print(is.atomic(precip()))
    #   if (is.atomic(precip())){
    #     print(precip())
    #   } 
    # })
    
    # run rf model and output stream classification----
    classification <- eventReactive(input$runmodel, {
      
             run_model(
              user_lat = as.numeric(latitude()),
              user_lon = as.numeric(longitude()),
              user_UplandRootedPlants_score = as.numeric(input$user_UplandRootedPlants),
              user_Slope = input$user_Slope,
              user_SubstrateSorting_score = input$user_Substrate,
              user_NaturalValley_score = input$user_NaturalValley_score,
              user_PctShade = as.numeric(densi_shade_dec()),
              user_BankWidthMean = as.numeric(bank_mean()),
              user_TotalAbundance = input$user_TotalAbundance,
              user_richness = input$user_richness,
              user_DRNAREA = input$user_DRNAREA)
    })


    
    
    output$class_out <- renderUI ({
        h2(HTML(paste0("<b>", classification(), "</b>")))
    })

    # Conditions in STEP 3
    observeEvent(input$surfflow, {
        print(input$surfflow)
        if (!is.na(input$surfflow)){
            if ((input$surfflow  < 0) | (input$surfflow  > 100) ){
                showModal(
                    modalDialog(
                        "Percent of reach with surface flow must be between 0 and 100 (inclusive)",
                        footer= modalButton("OK"),
                        easyClose = FALSE
                    )
                )
                updateNumericInput(
                    session,
                    "surfflow",
                    value = 0
                )
            }
        }
    })
    
    observeEvent(input$subflow, {
        if (!is.na(input$subflow)){
            if (input$subflow < 0 | input$subflow > 100){
                showModal(
                    modalDialog(
                        "Percent of reach with surface and subsurface flow must be between 0 and 100 (inclusive)",
                        footer= modalButton("OK"),
                        easyclose = FALSE
                    )
                )
                updateNumericInput(
                    session,
                    "subflow",
                    value = 0
                )
            }
        }
    })
    
    observeEvent(input$subflow, {
        if(!is.na(input$subflow)){
            if (input$subflow < input$surfflow ){
                showModal(
                    modalDialog(
                        "Percent of reach with surface and subsurface flow must be greater than or equal to % of reach with surface flow",
                        footer= modalButton("OK"),
                        easyclose = FALSE
                    )
                )
                updateNumericInput(
                    session,
                    "subflow",
                    value = 0
                )
            }
        }
    })
    
    observeEvent(input$pool, {
        if (!is.na(input$surfflow)){
            if (input$surfflow == 100){
                if ((input$pool != 0) | (!is.null(input$pool))  ) {
                    showModal(
                        modalDialog(
                            "Number of isolated pools must be zero or blank if % of reach with surface flow is 100",
                            footer= modalButton("OK"),
                            easyclose = FALSE
                        )
                    )
                    updateNumericInput(
                        session,
                        "pool",
                        value = 0
                    )
                }
            }
        }
    })
    
  
    # Report Tab--------------------------------------------------------------
    # 
    # eventReactive(input$report,{
    #   if (region_class()$region == 'Northeast'){
    #     print('Northeast Report') 
    #   } else if (region_class()$region == 'Southeast'){
    #     print('Southeast Report')
    #   }
    # })


      # Site photos----
      fig1 <- reactive({gsub("\\\\", "/", input$blu$datapath)})
      fig2 <- reactive({gsub("\\\\", "/", input$mld$datapath)})
      fig3 <- reactive({gsub("\\\\", "/", input$mlu$datapath)})
      fig4 <- reactive({gsub("\\\\", "/", input$tld$datapath)})
      fig5 <- reactive({gsub("\\\\", "/", input$sketch$datapath)})

      #Invertebrate photos
      fig6 <- reactive({gsub("\\\\", "/", input$inv1$datapath)})
      fig7 <- reactive({gsub("\\\\", "/", input$inv2$datapath)})
      fig8 <- reactive({gsub("\\\\", "/", input$inv3$datapath)})
      # retroactively added photos; naming convention broken
      fig6_1 <- reactive({gsub("\\\\", "/", input$inv4$datapath)})
      fig7_1 <- reactive({gsub("\\\\", "/", input$inv5$datapath)})
      fig8_1 <- reactive({gsub("\\\\", "/", input$inv6$datapath)})

      # richness photos
      fig9 <- reactive({gsub("\\\\", "/", input$rich1$datapath)})
      fig10 <- reactive({gsub("\\\\", "/", input$rich2$datapath)})
      fig11 <- reactive({gsub("\\\\", "/", input$rich3$datapath)})
      # retroactively added photos; naming convention broken
      fig9_1 <- reactive({gsub("\\\\", "/", input$rich4$datapath)})
      fig10_1 <- reactive({gsub("\\\\", "/", input$rich5$datapath)})
      fig11_1 <- reactive({gsub("\\\\", "/", input$rich6$datapath)})

      # Substrate photos
      fig12 <- reactive({gsub("\\\\", "/", input$sub1$datapath)})
      fig13 <- reactive({gsub("\\\\", "/", input$sub2$datapath)})
      fig14 <- reactive({gsub("\\\\", "/", input$sub3$datapath)})

      # Differences in vegetation photos
      fig15 <- reactive({gsub("\\\\", "/", input$veg1$datapath)})
      fig16 <- reactive({gsub("\\\\", "/", input$veg2$datapath)})
      fig17 <- reactive({gsub("\\\\", "/", input$veg3$datapath)})

      # Natural Valley
      fig18 <- reactive({gsub("\\\\", "/", input$nv1$datapath)})
      fig19 <- reactive({gsub("\\\\", "/", input$nv2$datapath)})
      fig20 <- reactive({gsub("\\\\", "/", input$nv3$datapath)})

      # Slope
      fig21 <- reactive({gsub("\\\\", "/", input$slope1$datapath)})
      fig22 <- reactive({gsub("\\\\", "/", input$slope2$datapath)})
      fig23 <- reactive({gsub("\\\\", "/", input$slope3$datapath)})

      # Supplemental Info photos
      fig24 <- reactive({gsub("\\\\", "/", input$add1$datapath)})
      fig25 <- reactive({gsub("\\\\", "/", input$add2$datapath)})
      fig26 <- reactive({gsub("\\\\", "/", input$add3$datapath)})
      fig27 <- reactive({gsub("\\\\", "/", input$add4$datapath)})


      output$report <- downloadHandler(
                filename = glue::glue("Eastern SDAM Report ({format(Sys.time(), '%B %d, %Y')}).pdf"),
                content = function(file) {
                  if (region_class()$region == 'Northeast'){
                    ### NE Report----
                    tryCatch({
        
                      showModal(modalDialog("Please wait while the report is being generated.....", footer=NULL))
                      tempReport <- file.path("markdown/ne_report.Rmd")
                      file.copy("ne_report.Rmd", tempReport, overwrite = TRUE)
        
                      # Set up parameters to pass to Rmd document
                      params <- list(
                        # -------------------Classification
                        stream_class = classification(),
                        region = region_class()$region,
                        precip = precip(),
                        drain_area = input$user_DRNAREA,
        
        
                        # -------------------General Site Information
                        a = input$project,
                        b = input$assessor,
                        c = input$code,
                        d = input$waterway,
                        e = input$date,
                        bm = case_when(input$radio_weather == 'heavyrain' ~ "Storm/heavy rain",
                                       input$radio_weather == 'steadyrain' ~ "Steady rain",
                                       input$radio_weather == 'intermittentrain' ~ "Intermittent rain",
                                       input$radio_weather == 'snowing' ~ "Snowing",
                                       input$radio_weather == 'cloudy' ~ "Cloudy",
                                       input$radio_weather == 'clearsunny' ~ "Clear/Sunny"),
        
        
                        j = input$weather,
                        g = as.numeric(input$lat),
                        h = as.numeric(input$lon),
                        l = plyr::mapvalues(
                          input$check_use,
                          from = c(
                            "urban","agricultural", "Developed open-space (e.g., golf course, parks, lawn grasses)",
                            "forested","othernatural","other"),
                          to = c(
                            "Urban, industrial, or residential", "Agricultural","Developed open-space",
                            "Forested","Other Natural","Other")
                        ) %>% as.character() %>% paste0(collapse = ", "),
                        f = input$boundary,
                        fff = input$actreach,
                        bn = plyr::mapvalues(
                          input$radio_situation,
                          from = c(
                            "flood","stream_modifications", "diversions",
                            "Water discharges","drought","vegetation",
                            "other","none"),
                          to = c(
                            "Recent flood or debris flow","Stream modifications (e.g., channelization)","Diversions",
                            "Water discharges","Drought","Vegetation removal/limitations",
                            "Other (explain in notes)","None")
                        ) %>% as.character() %>% paste0(collapse = ", "),
                        k = input$situation,
        
                        # ------------------- Site Photos
                        v = fig4(),
                        u = fig3(),
                        t = fig2(),
                        s = fig1(),
        
                        # ------------------- Observed Hydrology
                        m = input$surfflow,
                        n = input$subflow,
                        o = input$pool,
                        r = input$notes_observed_hydrology,
        
                        # ------------------- Site Sketch
                        w = fig5(),
        
        
                        # ------------------- Biological indicators
                        # EPT Taxa----
                        aqua_inv = input$user_TotalAbundance,
                        f6 = fig6(),
                        f6_cap = input$inv1_cap,
                        f7 = fig7(),
                        f7_cap = input$inv2_cap,
                        f8 = fig8(),
                        f8_cap = input$inv3_cap,
                        f6_1 = fig6_1(),
                        f6_1cap = input$inv4_cap,
                        f7_1 = fig7_1(),
                        f7_1cap = input$inv5_cap,
                        f8_1 = fig8_1(),
                        f8_cap = input$inv6_cap,
                        notes_aquainv = input$notes_totalAbundance,
        
        
                        # Richness----
                        richness = input$user_richness,
                        notes_richness= input$notes_richness,
                        f9 = fig9(),
                        f9_cap = input$rich1_cap,
                        f10 = fig10(),
                        f10_cap = input$rich2_cap,
                        f11 = fig11(),
                        f11_cap = input$rich3_cap,
                        f9_1 = fig9_1(),
                        f9_1cap = input$rich4_cap,
                        f10_1 = fig10_1(),
                        f10_1cap = input$rich5_cap,
                        f11_1 = fig11_1(),
                        f11_1cap = input$rich6_cap,
        
        
        
                        # Substrate----
                        # substrate = case_when(input$user_Substrate == '0' ~ "0 (Poor)",
                        #                       input$user_Substrate == '0.5' ~ "0.5",
                        #                       input$user_Substrate == '1' ~ "1 (Weak)",
                        #                       input$user_Substrate == '1.5' ~ "1.5",
                        #                       input$user_Substrate == '2' ~ "2 (Moderate)",
                        #                       input$user_Substrate == '2.5' ~ "2.5",
                        #                       input$user_Substrate == '3' ~ "3 (Strong)"
                        # ),
                        # # fish_abundance_checkbox = input$fish_abundance_checkbox,
                        # notes_substrate = input$notes_substrate,
                        # f12 = fig12(),
                        # f12_cap = input$sub1_cap,
                        # f13 = fig13(),
                        # f13_cap = input$sub2_cap,
                        # f14 = fig14(),
                        # f14_cap = input$sub3_cap,
                        #
                        #
                        # Upland Rooted----
                        upland_rooted = case_when(input$user_UplandRootedPlants == '0' ~ "0 (Poor)",
                                                  input$user_UplandRootedPlants == '1' ~ "1 (Weak)",
                                                  input$user_UplandRootedPlants == '2' ~ "2 (Moderate)",
                                                  input$user_UplandRootedPlants == '3' ~ "3 (Strong)"
                        ),
                        upland_checkbox = input$upland_checkbox,
                        notes_rooted = input$notes_rooted,
                        f15 = fig15(),
                        f15_cap = input$veg1_cap,
                        f16 = fig16(),
                        f16_cap = input$veg2_cap,
                        f17 = fig17(),
                        f17_cap = input$veg3_cap,
        
                        # Bank Width----
                        bankwidth = bank_mean(),
        
                        # Percent Shade----
                        shade = densi_shade_perc(),
        
        
                        # Natural Valley----
                        nv = case_when(input$user_NaturalValley_score == '0' ~ "0 (Poor)",
                                       input$user_NaturalValley_score == '0.25' ~ "0.25",
                                       input$user_NaturalValley_score == '0.5' ~ "0.5 (Weak)",
                                       input$user_NaturalValley_score == '0.75' ~ "0.75",
                                       input$user_NaturalValley_score == '1.0' ~ "1 (Moderate)",
                                       input$user_NaturalValley_score == '1.25' ~ "1.25",
                                       input$user_NaturalValley_score == '1.5' ~ "1.5 (Strong)"
                        ),
                        notes_nv = input$notes_nv,
                        val_length = input$valley_length,
                        f18 = fig18(),
                        f18_cap = input$nv1_cap,
                        f19 = fig19(),
                        f19_cap = input$nv2_cap,
                        f20 = fig20(),
                        f20_cap = input$nv3_cap,
        
                        # Slope----
                        slope = input$user_Slope,
                        notes_slope = input$notes_slope,
                        bank2x = input$bankfull_2x,
                        fpw = input$floodprone,
                        entrenchment = input$entrench,
                        f21 = fig21(),
                        f21_cap = input$slope1_cap,
                        f22 = fig22(),
                        f22_cap = input$slope2_cap,
                        f23 = fig23(),
                        f23_cap = input$slope3_cap,
        
                        # ------------------- Supplemental Information
                        notes_supplemental_information = input$notes_supplemental_information,
                        f24 = fig24(),
                        f24_cap = input$add1_cap,
                        f25 = fig25(),
                        f25_cap = input$add2_cap,
                        f26 = fig26(),
                        f26_cap = input$add3_cap,
                        f27 = fig27(),
                        f27_cap = input$add4_cap
        
        
                      )
        
                      # Knit the document, passing in the `params` list, and eval it in a
                      # child of the global environment (this isolates the code in the document
                      # from the code in this app).
                      rmarkdown::render(
                        tempReport,
                        output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
                      )
                      removeModal()
                    },
                    warning = function(cond){
                      showModal(
                        modalDialog(
                          "There was an error while generating the report.
                      Please contact Will Saulnier (wsaulnier@eprusa.net) for more details.",
                          footer = modalButton("Ok")
                        )
                      )
                      return(NULL)
                    }
                    )
                  } else if (region_class()$region == 'Southeast'){
                    tryCatch({
                      ### SE Report----
                      
                      showModal(modalDialog("Please wait while the report is being generated.....", footer=NULL))
                      tempReport <- file.path("markdown/se_report.Rmd")
                      file.copy("se_report.Rmd", tempReport, overwrite = TRUE)
                      
                      # Set up parameters to pass to Rmd document
                      params <- list(
                        # -------------------Classification
                        stream_class = classification(),
                        region = region_class()$region,
                        precip = precip(),
                        drain_area = input$user_DRNAREA,
                        
                        
                        # -------------------General Site Information
                        a = input$project,
                        b = input$assessor,
                        c = input$code,
                        d = input$waterway,
                        e = input$date,
                        bm = case_when(input$radio_weather == 'heavyrain' ~ "Storm/heavy rain",
                                       input$radio_weather == 'steadyrain' ~ "Steady rain",
                                       input$radio_weather == 'intermittentrain' ~ "Intermittent rain",
                                       input$radio_weather == 'snowing' ~ "Snowing",
                                       input$radio_weather == 'cloudy' ~ "Cloudy",
                                       input$radio_weather == 'clearsunny' ~ "Clear/Sunny"),
                        
                        
                        j = input$weather,
                        g = as.numeric(input$lat),
                        h = as.numeric(input$lon),
                        l = plyr::mapvalues(
                          input$check_use,
                          from = c(
                            "urban","agricultural", "Developed open-space (e.g., golf course, parks, lawn grasses)",
                            "forested","othernatural","other"),
                          to = c(
                            "Urban, industrial, or residential", "Agricultural","Developed open-space",
                            "Forested","Other Natural","Other")
                        ) %>% as.character() %>% paste0(collapse = ", "),
                        f = input$boundary,
                        fff = input$actreach,
                        bn = plyr::mapvalues(
                          input$radio_situation,
                          from = c(
                            "flood","stream_modifications", "diversions",
                            "Water discharges","drought","vegetation",
                            "other","none"),
                          to = c(
                            "Recent flood or debris flow","Stream modifications (e.g., channelization)","Diversions",
                            "Water discharges","Drought","Vegetation removal/limitations",
                            "Other (explain in notes)","None")
                        ) %>% as.character() %>% paste0(collapse = ", "),
                        k = input$situation,
                        
                        # ------------------- Site Photos
                        v = fig4(),
                        u = fig3(),
                        t = fig2(),
                        s = fig1(),
                        
                        # ------------------- Observed Hydrology
                        m = input$surfflow,
                        n = input$subflow,
                        o = input$pool,
                        r = input$notes_observed_hydrology,
                        
                        # ------------------- Site Sketch
                        w = fig5(),
                        
                        
                        # ------------------- Biological indicators
                        # EPT Taxa----
                        aqua_inv = input$user_TotalAbundance,
                        f6 = fig6(),
                        f6_cap = input$inv1_cap,
                        f7 = fig7(),
                        f7_cap = input$inv2_cap,
                        f8 = fig8(),
                        f8_cap = input$inv3_cap,
                        f6_1 = fig6_1(),
                        f6_1cap = input$inv4_cap,
                        f7_1 = fig7_1(),
                        f7_1cap = input$inv5_cap,
                        f8_1 = fig8_1(),
                        f8_cap = input$inv6_cap,
                        notes_aquainv = input$notes_totalAbundance,
                        
                        
                        # Richness----
                        richness = input$user_richness,
                        notes_richness= input$notes_richness,
                        f9 = fig9(),
                        f9_cap = input$rich1_cap,
                        f10 = fig10(),
                        f10_cap = input$rich2_cap,
                        f11 = fig11(),
                        f11_cap = input$rich3_cap,
                        f9_1 = fig9_1(),
                        f9_1cap = input$rich4_cap,
                        f10_1 = fig10_1(),
                        f10_1cap = input$rich5_cap,
                        f11_1 = fig11_1(),
                        f11_1cap = input$rich6_cap,
                        
                        
                        
                        # Substrate----
                        substrate = case_when(input$user_Substrate == '0' ~ "0 (Poor)",
                                              input$user_Substrate == '0.5' ~ "0.5",
                                              input$user_Substrate == '1' ~ "1 (Weak)",
                                              input$user_Substrate == '1.5' ~ "1.5",
                                              input$user_Substrate == '2' ~ "2 (Moderate)",
                                              input$user_Substrate == '2.5' ~ "2.5",
                                              input$user_Substrate == '3' ~ "3 (Strong)"
                        ),
                        # # fish_abundance_checkbox = input$fish_abundance_checkbox,
                        notes_substrate = input$notes_substrate,
                        f12 = fig12(),
                        f12_cap = input$sub1_cap,
                        f13 = fig13(),
                        f13_cap = input$sub2_cap,
                        f14 = fig14(),
                        f14_cap = input$sub3_cap,


                        # Upland Rooted----
                        upland_rooted = case_when(input$user_UplandRootedPlants == '0' ~ "0 (Poor)",
                                                  input$user_UplandRootedPlants == '1' ~ "1 (Weak)",
                                                  input$user_UplandRootedPlants == '2' ~ "2 (Moderate)",
                                                  input$user_UplandRootedPlants == '3' ~ "3 (Strong)"
                        ),
                        upland_checkbox = input$upland_checkbox,
                        notes_rooted = input$notes_rooted,
                        f15 = fig15(),
                        f15_cap = input$veg1_cap,
                        f16 = fig16(),
                        f16_cap = input$veg2_cap,
                        f17 = fig17(),
                        f17_cap = input$veg3_cap,
                        
                        # Bank Width----
                        bankwidth = bank_mean(),
                        
                        # Percent Shade----
                        shade = densi_shade_perc(),
                        
                        
                        # Natural Valley----
                        # nv = case_when(input$user_NaturalValley_score == '0' ~ "0 (Poor)",
                        #                input$user_NaturalValley_score == '0.25' ~ "0.25",
                        #                input$user_NaturalValley_score == '0.5' ~ "0.5 (Weak)",
                        #                input$user_NaturalValley_score == '0.75' ~ "0.75",
                        #                input$user_NaturalValley_score == '1.0' ~ "1 (Moderate)",
                        #                input$user_NaturalValley_score == '1.25' ~ "1.25",
                        #                input$user_NaturalValley_score == '1.5' ~ "1.5 (Strong)"
                        # ),
                        # notes_nv = input$notes_nv,
                        # val_length = input$valley_length,
                        # f18 = fig18(),
                        # f18_cap = input$nv1_cap,
                        # f19 = fig19(),
                        # f19_cap = input$nv2_cap,
                        # f20 = fig20(),
                        # f20_cap = input$nv3_cap,
                        
                        # Slope----
                        # slope = input$user_Slope,
                        # notes_slope = input$notes_slope,
                        # bank2x = input$bankfull_2x,
                        # fpw = input$floodprone,
                        # entrenchment = input$entrench,
                        # f21 = fig21(),
                        # f21_cap = input$slope1_cap,
                        # f22 = fig22(),
                        # f22_cap = input$slope2_cap,
                        # f23 = fig23(),
                        # f23_cap = input$slope3_cap,
                        # 
                        # ------------------- Supplemental Information
                        notes_supplemental_information = input$notes_supplemental_information,
                        f24 = fig24(),
                        f24_cap = input$add1_cap,
                        f25 = fig25(),
                        f25_cap = input$add2_cap,
                        f26 = fig26(),
                        f26_cap = input$add3_cap,
                        f27 = fig27(),
                        f27_cap = input$add4_cap
                        
                        
                      )
                      
                      # Knit the document, passing in the `params` list, and eval it in a
                      # child of the global environment (this isolates the code in the document
                      # from the code in this app).
                      rmarkdown::render(
                        tempReport,
                        output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
                      )
                      removeModal()
                    },
                    warning = function(cond){
                      showModal(
                        modalDialog(
                          "There was an error while generating the report.
                      Please contact Will Saulnier (wsaulnier@eprusa.net) for more details.",
                          footer = modalButton("Ok")
                        )
                      )
                      return(NULL)
                    }
                    )
              
                  }
                }
            )

    
}

shinyApp(ui=ui, server=server)