library(httr)
library(jsonlite)

base <- "https://api.covidactnow.org/v2/states.json?"
apiKey <- "apiKey=7169cf965bef4df0812220e481f57638"
urlApiCovid <- paste0(base,apiKey)

jsonData <- GET(urlApiCovid)

COVID_list <- fromJSON(rawToChar(jsonData$content), flatten = TRUE)

df <- data.frame(
  Estado = COVID_list$state,
  Poblacion = COVID_list$population
)

View(df)

library(ggplot2)
library(dplyr)
library(scales)

df <- df %>% arrange(desc(Poblacion))

ggplot(df, aes(x = reorder(Estado, -Poblacion), y = Poblacion)) +
  geom_bar(stat = "identity", fill = "green", color = "black") +
  labs(title = "Población por Estado en EE.UU.",
       x = "Estado",
       y = "Población") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_y_continuous(labels = comma)


#Crear estrutura de data frame
#graficar poblacion por estado
#Crear Markdown 
