* Clase Categoria BLL
DEFINE CLASS Categoria_bll AS Base_layer
   * Mapear las columnas de la tabla
   id          = 0
   codigo      = ""
   descripcion = ""
   
   * Propiedad DAL
   oCategoria_dal = .NULL.
   
   *Constructor
   PROCEDURE Init
      THIS.oCategoria_dal = NEWOBJECT( "Categoria_dal", "Categoria_dal.prg" )
   ENDPROC

   * Valida los datos de entrada
   PROCEDURE Valida_Datos
	  LPARAMETERS tcXML

	  =XMLTOCURSOR(tcXML, "qCategoria")

	  IF USED("qCategoria")
		 DO CASE
		    CASE EMPTY(qCategoria.codigo)
		       THIS.LastErrorText = "Falta código de la categoria"
		    CASE EMPTY(qCategoria.descripcion)
			   THIS.LastErrorText = "Falta descripción de la categoria"
		    OTHERWISE
	     ENDCASE
	  ELSE &&USED("qCategoria")
	     THIS.LastErrorText = "No se pudo serializar el cursor"
	  ENDIF &&USED("qCategoria")
   ENDPROC   

   * Mapear los métodos
   FUNCTION Read
      LOCAL cXML AS Memo
      
      cXML = THIS.oCategoria_dal.READ()

      THIS.LastErrorText = THIS.oCategoria_dal.LastErrorText
      
      RETURN cXML
   ENDFUNC

   * Crea un registro de la tabla categoria.
   PROCEDURE Create
      LPARAMETERS tcXML

      THIS.oCategoria_dal.CREATE( tcXML )

      THIS.LastErrorText = THIS.oCategoria_dal.LastErrorText
   ENDPROC

   * Edita un registro de la tabla categoria.
   PROCEDURE UPDATE
	  LPARAMETERS tcXML

	  THIS.oCategoria_dal.UPDATE( tcXML )

	  THIS.LastErrorText = THIS.oCategoria_dal.LastErrorText
   ENDPROC
ENDDEFINE