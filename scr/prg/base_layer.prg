** Clase Base Layer

DEFINE CLASS Base_layer AS CUSTOM
   LastErrorText = ""
   
   * Read
   FUNCTION Read AS MEMO HELPSTRING "Devuelve el XML de todas las categoria"
      **TODO
   ENDFUNC
   
   * ReadOne
   FUNCTION ReadOne AS MEMO HELPSTRING "Devuelve el XML de una fila de la tabla categoria"
      LPARAMETERS tnId
   ENDFUNC
   
   * Create
   PROCEDURE Create HELPSTRING "Crea una fila en la tabla categoria"
      LPARAMETERS tcXML
   ENDPROC
   
   * Update
   PROCEDURE Update HELPSTRING "Actualizar una fila en la tabla categoria"
      LPARAMETERS tcXML
   ENDPROC
   
   * Delete
   PROCEDURE Delete HELPSTRING "Elimina una fila en la tabla categoria"
      LPARAMETERS tnId
   ENDPROC   
   
   * Getter
   FUNCTION LastErrorText_Access
      RETURN THIS.LastErrorText
   ENDFUNC
   
   * Setter
   PROCEDURE LastErrorText_Assign
      LPARAMETERS vNewVal

      LastErrorText = m.vNewVal
   ENDPROC
   
   *
   FUNCTION Error_Continue 
      LPARAMETERS tcError AS String
      
      lContinue = .T.
       
      IF !EMPTY( tcError )
         lContinue     = .F.
         LastErrorText = tcError
      ELSE && !EMPTY( tcError )
      ENDIF && !EMPTY( tcError )
      
      RETURN lContinue
   ENDFUNC    
ENDDEFINE