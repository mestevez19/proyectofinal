## Script to analysis the
##DataSet-Analysis-for-Human-Activity-Recognition-Using-Smartphones-Dataset
## Execute Analysis 
##   Load data from the test and training data files in UCI HAR Dataset folder
##   Union All the test and training sets
##   The Activity names is from the activity_labels file and update in the data
##   Extract  the mean and  desviations of the variables
##   Column names  from the features.txt names for more descriptions
##   compute the mean of every variable and write to tidy_data_final.txt
ejecutaranalisis <- function() {
    ## activity labels and feature names
    dir <- "UCI HAR Dataset"
    actividades <- read.table(paste(dir, "activity_labels.txt", sep="/"), col.name=c("index", "etiqueta"))
    caracteristicas <- read.table(paste(dir, "features.txt", sep="/"), col.name=c("index", "nombre"))
    
    ## test and training data sets
    sujetostest <- read.table(paste(dir, "test/subject_test.txt", sep="/"), col.names="sujeto")
    actividadestest <- read.table(paste(dir, "test/y_test.txt", sep="/"), col.names="actividad")
    resultadostest <- read.table(paste(dir, "test/X_test.txt", sep="/"))
    sujetostren <- read.table(paste(dir, "train/subject_train.txt", sep="/"), col.names="sujeto")
    actividadestren <- read.table(paste(dir, "train/y_train.txt", sep="/"), col.names="actividad")
    resultadostren <- read.table(paste(dir, "train/X_train.txt", sep="/"))
    
    ## test and training sets have no columns name
    ## so the subject and activity columns are Added 
    datostest <- cbind(sujetostest, actividadestest, resultadostest)
    datostren <- cbind(sujetostren, actividadestren, resultadostren)
    
    ##  the test and training data are Combined into one dataset
    datos <- rbind(datostest, datostren)
    
    ## the activity are replaced from the matching  name of actividades dataframe
    datos$actividad <- actividades[datos$actividad, "etiqueta"]
    #print(datos$activity)
    
    ## Keep only the columns that end with mean() or std()
    colnumeanstd<- grep("mean\\(\\)|std\\(\\)", caracteristicas$nombre)
    #colnums_with_mean_or_std <- grep("mean\\(\\)|std\\(\\)", features$name)
    #cols_with_mean_or_std <- paste("V", colnums_with_mean_or_std, sep="")
    colmstd<-paste("V", colnumeanstd,sep="")
    colsmantener = c("sujeto","actividad",colmstd)
    
    #cols_to_keep = c("subject", "activity", cols_with_mean_or_std)
    #data <- data[ ,cols_to_keep]
    datos <- datos[, colsmantener]
    #print(datos)
    
    ##from "caracteristicas nombre", change the column names
   
    names(datos) <- c("sujeto", "actividad", as.character(caracteristicas[colnumeanstd, "nombre"]))
    #print(datos)
    ## compute the mean for all the columns (3 to 68) Group by Subject X Activity
    tidy_datos <- aggregate(datos[ ,3:68], list(datos$sujeto, datos$actividad), mean)
    #print(tidy_datos)
    
    ## Update the column names
    columnas = paste("MEAN", names(datos)[3:68], sep="_")
    names(tidy_datos) = c("sujeto", "actividad", columnas)
    
    ## output file
    write.table(tidy_datos, "tidy_data_final.txt")
    
}

