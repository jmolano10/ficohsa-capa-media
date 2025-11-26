(:: pragma bea:global-element-parameter parameter="$creaciondeClienteSimplificadoResponseIN" element="ns1:CreaciondeClienteSimplificadoResponse" location="../../../BusinessServices/T24/CrearClienteSimplificado/xsd/XMLSchema_1252959786.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CreaClienteSimplificadoResponse" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CrearClienteSimplificadoHN/crearClienteSimplificadoHNOUT/";

declare function xf:crearClienteSimplificadoHNOUT($creaciondeClienteSimplificadoResponseIN as element(ns1:CreaciondeClienteSimplificadoResponse))
    as element(ns0:CreaClienteSimplificadoResponse) {
        <ns0:CreaClienteSimplificadoResponse>
            {
                for $id in $creaciondeClienteSimplificadoResponseIN/CUSTOMERType/@id
                return
                    <COSTUMER_ID>{ data($id) }</COSTUMER_ID>
            }
            <ADDRESS_INFO>
                {
                    for $mADDRESS.TYPE in $creaciondeClienteSimplificadoResponseIN/CUSTOMERType/gADDRESS.TYPE/mADDRESS.TYPE
                    return
                        <ADDRESS_ITEM>
                            {
                                for $ADDRESSTYPE in $mADDRESS.TYPE/ADDRESSTYPE
                                return
                                    <ADDRESS_TYPE>{ data($ADDRESSTYPE) }</ADDRESS_TYPE>
                            }
                            {
                                for $COMPLETEADDRES in $mADDRESS.TYPE/COMPLETEADDRES
                                return
                                    <ADDRESS_LINE_1>{ data($COMPLETEADDRES) }</ADDRESS_LINE_1>
                            }
                            {
                                for $COMPLETADDRESS in $mADDRESS.TYPE/COMPLETADDRESS
                                return
                                    <ADDRESS_LINE_2>{ data($COMPLETADDRESS) }</ADDRESS_LINE_2>
                            }
                            {
                                for $MAINADPHYCOR in $mADDRESS.TYPE/MAINADPHYCOR
                                return
                                    <IS_MAIN_ADDRESS>{ data($MAINADPHYCOR) }</IS_MAIN_ADDRESS>
                            }
                        </ADDRESS_ITEM>
                }
            </ADDRESS_INFO>
        </ns0:CreaClienteSimplificadoResponse>
};

declare variable $creaciondeClienteSimplificadoResponseIN as element(ns1:CreaciondeClienteSimplificadoResponse) external;

xf:crearClienteSimplificadoHNOUT($creaciondeClienteSimplificadoResponseIN)
