* Contenedor oApp

DEFINE CLASS App AS CUSTOM
   oCategoria_bll = .NULL.
   
   *Constructor
   PROCEDURE Init
      THIS.oCategoria_bll = NEWOBJECT( "Categoria_bll", "Categoria_bll.prg" )
   ENDPROC

ENDDEFINE