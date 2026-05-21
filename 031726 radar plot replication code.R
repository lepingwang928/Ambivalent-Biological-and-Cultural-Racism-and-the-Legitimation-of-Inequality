
# Libraries
library(tidyverse)
library(viridis)
library(patchwork)
library(hrbrthemes)
library(fmsb)
library(colormap)


#############Overlay US and NL
#############Blatant biological racism
# Create data
par(mfrow=c(2,2), mar=c(3,0,3,0), oma=c(2,1,1,1))


data.b.racist.us.nl <- as.data.frame(matrix( c(c(1,1,0,0,0,1,1,1,0,1,0,0,0,0,1,0), c(0,1,0,0,0,1,0,1,0,0,1,0,0,0,0,0)), ncol=16, byrow=TRUE))
colnames(data.b.racist.us.nl) <- c("Male" , "Right","Middle","Higher ed", "Lower ed" , "Practicing" , "Catholic", "Muslim", "Black" , "Asian", "Non-white", "White", "Low income", "Middle income", "High income", "Older")
data.b.racist.us.nl <- rbind(rep(1,16) , rep(0,16) , data.b.racist.us.nl)

data.c.racist.us.nl <- as.data.frame(matrix( c(c(1,1,0,1,0,1,1,0,0,0,0,1,0,0,1,1), c(1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0)), ncol=16, byrow=TRUE))
colnames(data.c.racist.us.nl) <- c("Male" , "Right","Middle","Higher ed", "Lower ed" , "Practicing" , "Catholic", "Muslim", "Black" , "Asian", "Non-white", "White", "Low income", "Middle income", "High income", "Older")
data.c.racist.us.nl <- rbind(rep(1,16) , rep(0,16) , data.c.racist.us.nl)

data.b.amb.us.nl <- as.data.frame(matrix( c(c(0,0,1,0,1,1,0,1,0,0,0,0,0,0,0,0), c(0,0,1,0,1,1,0,0,0,0,0,0,0,1,0,0)), ncol=16, byrow=TRUE))
colnames(data.b.amb.us.nl) <- c("Male" , "Right","Middle","Higher ed", "Lower ed" , "Practicing" , "Catholic", "Muslim", "Black" , "Asian", "Non-white", "White", "Low income", "Middle income", "High income", "Older")
data.b.amb.us.nl <- rbind(rep(1,16) , rep(0,16) , data.b.amb.us.nl)

data.c.amb.us.nl <- as.data.frame(matrix( c(c(0,0,1,0,1,0,0,0,1,0,0,0,1,0,0,0), c(0,0,1,0,1,0,0,0,0,0,0,0,0,1,0,0)), ncol=16, byrow=TRUE))
colnames(data.c.amb.us.nl) <- c("Male" , "Right","Middle","Higher ed", "Lower ed" , "Practicing" , "Catholic", "Muslim", "Black" , "Asian", "Non-white", "White", "Low income", "Middle income", "High income", "Older")
data.c.amb.us.nl <- rbind(rep(1,16) , rep(0,16) , data.c.amb.us.nl)


# Prepare color
colors_border=c( rgb(0.2,0,1,0.9), rgb(1,0,0.2,0.9)  )
colors_in=c( rgb(0.2,0,1,0.6), rgb(1,0,0.2,0.6)  )

# Custom the radarChart !
radarchart( data.b.racist.us.nl, 
            
            #custom polygon
            pcol=colors_border , pfcol=colors_in , plwd=4, plty=1 ,
            
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey",  cglwd=1.1,
            
            #custom labels
            vlcex=1
)

title("Blatant Biological Racism", cex.main=1.2, family="Arial", font.main=1)


#############Blatant Cultural racism
# Custom the radarChart !
radarchart( data.c.racist.us.nl, 
            
            #custom polygon
            pcol=colors_border , pfcol=colors_in , plwd=4, plty=1 ,
            
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey",  cglwd=1.1,
            
            #custom labels
            vlcex=1
)

title("Blatant Cultural Racism", cex.main=1.2, family="Arial", font.main=1)


#############Ambivalent biological racism
# Custom the radarChart !
radarchart( data.b.amb.us.nl, 
            
            #custom polygon
            pcol=colors_border , pfcol=colors_in , plwd=4, plty=1 ,
            
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey",  cglwd=1.1,
            
            #custom labels
            vlcex=1
)

title("Ambivalent Biological Racism", cex.main=1.2, family="Arial", font.main=1)

#############Ambivalent cultural racism
# Custom the radarChart !
radarchart( data.c.amb.us.nl,
            
            #custom polygon
            pcol=colors_border , pfcol=colors_in , plwd=4, plty=1 ,
            
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey",  cglwd=1.1,
            
            #custom labels
            vlcex=1
)

title("Ambivalent Cultural Racism", cex.main=1.2, family="Arial", font.main=1)


par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")
legend("bottom", legend = c("U.S.", "NL"), bty = "n", pch=20, 
       col=colors_border, text.col = "black", cex=1.2, pt.cex=2, 
       ncol=2, inset=0.02)

par(mfrow=c(1,1), oma=c(0,0,0,0))

