# Readme

> INSTALAR

1. Instalar [Android SDK][3].
2. Instalar [AIR 4.0][4].
3. Instalar [AIR SDK][5].
4. Seguir [este tutorial][6] hasta el punto 12.
    - En el punto 8:
    - `(l�nea 2) <application xmlns="http://ns.adobe.com/air/application/4.0">`
    - `(l�nea 40~) <initialWindow>`
    - `<fullScreen>true</fullScreen>`
    - `<visible>true</visible>`
    - `<renderMode>direct</renderMode>`
    - `<aspectRatio>portrait</aspectRatio>`
    - `<autoOrients>false</autoOrients>`
    - `</initialWindow>`
5. Instalar [Git][1].
6. Instalar [TortoiseGit][2].

> CLONAR

(Realmente no se clona as�, pero no lo he conseguido de otra forma para no tener que subir el proyecto entero y que cada uno tenga su configuraci�n xD)

1. Crear repositorio local en la carpeta del proyecto y configurar FlashDevelop (PDF clase, p�g 4 y 5)
2. Reiniciar FlashDevelop.
3. Eliminar carpetas "icons" y "src" del proyecto.
4. A�adir origin en el repositorio local.
    - Click derecho en el proyecto > Source control > Push... > Manage.
    - URL: https://github.com/Urkaz/Project-Arrow.git
    - Add New/Save.
    - Si pregunta algo, responder NO.
    - Aceptar.
    - Cancel.
5. Actualizar repositorio local.
    - Click derecho en el proyecto > Source control > **Pull** > OK
6. Reiniciar FlashDevelop.
7. Si hay alguna carpeta que siga teniendo un punto blanco, Add To Ignore List (PDF clase, p�g 7)

> COMMITS (Confirmar cambios)

Todos los cambios que se hagan no son definitivos si no se hace un commit.
Yo desde el Git GUI lo veo m�s sencillo de hacer que desde FlashDevelop o TortoiseGit (Para algo es el cliente "oficial").

 1. Abrir Git GUI.
 2. Open Existing Repository y buscar el proyecto.
 3. Se abrir� una ventana con varias partes:
    - Unstaged Changes (Rojo): Todos los archivos que se han modificado localmente.
    - Staged Changes (Verde): Los archivos que se van a incluir en el commit.
    - (Amarillo): Vista previa de los cambios de un archivo.
    - (Parte de abajo):
        - Rescan: Actualiza la lista roja.
        - Stage Changed: Pone todo lo de la lista roja en la verde.
        - Commit: Confirma el commit. (En esta parte, arriba la derecha hay dos opciones "New" y "Ammend Last", la segunda opci�n es para a�adir m�s cosas al anterior commit SIN ENVIAR, en el caso de que haya sido enviado no se podr�).

> PUSH Y PULL (Enviar y actualizar repositorio remoto y local)

Cada vez que se vaya a empezar a trabajar, ser� obligatorio hacer un PULL para que el proyecto se actualice con los cambios que haya hecho otro.

- En FlashDevelop: Click derecho en el proyecto > Source control > Pull > OK.

Cuando ya se hayan hecho commits, se tendr�n que enviar al repositorio remoto con PUSH.

- En FlashDevelop: Click derecho en el proyecto > Source control > Push... > OK.

**NOTA**: Si alguna vez al hacer un commit y hay alg�n archivo que dice que es conflictivo o algo as� con otro, es porque no se ha hecho un PULL antes de empezar, o alquien ha hecho un PUSH con nuevos cambios. En este caso, preguntad porque no se exactamente si os dejar� resolverlo xDD.

> PROBAR EN ANDROID DESDE EL PC

(Si no se hace lo del paso 3, al ejecutarlo busca un dispositivo que est� conectado por USB con android e instala y ejecuta el .apk en �l)

1. Instalar [Bluestacks][7].
2. Abrir Bluestacks (recomiendo buscar alg�n launcher m�nimamente decente e instalarlo)
3. Editar el archivo "PackageApp.bat" con FlashDevelop y cambiar la l�nea 74 por:
    - `adb -s localhost:5555 install "%OUTPUT%"`
    - `REM adb -d install -r "%OUTPUT%"` ("REM" hace que la l�nea se a un comentario)
4. Compilar el proyecto y ejecutar el mismo archivo.
    - [ 1 ]: Crea .apk sin AIR incorporado (necesita la app de AIR instalada a parte).
    - [ 2 ]: Lo mismo que [ 1 ], pero en modo debug.
    - [ 3 ]: Incorpora AIR al .apk y no necesita la otra app instalada.
5. Si al hacer esto no se instalase solo o diese error de que no se encuentra el dispositivo, a�adir entre la l�nea 69 y 70 lo siguiente:
    - `adb connect localhost:5555`

NOTA: El .apk resultante se encuentra en la carpeta /dist del proyecto.

  [1]: http://git-scm.com/downloads
  [2]: https://code.google.com/p/tortoisegit/wiki/Download
  [3]: http://dl.google.com/android/installer_r22.2.1-windows.exe
  [4]: http://get.adobe.com/es/air/
  [5]: http://www.adobe.com/devnet/air/air-sdk-download-win.html
  [6]: http://wiki.starling-framework.org/manual/project_setup#flashdevelop
  [7]: http://www.bluestacks.com/