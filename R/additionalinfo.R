addinfo <- fluidRow(
  column(10,
         tagList(
           br(),
           tags$p(HTML("For additional information, please refer to the user manual developed 
                       for the Beta Streamflow Duration Assessment Method for the Northeast or 
                       the Beta Streamflow Duration Assessment Method for the Southeast. 
                       Information about this method can be found on the 
                       <a
                       href=\"
                       https://www.epa.gov/streamflow-duration-assessment/streamflow-duration-assessment-method-great-plains\">
                       Environmental Protection Agency's Beta Streamflow Duration Assessment Methods 
                       website.
                       </a> The user manual, training material, and other resources may be accessed from the 
                       <a
                       href=\"
                       https://sdam-for-great-plains-eprusa.hub.arcgis.com/\">
                       SDAM NESE Training Hub.</a>")
            ),
           
           tags$p("Identification of aquatic invertebrates:"),
           tags$ul(
             tags$li(tags$p(HTML(
             "<a href =\"https://www.macroinvertebrates.org/\">
                 Macroinvertebrates.org
              </a>"))),
             # tags$li(tags$p(HTML(
             # "<a href =\"https://www.waterbugkey.vcsu.edu/index.htm\">
             #     Digital Key to Aquatic Insects of North Dakota
             #  </a>"))),
             # tags$li(tags$p(HTML("
             #  <a href =\"https://dep.wv.gov/WWE/getinvolved/sos/Pages/UMW.aspx\">
             #     Guide to Aquatic Invertebrates of the Upper Midwest
             #  </a>"))),
             tags$li(tags$p(HTML("
              <a href =\"https://sciencebase.usgs.gov/naamdrc/\">
                 North America Macroinvertebrate Digital Reference Collection
              </a>"))),
             tags$li(tags$p(HTML("
              <a href =\"https://freshwater-science.org/\">
                 The Society for Freshwater Scientists
              </a>"))),
             tags$li(tags$p(HTML("
              <a href =\"https://www.epa.gov/sites/default/files/2015-10/documents/macroinvertebrate_field_guide.pdf\">
                 Macroinvertebrate Indicators of Streamflow Duration OR, WA, & ID
              </a>"))),
             tags$li(tags$p(HTML(
             "<a href =\"http://cfb.unh.edu/StreamKey/html/index.html\">
                 UNH Center for Freshwater Biology: An Image-based key to stream insects
             </a>"))),
             tags$li(tags$p(HTML(
               "<a href =\"https://www.clemson.edu/public/watershed/scaas/files/sc-aas-macro-key-11x17.pdf\">
                 South Carolina Adopt-a-Stream Key for Identifying Macroinvertebrates
             </a>"))),
             tags$li(tags$p(HTML(
               "<a href =\"https://dnr.maryland.gov/streams/Publications/ea-99-2_rev2003.pdf\">
                 Family-level key to the stream invertebrates of Maryland and surrounding areas
             </a>"))),
             tags$li(tags$p(HTML(
               "<a href =\"https://fieldguides.fieldmuseum.org/sites/default/files/rapid-color-guides-pdfs/macro_id_cards_2015_v2.pdf\">
                 A selection of aquatic macroinvertebrates of Illinois, USA 
             </a>"))),
           ),
           tags$p("Mobile Applications (Android & iOS) :"),
           tags$ul(
             tags$li(tags$p(HTML(paste0("Aqua Bugs (" ,
               "<a href =\"https://play.google.com/store/apps/details?id=com.iwla.aqua_bugs&hl=en\">
                Android
              </a>",
               " & ",
               "<a href =\"https://apps.apple.com/us/app/aqua-bugs/id1088808991\">
                iOS)
              </a>")))),
             tags$li(tags$p(HTML(
               "<a href =\"https://www.macroinvertebrates.org/app/download\">
                 PocketMacros
              </a>"))),
             
           ),
           
           tags$p("Distinguishing rooted upland plants (FAC, FACU or UPL) from hydrophytic vegetation (FACW and OBL) observed in streambeds:"),
           tags$ul(
             tags$li(tags$p(HTML(
               "<a href =\"https://wetland-plants.usace.army.mil/nwpl_static/v34/home/home.html\">
                 U.S. Army Corps of Engineers National Wetland Plant Lists
              </a>"))),
             tags$li(tags$p(HTML(
               "<a href =\"https://plants.usda.gov/home\">
               USDA Plants Database
               </a>"))),
             tags$li(tags$p(HTML("
              <a href =\"https://www.wildflower.org/collections/\">
                 Lady Bird Johnson Wildflower Center
              </a>(Continental U.S.)"))),
           ),

           tags$p("Bankfull indicators:"),
           tags$ul(
             tags$li(tags$p(HTML(
               "<a href =\"https://www.fs.usda.gov/biology/nsaec/products-videoswebinars.html\">
                 U.S. Forest Service National Stream and Aquatic Ecology Center
              </a>"))),
             tags$li(tags$p(HTML(
               "<a href =\"https://dirtandgravel.psu.edu/wp-content/uploads/2022/06/TB_Bankfull-1.pdf\">
                 Penn State Technical Bulletin on Bankfull Width Determination
              </a>"))),
             
           ),
           tags$p(HTML(
             "R code used to develop this application is available here: 
             <a href =\"https://github.com/WSaulnier/beta_sdam_gp\" 
             > https://github.com/WSaulnier/beta_sdam_gp </a>"
             )
            ),
           tags$p("For additional support with this website, please contact Will Saulnier (wsaulnier@eprusa.net) 
                  at Ecosystem Planning and Restoration.")
         )
  )
)