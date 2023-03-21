
# panels containing model features for northeast and southeast regions

ne_panel <- function(){
  fluidRow(

    column(
      7,
      h2(HTML('<b><u>Northeast SDAM</u></b>')),
      h3(HTML("Step 2: Enter required indicator data")),
      
      ## biological indicators----
      h4(HTML("<b><u>Biological Metrics</u></b>")),
      fluidRow(
        column(
          4,
          numericInput("user_TotalAbundance", label = NULL, value = 0, min = 0, max = 100, step = 1)
        ),
        column(
          4,
          h6("Total abundance of aquatic benthic macroinvertebrates (BMI).")
        )
      ),
      
      
      fluidRow(
        column(
          4,
          numericInput("user_richness", label = NULL, value = 0, min = 0, step = 1)
        ),
        column(
          4,
          h6("Richness of aquatic benthic macroinvertebrates (BMI).")
        )
      ),
      
      
      fluidRow(
        column(
          12,
          radioButtons(
            "user_UplandRootedPlants", 
            HTML("<b><i>Absence of upland rooted plants in the streambed</b></i>"),
            c(
              "0 (Poor)" = 0,
              "1 (Weak)" = 1,
              "2 (Moderate)" = 2,
              "3 (Strong)" = 3
            ),
            inline = T
          )
        )
      ),
      fluidRow(
        column(
          12,
          checkboxInput(
            "upland_checkbox",
            "Check if no vegetation within reach.",
            value = FALSE,
            width = NULL
          )
        )
      ),

      fluidRow(
        column(width = 12,
               HTML('<hr style="color: black; height: 1px; background-color: black;">'),
               numericInputIcon("select",
                                "Enter the Number of Densiometer Readings (min. 1, max. 12)",
                                min = 1,
                                max = 12,
                                value = 3,
                                step = 1,
                                icon = icon("hashtag"))
        )
      ),
      
      
      h5(HTML("<b>Densiometer Reading</b>")),
      fluidRow(
        column(
          width = 6,
          uiOutput("densiUI")
        ),
        column(
          width = 6,
          uiOutput(outputId = "text") %>%
            tagAppendAttributes(class = "border-my-text")
        ),
        column(width = 12,
               HTML('<hr style="color: black; height: 3px; background-color: black;">')
        )
      ),
      
      ## geospatial Metrics----
      h4(HTML("<b><u>Geospatial Metrics</u></b>")),
      fluidRow(
        column(
          12,
          numericInputIcon("user_DRNAREA",
                           HTML("Enter the reach drainage area to the nearest 0.1 mi<sup>2</sup>."),
                           min = 0,
                           value = 3,
                           step = 0.1,
                           icon = icon("hashtag")),
        ),
        column(width = 12,
               HTML('<hr style="color: black; height: 3px; background-color: black;">')
        )
      ),
      
      ## geomorphic Metrics----
      
      h4(HTML("<b><u>Geomorphic Metrics</u></b>")),
      fluidRow(
        column(
          12,
          numericInputIcon("user_Slope",
                           "Enter the percent slope to the nearest 1/2 percent.",
                           min = 0,
                           max = 500,
                           value = 3,
                           step = 0.5,
                           icon = icon("hashtag")),
          radioButtons(
            "user_NaturalValley_score",
            HTML("<b><i>Natural Valley Score</b></i>"),
            c(
              "0 (Poor)" = 0,
              "0.25" = 0.25,
              "0.5 (Weak)" = 0.5,
              "0.75" = 0.75,
              "1.0 (Moderate)" = 1.0,
              "1.25" = 1.25,
              "1.5 (Strong)" = 1.5
            ),
            inline = T
          )
        )
      ),
    
      fluidRow(
        HTML('<hr style="color: black; height: 1px; background-color: black;">'),
        column(width = 12,
               numericInputIcon("select_bank",
                                HTML("Enter the Number of Bankfull Measurements (m) <br>(min. 1, max. 3)"),
                                width = "325px",
                                min = 1,
                                max = 3,
                                value = 3,
                                step = 1,
                                icon = icon("hashtag"))
        )
      ),
      fluidRow(
        column(
          width = 6,
          uiOutput("bankUI")
        ),
        column(
          width = 6,
          uiOutput(outputId = "bank_text") %>%
            tagAppendAttributes(class = 'border-my-text')
        )
      ),
      fluidRow(
        
        HTML('<hr style="color: black; height: 3px; background-color: black;">'),
        tags$head(
          tags$style(HTML('#runmodel {background-color:#94d9f2;
                                                                padding: 8px;
                                                                font-size: 110%;
                                                                font-weight: bold;
                                                                border-style: outset;
                                                                
                                                                box-shadow: 0 8px 12px 0 rgba(0,0,0,0.24), 0 1px 1px 0 rgba(0,0,0,0.19);
                                                                transition-duration: 0.1s;
                                                                }',
                          '#runmodel:hover {
                                                                background-color:#5d8b9c;
                                                                color: black;
                                                                border-style: solid;
                                                                border-color: black;
                                                                border-width: px;
                                                                
                                                                }'))
        ),
        column(
          6,
          actionButton("runmodel", div("Run Model", icon('long-arrow-right')))
        ),
        column(
          6,
          conditionalPanel(
            condition = "input.runmodel != 0",
            uiOutput("class_out") %>%
              tagAppendAttributes(class = 'border-my-class')
          )
        ),
      ),
      fluidRow(
        column(
          12,
          br(), br(), br(), br(), br(), br()
          
        )
      )
    )
  )
}


se_panel <- function(){
  fluidRow(

    column(
      7,
      h2(HTML('<b><u>Southeast SDAM</u></b>')),
      h3(HTML("Step 2: Enter required indicator data")),
      
      ## biological indicators----
      h4(HTML("<b><u>Biological Metrics</u></b>")),
      fluidRow(
        column(
          4,
          numericInput("user_TotalAbundance", label = NULL, value = 0, min = 0, max = 100, step = 1)
        ),
        column(
          4,
          h6("Total abundance of aquatic benthic macroinvertebrates (BMI).")
        )
      ),
      fluidRow(
        column(
          4,
          numericInput("user_richness", label = NULL, value = 0, min = 0, step = 1)
        ),
        column(
          4,
          h6("Richness of aquatic benthic macroinvertebrates (BMI).")
        )
      ),

      
      fluidRow(
        column(
          12,
          radioButtons(
            "user_UplandRootedPlants", 
            HTML("<b><i>Absence of upland rooted plants in the streambed</b></i>"),
            c(
              "0 (Poor)" = 0,
              "1 (Weak)" = 1,
              "2 (Moderate)" = 2,
              "3 (Strong)" = 3
            ),
            inline = T
          )
        )
      ),
      fluidRow(
        column(
          12,
          checkboxInput(
            "upland_checkbox", 
            "Check if no vegetation within reach.", 
            value = FALSE, 
            width = NULL
          )
        ),
        column(width = 12,
               HTML('<hr style="color: black; height: 3px; background-color: black;">')
        )
      ),
  
      ## geospatial Metrics----
      h4(HTML("<b><u>Geospatial Metrics</u></b>")),
      fluidRow(
        column(
          12,
          numericInputIcon("user_DRNAREA",
                           HTML("Enter the reach drainage area to the nearest 0.1 mi<sup>2</sup>."),
                           min = 0,
                           value = 3,
                           step = 0.1,
                           icon = icon("hashtag")),
        ),
        column(width = 12,
               HTML('<hr style="color: black; height: 3px; background-color: black;">')
        )
      ),
      
      ## geomorphic indicators----
      
      h4(HTML("<b><u>Geomorphic Metrics</u></b>")),
      fluidRow(
        column(
          12,
          radioButtons(
            "user_Substrate", 
            HTML("<b><i>Particle size/stream substrate sorting</b></i>"),
            c(
              "0 (Poor)" = 0,
              "0.75" = 0.75,
              "1.5 (Weak)" = 1.5,
              "2.25" = 2.25,
              "3 (Strong)" = 3
            ),
            inline = T
          )
        )
      ),

      fluidRow(
        HTML('<hr style="color: black; height: 1px; background-color: black;">'),
        column(width = 12,
               numericInputIcon("select_bank",
                                HTML("Enter the Number of Bankfull Measurements (m) <br>(min. 1, max. 3)"),
                                width = "325px",
                                min = 1,
                                max = 3,
                                value = 3,
                                step = 1,
                                icon = icon("hashtag"))
        )
      ),
      fluidRow(
        column(
          width = 6,
          uiOutput("bankUI")
        ),
        column(
          width = 6,
          uiOutput(outputId = "bank_text") %>%
            tagAppendAttributes(class = 'border-my-text')
        )
      ),
      fluidRow(
        
        HTML('<hr style="color: black; height: 3px; background-color: black;">'),
        tags$head(
          tags$style(HTML('#runmodel {background-color:#94d9f2;
                                                                padding: 8px;
                                                                font-size: 110%;
                                                                font-weight: bold;
                                                                border-style: outset;
                                                                
                                                                box-shadow: 0 8px 12px 0 rgba(0,0,0,0.24), 0 1px 1px 0 rgba(0,0,0,0.19);
                                                                transition-duration: 0.1s;
                                                                }',
                          '#runmodel:hover {
                                                                background-color:#5d8b9c;
                                                                color: black;
                                                                border-style: solid;
                                                                border-color: black;
                                                                border-width: px;
                                                                
                                                                }'))
        ),
        column(
          6,
          actionButton("runmodel", div("Run Model", icon('long-arrow-right')))
        ),
        column(
          6,
          conditionalPanel(
            condition = "input.runmodel != 0",
            uiOutput("class_out") %>%
              tagAppendAttributes(class = 'border-my-class')
          )
        ),
      ),
      fluidRow(
        column(
          12,
          br(), br(), br(), br(), br(), br()
          
        )
      )
    )
  )
}