CREATE OR REPLACE PROCEDURE MIDDLEWARE.MW_P_VALIDA_CORBAN (  Pv_CODIGO_CORRESPONSAL  IN  VARCHAR2,
                                                       Pv_CODIGO_PAIS                IN VARCHAR2,
                                                       Pv_CODIGO_TRANSACCION         IN VARCHAR2,
                                                       Pv_CUENTA_CREDITO            OUT VARCHAR2,
                                                       Pv_CUENTA_DEBITO             OUT VARCHAR2,
                                                       Pv_MONEDA_PERMITIDA          OUT VARCHAR2,
                                                       Pv_TIPO_TRANSACCION          OUT VARCHAR2,
                                                       Pv_MONTO_COMISION            OUT VARCHAR2,
                                                       Pv_MONEDA_COMISION           OUT VARCHAR2,
                                                       Pv_TIPO_TRANSACCION_COMISION OUT VARCHAR2,
                                                       Pv_CUENTA_COMISION           OUT VARCHAR2,
                                                       Pv_CODIGO_MENSAJE            OUT VARCHAR2,
                                                       Pv_MENSAJE_ERROR             OUT VARCHAR2
                                                       ) AS
/******************************************************************************
   NAME:       MW_P_VALIDA_CORBAN
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        05/08/2016   cjmenjivar       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     MW_P_VALIDA_CORBAN
      Sysdate:         08/08/2016
      Date and Time:   08/08/2016, 08:14:34 a.m., and 08/08/2016 08:14:34 a.m.
      Username:        cjmenjivar (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
Lv_CODIGO_CORRESPONSAL  MW_CORRESPONSALES_BANCARIOS.CODIGO_CORRESPONSAL%TYPE;
Lv_CODIGO_PAIS          MW_CORRESPONSALES_BANCARIOS.CODIGO_PAIS%TYPE;
Lv_TIPO_TRANSACCION     MW_TRANSACCIONES_CORBAN.TIPO_TRANSACCION%TYPE;

BEGIN
        
      
      Lv_CODIGO_CORRESPONSAL:= Pv_CODIGO_CORRESPONSAL;
      Lv_CODIGO_PAIS:= Pv_CODIGO_PAIS;
      
      IF Lv_CODIGO_CORRESPONSAL IS NULL THEN
               Pv_CODIGO_MENSAJE:= 'ERROR';
               Pv_MENSAJE_ERROR:= 'ERROR EN OBTENIENDO PARAMETRO DE ENTRADA CORRESPONSAL. ' || SQLERRM;
               RETURN; 
      END IF;
      
       IF Lv_CODIGO_PAIS IS NULL THEN
               Pv_CODIGO_MENSAJE:= 'ERROR';
               Pv_MENSAJE_ERROR:= 'ERROR EN OBTENIENDO PARAMETRO DE ENTRADA CODIGO_PAIS. ' || SQLERRM;
               RETURN; 
      END IF;
      
      BEGIN
            SELECT CUENTA_CREDITO, CUENTA_DEBITO, MONEDA_PERMITIDA,CUENTA_COMISION
            INTO   Pv_CUENTA_CREDITO,
                   Pv_CUENTA_DEBITO,  
                   Pv_MONEDA_PERMITIDA,
                   Pv_CUENTA_COMISION
            FROM MW_CORRESPONSALES_BANCARIOS
            WHERE CODIGO_CORRESPONSAL = Lv_CODIGO_CORRESPONSAL
            AND CODIGO_PAIS = Lv_CODIGO_PAIS
            AND ESTADO = 'A';
            
            Pv_CODIGO_MENSAJE:= 'SUCCESS';
            Pv_MENSAJE_ERROR:= 'EXITO EN TRANSACCION.';
      
      EXCEPTION 
            WHEN OTHERS THEN
               Pv_CODIGO_MENSAJE:= 'ERROR';
               Pv_MENSAJE_ERROR:= 'ERROR NO SE ENCONTRO EL CORRESPONSAL O ESTA INACTIVO. ' || SQLERRM;
               RETURN; 
      END;
      
      BEGIN 
            SELECT TIPO_TRANSACCION, MONTO_COMISION, MONEDA_COMISION, TIPO_TRANSACCION_COMISION
            INTO Pv_TIPO_TRANSACCION, Pv_MONTO_COMISION, Pv_MONEDA_COMISION, Pv_TIPO_TRANSACCION_COMISION
            FROM MW_TRANSACCIONES_CORBAN
            WHERE CODIGO_CORRESPONSAL = Lv_CODIGO_CORRESPONSAL
            AND CODIGO_PAIS = Lv_CODIGO_PAIS
            AND CODIGO_TRANSACCION = Pv_CODIGO_TRANSACCION
            AND ESTADO = 'A';
            
      EXCEPTION 
            WHEN OTHERS THEN
               Pv_CODIGO_MENSAJE:= 'ERROR';
               Pv_MENSAJE_ERROR:= 'ERROR NO SE ENCONTRO LA TRANSACCION O ESTA INACTIVA. ' || SQLERRM;
               RETURN; 
      END;
   
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
                Pv_CODIGO_MENSAJE:= 'ERROR';
                Pv_MENSAJE_ERROR:= 'ERROR GENERAL_3 MW_REGISTRAR_TRANS_CORBAN. ' || SQLERRM;
                RETURN;
     WHEN OTHERS THEN
                Pv_CODIGO_MENSAJE:= 'ERROR';
                Pv_MENSAJE_ERROR:= 'ERROR GENERAL_4 MW_REGISTRAR_TRANS_CORBAN. ' || SQLERRM;
                RETURN;
END MW_P_VALIDA_CORBAN;