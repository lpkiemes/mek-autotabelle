library(rvest)
library(readr)
library(dplyr)

# URL der Webseite mit der Tabelle
url <- "https://bev-eishockey.de/a1e24d834f0cc1c366e4ae14119d3744/439"

# HTML-Seite abrufen
webpage <- read_html(url)

# Alle Tabellen auf der Seite extrahieren
tables <- webpage |> 
  html_nodes("table")  # Extrahiert alle Tabellen als Liste

# Zweite Tabelle auswählen
if (length(tables) > 2) {
  third_table <- tables[[3]] |> 
    html_table(fill = TRUE)  # In ein Dataframe umwandeln
  
  # Tabelle anzeigen
  print(third_table)
  
  third_table$Links <- rep(c("Kalenderimport"), nrow(third_table))
  third_table$LogoHeim <- NA
  third_table$LogoGast <- NA
  
  third_table <- third_table |> 
    select(Datum, Beginn, Heim, LogoHeim, Ergebnis, LogoGast, Gast, Links) |> 
    filter(Heim == "Münchner Eishockey Klub" | Gast == "Münchner Eishockey Klub")
  
  # Logos basierend auf dem Verein Heim zuweisen
  third_table$LogoHeim[third_table$Heim == "EV Mittenwald"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Mittenwald.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Mittenwald.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoHeim[third_table$Heim == "TSV Schliersee"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Schliersee.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Schliersee.png" alt="" width="25" class="alignnone size-full wp-image-10723" /></a>'
  third_table$LogoHeim[third_table$Heim == "Münchner Eishockey Klub"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2022/10/Muenchner-EK-Muenchner-Luchse-Logo.png"><img src="https://www.die-luchse.de/wp-content/uploads/2022/10/Muenchner-EK-Muenchner-Luchse-Logo.png" alt="" width="25" class="alignnone size-full wp-image-7273" /></a>'
  third_table$LogoHeim[third_table$Heim == "TSV Farchant"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Farchant.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Farchant.png" alt="" width="25" class="alignnone size-full wp-image-10765" /></a>'
  third_table$LogoHeim[third_table$Heim == "ESC Holzkirchen"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ESC-Holzkirchen.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ESC-Holzkirchen.png" alt="" width="25" class="alignnone size-full wp-image-10762" /></a>'
  third_table$LogoHeim[third_table$Heim == "DEC Inzell Frillensee"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-DEC-Inzell.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-DEC-Inzell.png" alt="" width="25" class="alignnone size-full wp-image-10759" /></a>'
  third_table$LogoHeim[third_table$Heim == "EV Berchtesgaden"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Berchtesgaden.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Berchtesgaden.png" alt="" width="25"  class="alignnone size-full wp-image-10763" /></a>'
  third_table$LogoHeim[third_table$Heim == "EV Fürstenfeldbruck 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Fuerstenfeldbruck.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Fuerstenfeldbruck.png" alt="" width="25" class="alignnone size-full wp-image-10722" /></a>'
  third_table$LogoHeim[third_table$Heim == "EHC Bad Aibling 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EHC-Bad-Aibling.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EHC-Bad-Aibling.png" alt="" width="25" class="alignnone size-full wp-image-9804" /></a>'
  third_table$LogoHeim[third_table$Heim == "SG ERSC Ottobrunn 1b / TEV Miesbach 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ERSC-Ottobrunn.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ERSC-Ottobrunn.png" alt="" width="25" class="alignnone size-full wp-image-10761" /></a>'
  
  # Logos basierend auf dem Verein Gast zuweisen
  third_table$LogoGast[third_table$Gast == "EV Mittenwald"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Mittenwald.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Mittenwald.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoGast[third_table$Gast == "TSV Schliersee"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Schliersee.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Schliersee.png" alt="" width="25" class="alignnone size-full wp-image-10723" /></a>'
  third_table$LogoGast[third_table$Gast == "Münchner Eishockey Klub"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2022/10/Muenchner-EK-Muenchner-Luchse-Logo.png"><img src="https://www.die-luchse.de/wp-content/uploads/2022/10/Muenchner-EK-Muenchner-Luchse-Logo.png" alt="" width="25" class="alignnone size-full wp-image-7273" /></a>'
  third_table$LogoGast[third_table$Gast == "TSV Farchant"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Farchant.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Farchant.png" alt="" width="25" class="alignnone size-full wp-image-10765" /></a>'
  third_table$LogoGast[third_table$Gast == "ESC Holzkirchen"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ESC-Holzkirchen.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ESC-Holzkirchen.png" alt="" width="25" class="alignnone size-full wp-image-10762" /></a>'
  third_table$LogoGast[third_table$Gast == "DEC Inzell Frillensee"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-DEC-Inzell.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-DEC-Inzell.png" alt="" width="25" class="alignnone size-full wp-image-10759" /></a>'
  third_table$LogoGast[third_table$Gast == "EV Berchtesgaden"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Berchtesgaden.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Berchtesgaden.png" alt="" width="25"  class="alignnone size-full wp-image-10763" /></a>'
  third_table$LogoGast[third_table$Gast == "EV Fürstenfeldbruck 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Fuerstenfeldbruck.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Fuerstenfeldbruck.png" alt="" width="25" class="alignnone size-full wp-image-10722" /></a>'
  third_table$LogoGast[third_table$Gast == "EHC Bad Aibling 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EHC-Bad-Aibling.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EHC-Bad-Aibling.png" alt="" width="25" class="alignnone size-full wp-image-9804" /></a>'
  third_table$LogoGast[third_table$Gast == "SG ERSC Ottobrunn 1b / TEV Miesbach 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ERSC-Ottobrunn.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ERSC-Ottobrunn.png" alt="" width="25" class="alignnone size-full wp-image-10761" /></a>'
  
  # Spaltenname
  names(third_table)[4] <- c("")
  names(third_table)[6] <- c("")
  
  # Tabelle als CSV speichern
  write_csv(third_table, "games.csv")
  cat("Dritte Tabelle erfolgreich als games.csv gespeichert!")
} else {
  cat("Es wurde keine dritte Tabelle auf der Seite gefunden.")
}

