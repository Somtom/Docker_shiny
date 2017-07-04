# Skript to change the blue skin to custom foerster CSS

tags$head(tags$style(HTML('
                          /* logo */
                          .skin-blue .main-header .logo {
                          background-color: #363636;
                          }
                          
                          /* logo when hovered */
                          .skin-blue .main-header .logo:hover {
                          background-color: #363636;
                          }
                          
                          /* navbar (rest of the header) */
                          .skin-blue .main-header .navbar {
                          background-color: #363636;
                          }
                          
                          /* main sidebar */
                          .skin-blue .main-sidebar {
                          background-color: #EFEFEF;
                          }
                          
                          /* content wrapper */
                          .skin-blue .content-wrapper {
                          background-color: #78DC27;
                          }
                          
                          /* active selected tab in the sidebarmenu */
                          .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
                          background-color: #DCDCDC;
                          }
                          
                          /* other links in the sidebarmenu */
                          .skin-blue .main-sidebar .sidebar .sidebar-menu a{
                          background-color: #EFEFEF;
                          color: #000000;
                          }
                          
                          /* other links in the sidebarmenu when hovered */
                          .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
                          background-color: #DCDCDC;
                          }
                          
                          /* toggle button when hovered  */
                          .skin-blue .main-header .navbar .sidebar-toggle:hover{
                          background-color: #212121;
                          }
                          
                          /* small left border on selected tab in sidebarmenu */
                          .skin-blue .sidebar-menu>li.active>a,
                          .skin-blue .sidebar-menu>li:hover>a {
                          color:#fff;
                          background:#1e282c;
                          border-left-color:#363636
                          }
                          ')
                     )
)