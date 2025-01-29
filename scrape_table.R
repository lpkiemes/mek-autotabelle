# Versuche, Pakete zu installieren, falls sie noch nicht vorhanden sind
required_packages <- c("rvest", "dplyr", "readr")
new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages, repos = "https://cran.r-project.org")

library(rvest)
library(dplyr)
library(readr)

# URL der Webseite mit der Tabelle
url <- "https://bev-eishockey.de/a1e24d834f0cc1c366e4ae14119d3744/439"

# HTML-Seite abrufen
webpage <- read_html(url)

# Alle Tabellen auf der Seite extrahieren
tables <- webpage %>%
  html_nodes("table")  # Extrahiert alle Tabellen als Liste

# Zweite Tabelle auswählen
if (length(tables) >= 2) {
  second_table <- tables[[2]] %>%
    html_table(fill = TRUE)  # In ein Dataframe umwandeln
  
  # Tabelle anzeigen
  print(second_table)
  
  names(second_table)[2] <- c("Team")
  
  table_links <- second_table |> 
    mutate(logo = case_when(
      Verein == "EV Mittenwald" ~ '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Mittenwald.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Mittenwald.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>',
      Verein == "TSV Schliersee" ~ '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Schliersee.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Schliersee.png" alt="" width="25" class="alignnone size-full wp-image-10723" /></a>',
      Verein == "Münchner Eishockey Klub" ~ '<a href="https://www.die-luchse.de/wp-content/uploads/2022/10/Muenchner-EK-Muenchner-Luchse-Logo.png"><img src="https://www.die-luchse.de/wp-content/uploads/2022/10/Muenchner-EK-Muenchner-Luchse-Logo.png" alt="" width="25" class="alignnone size-full wp-image-7273" /></a>',
      Verein == "TSV Farchant" ~ '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Farchant.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Farchant.png" alt="" width="25" class="alignnone size-full wp-image-10765" /></a>',
      Verein == "ESC Holzkirchen" ~ '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ESC-Holzkirchen.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ESC-Holzkirchen.png" alt="" width="25" class="alignnone size-full wp-image-10762" /></a>',
      Verein == "DEC Inzell Frillensee" ~ '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-DEC-Inzell.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-DEC-Inzell.png" alt="" width="25" class="alignnone size-full wp-image-10759" /></a>',
      Verein == "EV Berchtesgaden" ~ '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Berchtesgaden.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Berchtesgaden.png" alt="" width="25"  class="alignnone size-full wp-image-10763" /></a>',
      Verein == "EV Fürstenfeldbruck 1b" ~ '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Fuerstenfeldbruck.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Fuerstenfeldbruck.png" alt="" width="25" class="alignnone size-full wp-image-10722" /></a>',
      Verein == "EHC Bad Aibling 1b" ~ '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EHC-Bad-Aibling.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EHC-Bad-Aibling.png" alt="" width="25" class="alignnone size-full wp-image-9804" /></a>',
      Verein == "SG ERSC Ottobrunn 1b / TEV Miesbach 1b" ~ '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ERSC-Ottobrunn.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ERSC-Ottobrunn.png" alt="" width="25" class="alignnone size-full wp-image-10761" /></a>',
      .default = NA
    ))
  
  # Tabelle als CSV speichern
  write_csv(table_links, "tabelle.csv")
  cat("Zweite Tabelle erfolgreich als tabelle.csv gespeichert!")
} else {
  cat("Es wurde keine zweite Tabelle auf der Seite gefunden.")
}
