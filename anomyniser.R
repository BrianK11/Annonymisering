remove(list =ls())

library(readxl)
library(writexl)
library(DescTools)

navn <- file.choose()

df <- read_excel(navn, sheet = 1)

overskrift <- colnames(df)
overskrift


# Skriv kolone index nr
Rekvisitionsnummer <-  1 
Proevenummer <-  2
# overskrift[Rekvisitionsnummer]


set.seed(42) # set et random seed, så hvis man køre flere gange, vil resultatet blive det samme
rek <- data.frame(unique(df[,overskrift[Rekvisitionsnummer]]))
x <- 1:nrow(rek)
rek$nn_Rekvisitionsnr <- sample(x) #+ 1.1e11

pr <- data.frame(unique(df[,overskrift[Proevenummer]]))
x <- 1:nrow(pr)
pr$nn_Glasnr <- sample(x) #+ 1.2e11

df <- left_join(df,rek, by=overskrift[Rekvisitionsnummer])
df <- left_join(df,pr, by=overskrift[Proevenummer])

# write_xlsx(df,'udbudsdata.xlsx') #kan bruges hvis man gerne vil have både annonymiseret og ikke annonymiseret data i et regneark


# Fjern de oprindelige koloner som skal annomymiseres
ny <- colnames(df)
ny <- ny[- c(Rekvisitionsnummer, Proevenummer)]
ny <- ny[c((length(ny)-1),length(ny), 1:(length(ny)-2))] # omroker kolonerne

df1 <- df[,ny]

x <- SplitPath(navn)
nynavn <- paste('nn_', x$fullfilename, sep = "", collapse = NULL)

#Skriv det endelige data i excel format, med samme navn som den oprindelige fil tilføjet "nn_" foran
write_xlsx(df1,nynavn) 
# OBS dato og tids formatet er: "Y-M-D H:M:S UTC" kolonerne kan nemt konverteres i excel, hvis det ønskes - excel forstår formatet
                        

                 