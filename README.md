# Daily Quote App

### Dependencies

    cupertino_icons: ^0.1.2
    after_layout: ^1.0.7+2
    google_fonts: ^1.0.0
    image_picker: ^0.6.5+2
    shared_preferences: ^0.5.7
    cached_network_image: ^2.1.0+1
    keyboard_actions: ^3.2.1
    provider: ^4.0.0
    http: any
    flutter_launcher_icons: ^0.7.5
    
### Dev Dependencies
    test: any
    flutter_test:
      sdk: flutter
    local_auth: ^0.6.2+1
    pedantic: ^1.8.0+1
    
### Extra Dependencies
    flutter_icons:
      android: "launcher_icon"
      ios: true
      image_path: "assets/icon/icon.png"


### API Rest Service
    https://quotes.rest/ (Version gratis de They Said So Quotes API)
    
## Uso de dependencias

- Cupertino icons viene por defecto, puede quitarse pero esta agrega un buen set de iconos en Flutter.
- After layout agrega una ejecución por si necesitas ejecutar algo justamente después de que se termina el build de tu código, existe otra forma de hacerlo pero esta es muy limpia.
- Google fonts, se utilizó para darle un estilo específico a todo el app de fuente, ya que de querer hacer un cambio en esto solo se cambia en el archivo AppStyles dentro de lib>src>components y el cambio se realizara en todos lados, a demás que optimiza el uso de fuentes en el app.
- Image picker, ayuda con el proceso de selección de imagen en Galería o desde cámara.
- Shared Preferences almacenamiento de información en el dispositivo mediante clases, se usó para guardar el usuario y aparte controlar por ejemplo si el usuario ya esta logueado no pedir datos de nuevo. 
- Cache Network Image optimiza el uso de recursos de red ya que carga la imagen y si esta no cambia en un "refresh" no la manda traer del sitio solo la carga de local de regreso.
- Keyboard Actions usada para el manejos de forms y moverse entre TextFormField.
- Provider usado como state management, para evitar pasar información por constructor.
- http para traer información del API Rest
- Flutter Launcher Icons se usa en conjunto con las dependencias extras usando la imagen en el path "assets/icon/icon.png" y convirtiéndola en el icono para iOS y Android.
- Local Auth se encarga de dar las herramientas necesarias para autenticar mediante, fingerprint, face id o el biometric que sea posible en el dispositivo.


## Pantallas en el App

    SplashScreen 
    RootScreen (verificacion si el usuario ya esta logueado y envia a screen correspondiente)
    RegisterForm
    LoginScreen
    QuoteScreen
    UserProfile (Drawer)
    
### Estructura del código
    lib>
        main.dart
        src> 
            quoteApp.dart
            components> archivos y carpetas que ayudan a la composicion de widgets en pantallas.
            models> modelos de quote y user.
            repositories> repositorios de quote y user.
            screens> pantallas iniciales (estas pueden contener 0-n widgets de la carpeta components) 
            states> clases para la gestion de estado.


## Ejecución de código

Moverse al path donde se encuentra el app que esta clonada y ejecutar:
    
 `flutter create .`
 
 Esta siempre es una buena practica cuando se ejecuta un código que es clonado, no afectara el código dart pero realizara los ajustes necesario en iOS y Android. 
 
 Este código está configurado para ejecutarse en ambas plataformas, tiene todos los permisos correspondientes.
