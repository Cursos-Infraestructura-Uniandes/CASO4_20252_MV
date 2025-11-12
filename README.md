# CASO4_20252_MV

Este repositorio contiene los archivos de configuración de las maquinas virtuales para ejecutar el plan de carga del caso 4 del curso.

Enlace del tutorial para realizar las pruebas de carga: www.youtube.com

### Paso 1. Conectarse a la maquina virtual:

Cada estudiante tiene el usuario, contraseña y dirección IP de su maquina virtual asignada. Toda la prueba de carga se hara en una terminal, para ello debe abrir una **terminal bash**.

Una vez se encuentre en la terminal bash, se deben conectar por ssh a su maquina virtual meadiante el siguiente comando:

```
ssh <usuario>@<direccion_ip>
Ej: ssh estudiante@172.24.100.7
```

### Paso 2. Comandos para instalar Git, Docker y Jmeter:

```
sudo apt install git

git clone https://github.com/Cursos-Infraestructura-Uniandes/CASO4_20252_MV.git

cd CASO4_20252_MV

chmod +x install_docker.sh

./install_docker.sh

chmod +x install_jmeter.sh

./install_jmeter.sh
```

### Paso 3. Comandos para levantar el servicio de rastreo de paquetes:

Para ejecutar la pruebas de carga primero deben levantar el contenedor que contiene el endpoint ```/packages/{package_id}/track``` y exponerlo en el localhost de la maquina virtual con el puerto 8000:

```
cd ~/CASO4_20252_MV/tracking_service

chmod +x deploy_service.sh

sudo ./deploy_service.sh
```

### Paso 4. Comandos para ejecutar una prueba de carga:

Una vez tengan el endpoint activo, ya pueden empezar a ejecutar las pruebas de carga. Para ello, debe ejecutar un script que ejecutara una prueba de carga (El script le pedira el número de usuarios concurrentes y el id de paquete que quiere rastrear):

```
cd ~/CASO4_20252_MV/jmeter_test

chmod +x run_test.sh

./run_test.sh
```

Debe descargar los archivos con los resultados de las pruebas de carga para posteriormente analizarlos.