(:: pragma bea:global-element-parameter parameter="$DatosEntradaCliente" element="ns1:InputParameters" location="../../../BusinessServices/RegistraClienteTSPDB/xsd/TSP_CREA_CLIENTE_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$DatosSalidaCliente" element="ns1:OutputParameters" location="../../../BusinessServices/RegistraClienteTSPDB/xsd/TSP_CREA_CLIENTE_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/InsertaBitacoraTSPDB/xsd/T24InsertBitacoraTSPDB_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/TSP_CREA_CLIENTE";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/T24InsertBitacoraTSPDB";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/RegistraCliente/xq/registraBitacoraIN/";

declare variable $cadena :='';
declare function xf:registraBitacoraIN($DatosEntradaCliente as element(ns1:InputParameters),
    $DatosSalidaCliente as element(ns1:OutputParameters))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
          
            <ns0:PV_EVENTO>T24NewCustomer</ns0:PV_EVENTO>
            {
                for $PV_ID_CLIENTE in $DatosEntradaCliente/ns1:PV_ID_CLIENTE
                return
                    <ns0:PV_ID_CLIENTE>{ data($PV_ID_CLIENTE) }</ns0:PV_ID_CLIENTE>
            }
            {
              
                for $PV_SECTOR in $DatosEntradaCliente/ns1:PV_SECTOR,
                    $PV_IDENTIFICACION in $DatosEntradaCliente/ns1:PV_IDENTIFICACION,
                    $PV_TIPO_IDENTIFICACION in $DatosEntradaCliente/ns1:PV_TIPO_IDENTIFICACION,
                    $PV_NOMBRES in $DatosEntradaCliente/ns1:PV_NOMBRES,
                    $PV_APELLIDOS in $DatosEntradaCliente/ns1:PV_APELLIDOS,
                    $PV_NOMBRE_LEGAL in $DatosEntradaCliente/ns1:PV_NOMBRE_LEGAL,
                    $PV_NOMBRE_COMERCIAL in $DatosEntradaCliente/ns1:PV_NOMBRE_COMERCIAL
                    
                return
				if (string-length($PV_SECTOR)= 0)then ($cadena = "SECTOR NULL")
				else  if (string-length($DatosEntradaCliente/ns1:PV_IDENTIFICACION) = 0) then ($cadena = "ID NULL")
				else if (string-length($DatosEntradaCliente/ns1:PV_TIPO_IDENTIFICACION)!= 0) then ($cadena = "TIPO ID NULL")
				else if (string-length($DatosEntradaCliente/ns1:PV_NOMBRES)!= 0) then ($cadena = "NOMBRES NULL")
				else if (string-length($DatosEntradaCliente/ns1:PV_APELLIDOS)!= 0) then ($cadena = "APELLIDOS NULL")
				else if (string-length($DatosEntradaCliente/ns1:PV_NOMBRE_LEGAL)!= 0) then ($cadena = "NOMBRE LEGAL NULL")
				else if (string-length($DatosEntradaCliente/ns1:PV_NOMBRE_COMERCIAL)!= 0) then ($cadena = "NOMBRE COMERCIAL NULL")
				else <ns0:PV_DATOS>{ concat($PV_SECTOR," - " , $PV_IDENTIFICACION," - " , $PV_TIPO_IDENTIFICACION," - " , $PV_NOMBRES," - " , $PV_APELLIDOS," - " , $PV_NOMBRE_LEGAL," - " , $PV_NOMBRE_COMERCIAL) }</ns0:PV_DATOS>                                            
                   
            }
            {
                for $PV_COD_RSPTA in $DatosSalidaCliente/ns1:PV_COD_RSPTA
                return
                    <ns0:PV_SUSSCES_INDICADOR>{ data($PV_COD_RSPTA) }</ns0:PV_SUSSCES_INDICADOR>
            }
            {
                for $PV_DES_RSPTA in $DatosSalidaCliente/ns1:PV_DES_RSPTA
                return
                    <ns0:PV_MENSAJE>{ data($PV_DES_RSPTA) }</ns0:PV_MENSAJE>
            }
        </ns0:InputParameters>
};

declare variable $DatosEntradaCliente as element(ns1:InputParameters) external;
declare variable $DatosSalidaCliente as element(ns1:OutputParameters) external;

xf:registraBitacoraIN($DatosEntradaCliente,
    $DatosSalidaCliente)
