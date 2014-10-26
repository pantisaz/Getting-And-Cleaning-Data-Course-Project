# Installs required packages (if necessary) for run_analysis.R to work

if (!require("car")) {
  install.packages("car")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

# Reads X train and test tables and combines them with subject train and test tables to make a single data frame

xtest<-read.table("./test/X_test.txt")
xtrain<-read.table("./train/X_train.txt")

subjectst<-read.table("./test/subject_test.txt")
subjectrn<-read.table("./train/subject_train.txt")

data1<-rbind(xtrain, xtest)

data2<-rbind(subjectrn,subjectst)

data3<-cbind(data1,data2)

# Loads the car package which has the wanted recode command. Reads the the two train and test tables combines them and then 
# using recode and lapply it generates a new data frame replacing the Activity numbers with the required Activity Labels

library(car)

ytrain<-read.table("./train/y_train.txt")
ytest<-read.table("./test/y_test.txt")

data4<-rbind(ytrain,ytest)

newdata4<-lapply(data4, FUN = function(foo) recode(foo,  "1= 'Walking' ; 2='Walking Upsatairs' ; 3='Walking Downstairs' ; 4='Sitting' ; 5='Standing' ; 6='Laying' " ))

data5<-(data.frame(newdata4))

# Combines the two previous final data frames. Which now includes X train and test, Subject train and test, and Activity Labels

data6<-cbind(data3, data5)

# Replaces column names with the variables from 'features.txt'

features<-read.table("features.txt")

colnames(data6)<- features[,2]

colnames(data6)[562:563]<-c("Subject", "Activity")

# Subsets columns with the string 'mean()' and 'std()' and removes columns with the string 'Freq' to avoid   
# columns of mean frequency

datasubset<-data6[grep("mean()", colnames(data6))]

datameans<-datasubset[-grep("Freq", colnames(datasubset))]

datastds<-data6[grep("std()", colnames(data6))]

# Combines the removed 'mean()' and 'std()' data frames, to make a single data frame 'df'

df<-cbind(datameans, datastds, data6[,562:563])

# Loads the reshape2 package and uses melt a dcast to make a new data frame that gives the mean of each variable for each 
# Subject and Activity

library(reshape2)

tidy <- melt(df, id.vars = c("Subject", "Activity"))
tidy_data<-dcast(Subject + variable ~ Activity, data = tidy, fun = mean)

# Removes invalid R variable characters like '()' and '-' and expands key words like 'Accelerometer','Magnitude', etc

tidy_data[,2]<-gsub("[()]|[-]","", tidy_data[,2],)
tidy_data[,2]<-sub("Acc","Accelerometer", tidy_data[,2],)
tidy_data[,2]<-sub("std", "StandardDeviation", tidy_data[,2],)
tidy_data[,2]<-sub("Mag", "Magnitude", tidy_data[,2],)
tidy_data[,2]<-sub("Gyro", "Gyroscope", tidy_data[,2],)

head(tidy_data)

# Saves a text file of the final 'tidy_data' data frame to the working directory

write.table(tidy_data, file = "tidy_data.txt", row.name=FILE)
