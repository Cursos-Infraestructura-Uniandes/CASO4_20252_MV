# CASO4_20252_MAQUINA_VIRTUAL
Este repositorio contiene los archivos de configuración de las maquina virtuales para el plan de capacidad del caso 4 del curso.

Comandos para inicializar la maquina virtual (Esto solo se hace la primera vez):

```
cd Desktop

sudo apt install git

git clone https://github.com/Cursos-Infraestructura-Uniandes/CASO4_20252_MAQUINA_VIRTUAL.git

cd CASO4_20252_MAQUINA_VIRTUAL

chmod +x install_docker.sh

./install_docker.sh

chmod +x install_jmeter.sh

./install_jmeter.sh
```

Comandos para levantar el servicio de rastreo de paquetes:

```
cd tracking_service

chmod +x deploy_service.sh

sudo ./deploy_service.sh
```

Comandos para ejecutar una prueba de carga:

```
cd ..

cd jmeter_test

chmod +x run_test.sh

./run_test.sh
```

Comandos para descargar los resultados de una prueba de carga en su computador local:

```
cd ~/Desktop/CASO4_20252_MAQUINA_VIRTUAL/jmeter_test

nohup python3 -m http.server 8080 &
```

Y abre la siguiente url en tu navegador:

```
http://<IP_DE_TU_VM>:8080
```

Una vez termine de descargar las pruebas de carga:

```
ps aux | grep http.server
```