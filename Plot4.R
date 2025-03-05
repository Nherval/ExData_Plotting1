# Cargar las librerías necesarias
library(data.table)

# Cargar el archivo de datos
data_file <- "household_power_consumption.txt"
data <- fread(data_file, na.strings = "?", sep = ";")

# Convertir la columna 'Date' a formato Date
data[, Date := as.Date(Date, format="%d/%m/%Y")]

# Filtrar los datos para las fechas 2007-02-01 y 2007-02-02
filtered_data <- data[Date %in% as.Date(c("2007-02-01", "2007-02-02"))]

# Crear una columna de fecha y hora combinada (para el eje X)
filtered_data[, DateTime := as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S")]

# Convertir 'Global_reactive_power' a numérico
filtered_data[, Global_reactive_power := as.numeric(Global_reactive_power)]

# Abrir el dispositivo gráfico (guardar como PNG)
png("plot4.png", width = 480, height = 480)

# Crear el gráfico de líneas
plot(filtered_data$DateTime, filtered_data$Global_reactive_power, 
     type = "l", # Tipo de gráfico: "l" para líneas
     col = "purple", 
     xlab = "Fecha y Hora", 
     ylab = "Global Reactive Power (kilovoltamperios)", 
     main = "Global Reactive Power over Time")

# Cerrar el dispositivo gráfico para guardar el archivo PNG
dev.off()
