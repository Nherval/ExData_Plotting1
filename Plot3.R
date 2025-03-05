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

# Convertir las mediciones de sub-metering a numérico
filtered_data[, Sub_metering_1 := as.numeric(Sub_metering_1)]
filtered_data[, Sub_metering_2 := as.numeric(Sub_metering_2)]
filtered_data[, Sub_metering_3 := as.numeric(Sub_metering_3)]

# Abrir el dispositivo gráfico (guardar como PNG)
png("plot3.png", width = 480, height = 480)

# Crear el gráfico de líneas
plot(filtered_data$DateTime, filtered_data$Sub_metering_1, 
     type = "l", # Tipo de gráfico: "l" para líneas
     col = "black", 
     xlab = "Fecha y Hora", 
     ylab = "Energy Sub Metering", 
     main = "Energy Sub Metering over Time")

# Añadir las otras dos series con diferentes colores
lines(filtered_data$DateTime, filtered_data$Sub_metering_2, col = "red")
lines(filtered_data$DateTime, filtered_data$Sub_metering_3, col = "blue")

# Añadir una leyenda
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

# Cerrar el dispositivo gráfico para guardar el archivo PNG
dev.off()
