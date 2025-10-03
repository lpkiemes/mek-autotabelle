## ---------------------------
##
## Script name: Spielplan des Münchner Eishockey Klub von der BEV Website
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
## Notes:
##
##
## ---------------------------
## Load packages

if (!require("pacman")) install.packages("pacman")
library(pacman)
pacman::p_load(here, styler, lintr, rvest, readr, dplyr)

## File structure
here::i_am("scrape_games.R") # Name this file here

## ---------------------------

# URL der Webseite mit der Tabelle: BEV BZL-Mitte
url <- "https://bev-eishockey.de/a1e24d834f0cc1c366e4ae14119d3744/438"

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
  print(third_table, n = 150)
  
  third_table$Links <- rep(c("Kalenderimport"), nrow(third_table))
  third_table$LogoHeim <- NA
  third_table$LogoGast <- NA
  
  third_table <- third_table |> 
    select(Datum, Beginn, Heim, LogoHeim, Ergebnis, LogoGast, Gast, Links) |> 
    filter(Heim == "Münchner Eishockey Klub" | Gast == "Münchner Eishockey Klub")
  
  # Logos basierend auf dem Verein Heim zuweisen
  ## MEK
  third_table$LogoHeim[third_table$Heim == "Münchner Eishockey Klub"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2022/10/Muenchner-EK-Muenchner-Luchse-Logo.png"><img src="https://www.die-luchse.de/wp-content/uploads/2022/10/Muenchner-EK-Muenchner-Luchse-Logo.png" alt="" width="25" class="alignnone size-full wp-image-7273" /></a>'
  
  ## Gruppe Mitte
  third_table$LogoHeim[third_table$Heim == "SE Freising"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-Black-Bears-Freising.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-Black-Bears-Freising.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoHeim[third_table$Heim == "ESV Dachau Woodpeckers"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ESV-Dachau.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ESV-Dachau.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoHeim[third_table$Heim == "EV Dingolfing Isarrats 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/08/LOGO-EV-Dingolfing-Isarrats-scaled.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/08/LOGO-EV-Dingolfing-Isarrats-scaled.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoHeim[third_table$Heim == "EV Aich"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EV-Aich.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EV-Aich.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoHeim[third_table$Heim == 'EHC Waldkraiburg "Die Löwen" 1b'] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-EHC-Waldkraiburg-1B.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-EHC-Waldkraiburg-1B.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoHeim[third_table$Heim == "EC Pfaffenhofen 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EC-Pfaffenhofen.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EC-Pfaffenhofen.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoHeim[third_table$Heim == "ESV Gebensbach"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ESV-Gebensbach.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ESV-Gebensbach.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoHeim[third_table$Heim == "ESC Vilshofen"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-ESC-Vilshofen.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-ESC-Vilshofen.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoHeim[third_table$Heim == "ERC Regen"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ERC-Regen.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ERC-Regen.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoHeim[third_table$Heim == "ESC Dorfen 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-ESC-Dorfen-Stammverein.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-ESC-Dorfen-Stammverein.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  
  ## Gruppe Sued Logos
  third_table$LogoHeim[third_table$Heim == "EV Mittenwald"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Mittenwald.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Mittenwald.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoHeim[third_table$Heim == "TSV Schliersee"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Schliersee.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Schliersee.png" alt="" width="25" class="alignnone size-full wp-image-10723" /></a>'
  third_table$LogoHeim[third_table$Heim == "TSV Farchant"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Farchant.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Farchant.png" alt="" width="25" class="alignnone size-full wp-image-10765" /></a>'
  third_table$LogoHeim[third_table$Heim == "ESC Holzkirchen"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ESC-Holzkirchen.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ESC-Holzkirchen.png" alt="" width="25" class="alignnone size-full wp-image-10762" /></a>'
  third_table$LogoHeim[third_table$Heim == "DEC Inzell Frillensee"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-DEC-Inzell.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-DEC-Inzell.png" alt="" width="25" class="alignnone size-full wp-image-10759" /></a>'
  third_table$LogoHeim[third_table$Heim == "EV Berchtesgaden"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Berchtesgaden.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Berchtesgaden.png" alt="" width="25"  class="alignnone size-full wp-image-10763" /></a>'
  third_table$LogoHeim[third_table$Heim == "EV Fürstenfeldbruck 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Fuerstenfeldbruck.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Fuerstenfeldbruck.png" alt="" width="25" class="alignnone size-full wp-image-10722" /></a>'
  third_table$LogoHeim[third_table$Heim == "EHC Bad Aibling 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EHC-Bad-Aibling.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EHC-Bad-Aibling.png" alt="" width="25" class="alignnone size-full wp-image-9804" /></a>'
  third_table$LogoHeim[third_table$Heim == "SG ERSC Ottobrunn 1b / TEV Miesbach 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ERSC-Ottobrunn.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-ERSC-Ottobrunn.png" alt="" width="25" class="alignnone size-full wp-image-10761" /></a>'
  
  
  # Logos basierend auf dem Verein Gast zuweisen
  ## MEK
  third_table$LogoGast[third_table$Gast == "Münchner Eishockey Klub"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2022/10/Muenchner-EK-Muenchner-Luchse-Logo.png"><img src="https://www.die-luchse.de/wp-content/uploads/2022/10/Muenchner-EK-Muenchner-Luchse-Logo.png" alt="" width="25" class="alignnone size-full wp-image-7273" /></a>'
  
  ## Gruppe Mitte Logos
  third_table$LogoGast[third_table$Gast == "SE Freising"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-Black-Bears-Freising.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-Black-Bears-Freising.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoGast[third_table$Gast == "ESV Dachau Woodpeckers"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ESV-Dachau.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ESV-Dachau.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoGast[third_table$Gast == "EV Dingolfing Isarrats 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/08/LOGO-EV-Dingolfing-Isarrats-scaled.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/08/LOGO-EV-Dingolfing-Isarrats-scaled.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoGast[third_table$Gast == "EV Aich"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EV-Aich.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EV-Aich.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoGast[third_table$Gast == 'EHC Waldkraiburg "Die Löwen" 1b'] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-EHC-Waldkraiburg-1B.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-EHC-Waldkraiburg-1B.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoGast[third_table$Gast == "EC Pfaffenhofen 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EC-Pfaffenhofen.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-EC-Pfaffenhofen.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoGast[third_table$Gast == "ESV Gebensbach"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ESV-Gebensbach.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ESV-Gebensbach.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoGast[third_table$Gast == "ESC Vilshofen"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-ESC-Vilshofen.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-ESC-Vilshofen.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoGast[third_table$Gast == "ERC Regen"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ERC-Regen.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/02/Logo-ERC-Regen.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoGast[third_table$Gast == "ESC Dorfen 1b"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-ESC-Dorfen-Stammverein.png"><img src="https://www.die-luchse.de/wp-content/uploads/2025/08/Logo-ESC-Dorfen-Stammverein.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  
  
  ## Gruppe Sued Logos
  third_table$LogoGast[third_table$Gast == "EV Mittenwald"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Mittenwald.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-EV-Mittenwald.png" alt="" width="25" class="alignnone size-full wp-image-10764" /></a>'
  third_table$LogoGast[third_table$Gast == "TSV Schliersee"] <- '<a href="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Schliersee.png"><img src="https://www.die-luchse.de/wp-content/uploads/2024/08/Logo-TSV-Schliersee.png" alt="" width="25" class="alignnone size-full wp-image-10723" /></a>'
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
  
  # Formatierte Tabelle ausgeben
  print(third_table, n = 100)
  
  # Tabelle als CSV speichern
  write_csv(third_table, "games.csv")
  cat("Dritte Tabelle erfolgreich als games.csv gespeichert!")
} else {
  cat("Es wurde keine dritte Tabelle auf der Seite gefunden.")
}

