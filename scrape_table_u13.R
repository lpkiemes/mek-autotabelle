## ---------------------------
##
## Script name: Tabelle des Münchner Eishockey Klub von der BEV Website
##
## Purpose of script: Zieht die Daten des BEV, wählt die des MEK aus
## und formatiert sie zum Upload in Github. Von dort kann man sie als 
## Link in Wordpress einfügen
##
## Author: Laura Kiemes
##
## Date Created: 2025-10-24
##
## Copyright (c) Laura Kiemes, 2025
## Email: L.Kiemes@campus.lmu.de
##
## ---------------------------
##
## Notes: U13-BZL-01
##
##
## ---------------------------
## Load packages

if (!require("pacman")) install.packages("pacman")
library(pacman)
pacman::p_load(here, styler, lintr, rvest, readr, dplyr)

## File structure
here::i_am("scrape_table.R") # Name this file here

## ---------------------------

# URL der Webseite mit der Tabelle der Gruppe Mitte
url <- "https://bev-eishockey.de/a1e24d834f0cc1c366e4ae14119d3744/250"

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
  
  # Logos basierend auf dem Verein zuweisen
  ## MEK
  second_table$Team[second_table$Verein == "SG Münchner Eishockey Klub / Wanderers Germering II"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2022/10/Muenchner-EK-Muenchner-Luchse-Logo.png"><img src="https://www.die-luchse.de/wp-content/uploads/2022/10/Muenchner-EK-Muenchner-Luchse-Logo.png" alt="" width="25" class="alignnone size-full wp-image-7273" /></a>'
  
  ## U13-BZL-01
  second_table$Team[second_table$Verein == 'ESV Buchloe'] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ESV-Buchloe.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ESV-Buchloe.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == 'ESV Türkheim'] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/02/Logo-ESV-Tuerkheim.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/02/Logo-ESV-Tuerkheim.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == 'ESV Burgau 2000'] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/08/LOGO-ESV-Burgau.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/08/LOGO-ESV-Burgau.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == 'EV Fürstenfeldbruck'] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Fuerstenfeldbruck.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Fuerstenfeldbruck.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == 'ESV Dachau Woodpeckers'] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ESV-Dachau.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ESV-Dachau.pngg" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == 'SG 1. EC Senden / ECDC Memmingen II'] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/08/LOGO-EC-Senden.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/08/LOGO-EC-Senden.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == 'EV Pfronten'] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/08/LOGO-EV-Pfronten.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/08/LOGO-EV-Pfronten.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == 'EV Bad Wörishofen II'] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/03/Logo-EC-Bad-Woerishofen.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/03/Logo-EC-Bad-Woerishofen.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  
  ## U15 BZL-02
  second_table$Team[second_table$Verein == 'EHC Waldkraiburg "Die Löwen"'] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EHC-Waldkraiburg.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EHC-Waldkraiburg.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == 'EV Dingolfing Isarrats'] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/08/LOGO-EV-Dingolfing-Isarrats-scaled.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/08/LOGO-EV-Dingolfing-Isarrats-scaled.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == 'DEC Inzell Frillensee'] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-DEC-Falken-Inzell.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-DEC-Falken-Inzell.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == 'EV Fürstenfeldbruck'] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Fuerstenfeldbruck.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Fuerstenfeldbruck.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == 'SG ESC Holzkirchen / TEV Miesbach II'] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ESC-Holzkirchen.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ESC-Holzkirchen.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == 'SG TSV 1863 Trostberg / EHC Klostersee II'] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/08/LOGO-TSV-Trostberg.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/08/LOGO-TSV-Trostberg.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  
  ## Gruppe Mitte
  second_table$Team[second_table$Verein == "SE Freising"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-Black-Bears-Freising.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-Black-Bears-Freising.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == "ESV Dachau Woodpeckers"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ESV-Dachau.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ESV-Dachau.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == "EV Dingolfing Isarrats 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/08/LOGO-EV-Dingolfing-Isarrats-scaled.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/08/LOGO-EV-Dingolfing-Isarrats-scaled.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == "EV Aich"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EV-Aich.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EV-Aich.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == 'EHC Waldkraiburg "Die Löwen" 1b'] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-EHC-Waldkraiburg-1B.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-EHC-Waldkraiburg-1B.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == "EC Pfaffenhofen 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EC-Pfaffenhofen.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EC-Pfaffenhofen.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == "ESV Gebensbach"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ESV-Gebensbach.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ESV-Gebensbach.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == "ESC Vilshofen"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-ESC-Vilshofen.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-ESC-Vilshofen.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == "ERC Regen"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ERC-Regen.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ERC-Regen.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == "ESC Dorfen 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-ESC-Dorfen-Stammverein.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-ESC-Dorfen-Stammverein.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  
  
  ## Gruppe Sued
  second_table$Team[second_table$Verein == "EV Mittenwald"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Mittenwald.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Mittenwald.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  second_table$Team[second_table$Verein == "TSV Schliersee"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Schliersee.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Schliersee.png" alt="" width="25" class="alignnone size-full wp-image-10723" /></a>'
  second_table$Team[second_table$Verein == "TSV Farchant"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Farchant.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Farchant.png" alt="" width="25" class="alignnone size-full wp-image-10765" /></a>'
  second_table$Team[second_table$Verein == "ESC Holzkirchen"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ESC-Holzkirchen.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ESC-Holzkirchen.png" alt="" width="25" class="alignnone size-full wp-image-10762" /></a>'
  second_table$Team[second_table$Verein == "DEC Inzell Frillensee"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-DEC-Inzell.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-DEC-Inzell.png" alt="" width="25" class="alignnone size-full wp-image-10759" /></a>'
  second_table$Team[second_table$Verein == "EV Berchtesgaden"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Berchtesgaden.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Berchtesgaden.png" alt="" width="25"  class="alignnone size-full wp-image-10763" /></a>'
  second_table$Team[second_table$Verein == "EV Fürstenfeldbruck 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Fuerstenfeldbruck.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Fuerstenfeldbruck.png" alt="" width="25" class="alignnone size-full wp-image-10722" /></a>'
  second_table$Team[second_table$Verein == "EHC Bad Aibling 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EHC-Bad-Aibling.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EHC-Bad-Aibling.png" alt="" width="25" class="alignnone size-full wp-image-9804" /></a>'
  second_table$Team[second_table$Verein == "SG ERSC Ottobrunn 1b / TEV Miesbach 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ERSC-Ottobrunn.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ERSC-Ottobrunn.png" alt="" width="25" class="alignnone size-full wp-image-10761" /></a>'
  
  # Falls der Verein nicht übereinstimmt, bleibt die Spalte leer
  second_table$Team[is.na(second_table$Team)] <- NA
  
  # Spaltenname
  names(second_table)[1] <- c("")
  names(second_table)[2] <- c("")
  
  print(second_table)
  
  # Tabelle als CSV speichern
  write_csv(second_table, "tabelle_U13.csv")
  cat("Zweite Tabelle erfolgreich als tabelle_U13.csv gespeichert!")
} else {
  cat("Es wurde keine zweite Tabelle auf der Seite gefunden.")
}

