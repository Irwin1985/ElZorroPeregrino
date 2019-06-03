** Archivo Principal

** Entorno del Sistema
CLOSE DATABASES ALL
CLEAR ALL

SET CENTURY ON
SET COLLATE TO "GENERAL"
SET DATE DMY
SET DELETED ON
SET EXCLUSIVE OFF
SET HOURS TO 24
SET SAFETY OFF
SET TALK OFF
SET TABLEPROMPT OFF

cRutaOrigen    = "\Ezp"
cRutaImagen    = "\imagen"
cRutaSource    = "\scr"
cRutaFormas    = "\scr\scx"
cRutaProgramas = "\scr\prg"

cRutaSistema   = cRutaOrigen + ";" +;
                 cRutaOrigen + cRutaImagen + ";" +;
                 cRutaOrigen + cRutaSource + ";" +;
                 cRutaOrigen + cRutaFormas + ";" +;
                 cRutaOrigen + cRutaProgramas + ";"

SET PATH TO ( cRutaSistema ) ADDITIVE

SET PROCEDURE TO "App" ADDITIVE
SET PROCEDURE TO "Base_layer" ADDITIVE

_screen.Caption = "El Zorro Peregrino"

CD ( JUSTPATH( SYS( 16 ) ) )     && Main.prg
 
* Contenedor oApp
IF TYPE( "oApp" ) = "U"
   PUBLIC oApp AS Object
   
   oApp = NEWOBJECT( "App", "App.prg" )
ENDIF && TYPE( "oApp" ) = "U"

DO FORM Main
READ EVENT

RELEASE ALL
CLOSE ALL
CLEAR ALL

IF _Vfp.StartMode <= 1           && Debug MODE
   _screen.Caption = "Microsoft Visual Foxpro"
   
   RETURN
ENDIF

QUIT




