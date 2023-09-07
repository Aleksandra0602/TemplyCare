import 'package:get/get.dart';

class LocalStrings extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          "unknownDevice": "Unknown device",
          "connectDevice": "Connect",
          "alreadyConnected": "already connected",
          "firstAppBar": "TemplyCare",
          "buttonText1": "Display current data",
          "buttonText2": "Take the measurement",
          "buttonText3": "Battery status",
          "buttonText4": "Memory Card status",
          "buttonText5": "View files",
          "buttonText6": "Time on device",
          "bleTitle": "Bluetooth is turned off!",
          "bleMessage":
              "To use the application, turn on Bluetooth on your device",
          "bleClose": "Close the app",
          "bleOn": "Turn on Bluetooth",
          "deviceConnect": "Connect to the device",
          "wifiTitle": "Wi-Fi data",
          "wifiSSID": "Wi-Fi SSID (Wi-Fi name)",
          "wifiPassword": "Wi-Fi password",
          "writeWifiData": "Save and send",
          "wifiText":
              "To configure the connection with your Wi-Fi network, please enter the SSID (network name) and password above. This information will be sent to the Arduino device to enable data transmission from the device to the InfluxDB database.",
          "logIn": "Log in",
          "signIn": "Sign up",
          "registration": "Registration",
          "log": "Login",
          "password": "Password",
          "repeatPassword": "Repeat password",
          "accountMessage": "Already have an account?",
          "logMessage": "Don't have an account yet?",
          "bottomBar1": "Main",
          "bottomBar2": "Current data",
          "bottomBar3": "Measurement",
          "bottomBar4": "Settings",
          "bottomBar5": "Profile",
          "secondAppBar": "Current measurements",
          "tempValue1": "Temperature 1.",
          "tempValue2": "Temperature 2.",
          "humValue": "Humidity",
          "tempChart": "Temperature graph",
          "last15": "Last 15 measurements",
          "humChart": "Humidity graph",
          "thirdAppBar": "Set parameters",
          "measurementTime": "Measurement time [min]",
          "sleepTime": "Sleep time [s]",
          "tag": "Tag",
          "fileName": "File name",
          "startButton": "Start measurement",
          "alertDialog": "Notification",
          "alertMessage": "uzupełnić....",
          "alertButton": "OK",
          "errorDialog": "Error",
          "errorMessage": "No data to measure",
          "timeBattery": "The battery in the device will last for:",
          "maxTimeBattery":
              "The maximum operating time of the device\nwhen the battery is fully charged:",
          "batteryMessage":
              "Battery usage data isapproximate and can change based on usage",
          "sixthAppBar": "View available files",
          "timeDevice": "Time on a measuring device",
          "timeError": "No date information",
          "checkDate": "Check the date and time on the device",
          "askTime": "Inquiry time",
          "deviceTime": "Time on the device",
          "sendTime": "Send the current time to the device",
          "memorySize": "Total memory",
          "usedMemory": "Memory usage",
          "freeMemory": "Free memory",
          "appBarProfile": "My profile",
          "addPic": "Add a profile picture",
          "changePic": "Change your profile photo",
          "manage": "Manage",
          "newPassword": "New password",
          "repeatNewPassword": "Repeat new password",
          "changePassowrd": "Change password",
          "logoutButton": "Log out",
          "language": "Language",
          "polish": "Polski",
          "english": "English",
          "darkMode": "Dark mode",
          "darkTurnOn": "Enabled",
          "darkTurnOff": "Disabled",
          "units": "Units",
          "cel": "Celsius",
          "fah": "Fahrenheit"
        },
        'pl_PL': {
          "unknownDevice": "Nieznane urządzenie",
          "connectDevice": "Połącz",
          "alreadyConnected": "Już połączono",
          "firstAppBar": "TemplyCare",
          "buttonText1": "Podgląd danych",
          "buttonText2": "Wykonaj pomiar",
          "buttonText3": "Stan baterii",
          "buttonText4": "Stan karty pamięci",
          "buttonText5": "Podgląd plików",
          "buttonText6": "Czas na urządzeniu",
          "bleTitle": "Bluetooth jest wyłączony!",
          "bleMessage":
              "Aby korzystać z aplikacji włącz Bluetooth na swoim urządzeniu",
          "bleClose": "Zamknij aplikację",
          "bleOn": "Włącz Bluetooth",
          "deviceConnect": "Połącz się z urządzeniem",
          "wifiTitle": "Dane Wi-Fi",
          "wifiSSID": "Wi-Fi SSID (nazwa Wi-Fi)",
          "wifiPassword": "Hasło do Wi-Fi",
          "writeWifiData": "Zapisz i wyślij",
          "wifiText":
              "Aby skonfigurować połączenie z Twoją siecią Wi-Fi, wprowadź powyżej nazwę SSID (nazwę sieci) oraz hasło. Te informacje zostaną wysłane do urządzenia Arduino, aby umożliwić przesyłanie danych z urządzenia do bazy danych InfluxDB.",
          "logIn": "Zaloguj się",
          "signIn": "Zarejestruj się",
          "registration": "Rejestracja",
          "log": "Logowanie",
          "password": "Hasło",
          "repeatPassword": "Powtórz hasło",
          "accountMessage": "Masz już konto?",
          "logMessage": "Nie masz jeszcze konta?",
          "bottomBar1": "Główna",
          "bottomBar2": "Aktualności",
          "bottomBar3": "Pomiar",
          "bottomBar4": "Ustawienia",
          "bottomBar5": "Profil",
          "secondAppBar": "Aktualne pomiary",
          "tempValue1": "Temperatura 1.",
          "tempValue2": "Temperatura 2.",
          "humValue": "Wilgotność",
          "tempChart": "Wykres temperatur",
          "last15": "Ostatnie 15 pomiarów",
          "humChart": "Wykres wilgotności",
          "thirdAppBar": "Ustaw parametry",
          "measurementTime": "Czas pomiaru [min]",
          "sleepTime": "Czas uśpienia [s]",
          "tag": "Tag",
          "fileName": "Nazwa pliku",
          "startButton": "Uruchom pomiar",
          "alertDialog": "Powiadomienie",
          "alertMessage": "uzupełnić....",
          "alertButton": "OK",
          "errorDialog": "Błąd",
          "errorMessage": "Brak danych do pomiaru",
          "timeBattery": "Baterii w urządzeniu wystarczy na:",
          "maxTimeBattery":
              "Maksymalny czas pracy urządzenia\nprzy pełnym naładowaniu baterii:",
          "batteryMessage":
              "Dane o wykorzystaniu baterii są przybliżone i mogą się zmienić w zależności od sposobu używania urządzenia",
          "sixthAppBar": "Wyświetl dostępne pliki",
          "timeDevice": "Czas na urządzeniu pomiarowym",
          "timeError": "Brak informacji o dacie",
          "checkDate": "Sprawdź datę i czas na urządzeniu",
          "askTime": "Czas zapytania",
          "deviceTime": "Czas na urządzeniu",
          "sendTime": "Wyślij aktualny czas do urządzenia",
          "memorySize": "Pamięć całkowita:",
          "usedMemory": "Pamięć zajęta:",
          "freeMemory": "Wolna pamięć:",
          "appBarProfile": "Mój profil",
          "addPic": "Dodaj zdjęcie profilowe",
          "changePic": "Zmień zdjęcie profilowe",
          "manage": "Zarządzaj",
          "newPassword": "Nowe hasło",
          "repeatNewPassword": "Powtórz nowe hasło",
          "changePassowrd": "Zmień hasło",
          "logoutButton": "Wyloguj się",
          "language": "Język",
          "polish": "Polski",
          "english": "English",
          "darkMode": "Tryb ciemny",
          "darkTurnOn": "Włączony",
          "darkTurnOff": "Wyłączony",
          "units": "Jednostki",
          "cel": "Celsjusz",
          "fah": "Fahrenheit"
        }
      };
}
