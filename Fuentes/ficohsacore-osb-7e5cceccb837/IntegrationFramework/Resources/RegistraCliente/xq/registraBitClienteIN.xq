(:: pragma bea:global-element-parameter parameter="$EntradaCliente" element="ns1:InputParameters" location="../../../BusinessServices/RegistraClienteTSPDB/xsd/TSP_CREA_CLIENTE_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$SalidaCliente" element="ns1:OutputParameters" location="../../../BusinessServices/RegistraClienteTSPDB/xsd/TSP_CREA_CLIENTE_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/InsertaBitacoraTSPDB/xsd/T24InsertBitacoraTSPDB_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/TSP_CREA_CLIENTE";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/T24InsertBitacoraTSPDB";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/RegistraCliente/xq/registraBitClienteIN/";

declare function xf:registraBitClienteIN($EntradaCliente as element(ns1:InputParameters),
    $SalidaCliente as element(ns1:OutputParameters))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_EVENTO>T24NewCustomer</ns0:PV_EVENTO>
            {
                for $PV_ID_CLIENTE in $EntradaCliente/ns1:PV_ID_CLIENTE
                return
                    <ns0:PV_ID_CLIENTE>{ data($PV_ID_CLIENTE) }</ns0:PV_ID_CLIENTE>
            }
            {
                for $PV_SECTOR in $EntradaCliente/ns1:PV_SECTOR,
                    $PV_IDENTIFICACION in $EntradaCliente/ns1:PV_IDENTIFICACION,
                    $PV_TIPO_IDENTIFICACION in $EntradaCliente/ns1:PV_TIPO_IDENTIFICACION,
                    $PV_NOMBRES in $EntradaCliente/ns1:PV_NOMBRES,
                    $PV_APELLIDOS in $EntradaCliente/ns1:PV_APELLIDOS,
                    $PV_NOMBRE_LEGAL in $EntradaCliente/ns1:PV_NOMBRE_LEGAL,
                    $PV_NOMBRE_COMERCIAL in $EntradaCliente/ns1:PV_NOMBRE_COMERCIAL
                return
                    <ns0:PV_DATOS>{ concat(($PV_SECTOR/text(),"")[1]," - " , ($PV_IDENTIFICACION/text(),"")[1]," - " , ($PV_TIPO_IDENTIFICACION/text(),"")[1]," - " , ($PV_NOMBRES/text(),"")[1]," - " , ($PV_APELLIDOS/text(),"")[1]," - " , ($PV_NOMBRE_LEGAL/text(),"")[1]," - " , ($PV_NOMBRE_COMERCIAL/text(),"")[1]) }</ns0:PV_DATOS>
            }
            {
                for $PV_COD_RSPTA in $SalidaCliente/ns1:PV_COD_RSPTA
                return
                    <ns0:PV_SUSSCES_INDICADOR>{ data($PV_COD_RSPTA) }</ns0:PV_SUSSCES_INDICADOR>
            }
            {
                for $PV_DES_RSPTA in $SalidaCliente/ns1:PV_DES_RSPTA
                return
                    <ns0:PV_MENSAJE>{ data($PV_DES_RSPTA) }</ns0:PV_MENSAJE>
            }
        </ns0:InputParameters>
};

declare variable $EntradaCliente as element(ns1:InputParameters) external;
declare variable $SalidaCliente as element(ns1:OutputParameters) external;

xf:registraBitClienteIN($EntradaCliente,
    $SalidaCliente)