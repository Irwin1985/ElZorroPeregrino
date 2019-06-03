* Clase Categoria_DAL

DEFINE CLASS Categoria_dal AS Base_layer
   oRest = .NULL.
   oJson = .NULL.
   oCat  = .NULL.
   
   * Constructor
   PROCEDURE Init
      #DEFINE HTTP_OK	    200
	  #DEFINE HTTP_CREATED	201
      #DEFINE URL_READ  	"http://LocalHost/MiPrimeraAPI/api/categoria/read.php"
	  #DEFINE URL_POST  	"http://LocalHost/MiPrimeraApi/api/categoria/create.php"
	  #DEFINE URL_PUT		"http://LocalHost/MiPrimeraApi/api/categoria/update.php"
   ENDPROC

   * Mapear el CRUD
   FUNCTION Read
      LOCAL cXML AS Memo

      cXML = ""
      
      THIS.__Create_instance()
      THIS.oRest.AddRequest( "GET", URL_READ )           
      
      IF THIS.Error_Continue( THIS.oRest.LastErrorText )
         THIS.oRest.SEND()
         
         IF THIS.Error_Continue( THIS.oRest.LastErrorText )
            IF THIS.oRest.STATUS == HTTP_OK
               THIS.oCat = THIS.oJson.decode( THIS.oRest.Response )

               IF THIS.Error_Continue( THIS.oJson.LastErrorText )
                  cXML = THIS.oJson.ArrayToXml( THIS.oCat._data )

                  IF !THIS.Error_Continue( THIS.oJson.LastErrorText )
                     THIS.LastErrorText = THIS.oJson.LastErrorText
                  ELSE && THIS.Error_Continue( THIS.oJson.LastErrorText )
                  ENDIF && THIS.Error_Continue( THIS.oJson.LastErrorText )
               ELSE
                  THIS.LastErrorText = THIS.oJson.LastErrorText
               ENDIF && THIS.Error_Continue( THIS.oJson.LastErrorText )
            ELSE && THIS.oRest.STATUS == HTTP_OK
               THIS.LastErrorText = "internal error: " + ALLTRIM( STR( THIS.oRest.STATUS ) ) + " | message: " + THIS.oRest.StatusText
            ENDIF && THIS.oRest.STATUS == HTTP_OK
         ELSE
            THIS.LastErrorText = THIS.oRest.LastErrorText
         ENDIF &&THIS.Error_Continue( THIS.oRest.LastErrorText )
      ELSE
         THIS.LastErrorText = THIS.oRest.LastErrorText
      ENDIF && THIS.Error_Continue()
      
      THIS.__Destroy_object()
      
      RETURN cXML
   ENDFUNC

   PROCEDURE Create
	  LPARAMETERS tcXML
	  LOCAL cJson AS Memo, cError AS String

	  THIS.__create_instance()

	  cJson  = THIS.oJson.XmlToJson( tcXML )
	  cError = ""
	 
	  IF EMPTY( THIS.oJson.LastErrorText )
	     THIS.oRest.AddRequest( "POST", URL_POST )

		 IF EMPTY( THIS.oRest.LastErrorText )
		    THIS.oRest.AddHeader( "Content-Type", "application/json" )
			
			IF EMPTY( THIS.oRest.LastErrorText )
			   THIS.oRest.AddRequestBody( cJson )

			   IF EMPTY( THIS.oRest.LastErrorText )
				  THIS.oRest.SEND()

				  IF EMPTY( THIS.oRest.LastErrorText )
				     IF THIS.oRest.STATUS == HTTP_CREATED
                        * 1. Obtener el ID
					 ELSE &&THIS.oRest.STATUS == HTTP_CREATED
					    cError = "ADVERTENCIA: " + THIS.oRest.ResponseText
					 ENDIF &&THIS.oRest.STATUS == HTTP_CREATED
				  ELSE &&EMPTY( THIS.oRest.LastErrorText )
				     cError = THIS.oRest.LastErrorText
				  ENDIF &&EMPTY( THIS.oRest.LastErrorText )
				ELSE &&EMPTY(THIS.oRest.LastErrorText)
					cError = THIS.oRest.LastErrorText
				ENDIF &&EMPTY( THIS.oRest.LastErrorText )
			ELSE &&EMPTY(THIS.oRest.LastErrorText)
				cError = THIS.oRest.LastErrorText
			ENDIF &&EMPTY( THIS.oRest.LastErrorText )
		 ELSE &&EMPTY( THIS.oRest.LastErrorText )
		    cError = THIS.oRest.LastErrorText
		 ENDIF &&EMPTY( THIS.oRest.LastErrorText )
	  ELSE &&EMPTY( THIS.oJson.LastErrorText )
	     cError	= THIS.oJson.LastErrorText
	  ENDIF &&EMPTY( THIS.oJson.LastErrorText )

	  THIS.LastErrorText = cError
   ENDPROC
   
   PROCEDURE UPDATE
	  LPARAMETERS tcXML
	  LOCAL cJson AS Memo, cError AS String

	  cJson  = ""
	  cError = ""

	  THIS.__create_instance()

	  cJson = THIS.oJson.XmlToJson( tcXML )

	  IF EMPTY( THIS.oJson.LastErrorText )
		 THIS.oRest.AddRequest( "POST", URL_PUT )

		 IF EMPTY(THIS.oRest.LastErrorText)
			THIS.oRest.AddHeader( "Content-Type", "application/json" )

			IF EMPTY( THIS.oRest.LastErrorText )
		       THIS.oRest.AddRequestBody( cJson )

			   IF EMPTY( THIS.oRest.LastErrorText )
			      THIS.oRest.SEND()

				  IF EMPTY(THIS.oRest.LastErrorText)
					 IF THIS.oRest.STATUS <> HTTP_OK
						cError = "ADVERTENCIA: " + THIS.oRest.ResponseText
					 ELSE &&THIS.oRest.STATUS <> HTTP_OK
					 ENDIF &&THIS.oRest.STATUS <> HTTP_OK
				  ELSE &&EMPTY( THIS.oRest.LastErrorText )
					 cError = THIS.oRest.LastErrorText
				  ENDIF && EMPTY( THIS.oRest.LastErrorText )
			   ELSE && EMPTY( THIS.oRest.LastErrorText )
			      cError = THIS.oRest.LastErrorText
			   ENDIF &&EMPTY(THIS.oRest.LastErrorText)
			ELSE &&EMPTY(THIS.oRest.LastErrorText)
				cError = THIS.oRest.LastErrorText
			ENDIF &&EMPTY(THIS.oRest.LastErrorText)
	     ELSE &&EMPTY(THIS.oRest.LastErrorText)
		    cError = THIS.oRest.LastErrorText
	     ENDIF &&EMPTY(THIS.oRest.LastErrorText)
	  ELSE &&EMPTY(THIS.oJson.LastErrorText)
	     cError = THIS.oJson.LastErrorText
	  ENDIF &&EMPTY(THIS.oJson.LastErrorText)

	  THIS.LastErrorText = cError
   ENDPROC

   HIDDEN PROCEDURE __Create_instance
      THIS.oRest = NEWOBJECT( "Rest", "vfpRestClient.prg" )
      THIS.oJson = NEWOBJECT( "jSonFox", "jSonFox.prg" )
   ENDPROC
   
   HIDDEN PROCEDURE __Destroy_object
      THIS.oRest = .NULL.
      THIS.oJson = .NULL.
   ENDPROC
ENDDEFINE