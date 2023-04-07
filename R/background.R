bkgrnd <- fluidRow(
  tags$style(HTML("
                  .center-img{
                  display: block;
                  margin-left: auto;
                  margin-right: auto;
                  width: 50%;
                  }")),
  column(10,
    HTML("<br>"),
    tagList(
      tags$p(HTML("Streams may exhibit a diverse range of hydrologic regimes that strongly influence physical, chemical, and 
             biological characteristics of streams and their adjacent riparian areas. 
             Such hydrologic information supports many management decisions. 
             One important aspect of hydrologic regime is streamflow duration—the length of time that a stream supports sustained surface flow. 
             However, requisite hydrologic data to determine flow duration is unavailable at most reaches nationwide. 
             Although maps, hydrologic models, and other data resources exist 
             (e.g., the <a href=\"https://www.usgs.gov/core-science-systems/ngp/national-hydrography/national-hydrography-dataset?qt-science_support_page_related_con=0#qt-science_support_page_related_con\">
             National Hydrography Dataset
             </a>), 
             they may exclude small headwater streams, and limitations on accuracy and spatial or temporal resolution may reduce their utility for many management applications. 
             Therefore, there is a need for rapid, field-based methods to determine flow duration class at the reach scale in the absence of long-term hydrologic data 
             (e.g., <a href=\"https://www.mdpi.com/2073-4441/12/9/2545\">Fritz et al., 2020</a>)")),
    
      tags$p("For the purposes of the method presented here, stream reaches are classified into three types based on increasing streamflow duration:"),
      tags$ul(
        tags$li(tags$p("Ephemeral reaches flow only in direct response to precipitation. Water typically flows only during and shortly after large precipitation events, the streambed is always above the water table, and stormwater runoff is the primary source of water.")),
        tags$li(tags$p("Intermittent reaches are channels that contain water for only part of the year, typically during the wet season, where the streambed may be below the water table and/or where the snowmelt from surrounding uplands provides sustained flow. The flow may vary greatly with stormwater runoff.")),
        tags$li(tags$p("Perennial reaches contain water continuously during a year of normal rainfall, often with the streambed located below the water table for most of the year. Groundwater supplies the baseflow for perennial reaches, but flow is also supplemented by stormwater runoff or snowmelt."))
      ),
      tags$img(src="nese_regions.png", style="height: 510px", class="center-img"),
      br(),
      tags$p(HTML("<a href=\"https://www.epa.gov/streamflow-duration-assessment/beta-streamflow-duration-assessment-method-northeast-and-southeast\">
      This online tool supports application of the Beta Streamflow Duration Assessment Method for the Northeast (Beta SDAM NE)
              and the Beta Streamflow Duration Assessment Method for the Southeast (Beta SDAM SE)</a>
             by running the developed random forest model based on entered data to obtain the classification for individual assessment reaches. The Beta SDAMs are based on the presence of biological, geospatial, and geomorphological indicators that are associated with gradients of streamflow duration. "),
      tags$p("The NE and SE Beta SDAMs are based on eight indicators measured in the field, plus two spatial variables generated using this website. The indicators are:")),
      tags$ul(
        tags$li(
          HTML(
            "<p>Biological indicators:
            <br>
            <ul>
              <li>Total abundance of aquatic benthic macroinvertebrates (Beta SDAM SE)</li>
              <li>BMI score based on total abundance and richness of aquatic benthic macroinvertebrates (Beta SDAM NE, Beta SDAM SE)</li>
              <li>Percent shading (Beta SDAM NE)</li>
              <li>Absence of rooted upland plants in the streambed (Beta SDAM NE, Beta SDAM SE)</li>
            </ul>
            </p>
            "
          )
        ),
          tags$li(
            HTML(
              "<p>Geospatial indicators:
            <br>
            <ul>
              <li>Mean precipitation (Beta SDAM NE, Beta SDAM SE)</li>
              <li>Drainage area (mi<sup>2</sup>) (Beta SDAM NE, Beta SDAM SE)</li>
            </ul>
            </p>
            "
            )
          ),
        tags$li(
          HTML(
            "<p>Geomorphological indicators
            <br>
            <ul>
              <li>Bankfull channel width (Beta SDAM NE, Beta SDAM SE)</li>
              <li>Slope (Beta SDAM NE)</li>
              <li>Natural Valley Score (Beta SDAM NE)</li>
              <li>Particle size or stream substrate sorting (Beta SDAM SE)</li>
            </ul>
            </p>
            "
          )
        )

      ),
      tags$p("Users may obtain classifications using this website, after which they have the option to generate a report in standardized format."),
      tags$p(
        HTML(
          "This Beta method will be updated as more data are collected. For further information about streamflow duration assessment methods, 
          refer to the <a href=\"https://www.epa.gov/streamflow-duration-assessment\">EPA website</a>."
        )
      ),
      tags$p("No information entered on this site is stored or retained by EPA or its contractors.")
 
    )
  )
)