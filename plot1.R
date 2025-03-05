# Código para crear el primer gráfico
library(data.table)

# Cargar el archivo de datos
data_file <- "household_power_consumption.txt"
data <- fread(data_file, na.strings = "?", sep = ";")

# Convertir columna de fecha a tipo Date
data[, Date := as.Date(Date, format="%d/%m/%Y")]

# Filtrar las fechas
filtered_data <- data[Date %in% as.Date(c("2007-02-01", "2007-02-02"))]

# Convertir Global_active_power a numérico
filtered_data[, Global_active_power := as.numeric(Global_active_power)]

#Crear gráfico 1
png ("plot.png", width = 480, height = 480)
hist(filtered_data$Global_activepower, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
