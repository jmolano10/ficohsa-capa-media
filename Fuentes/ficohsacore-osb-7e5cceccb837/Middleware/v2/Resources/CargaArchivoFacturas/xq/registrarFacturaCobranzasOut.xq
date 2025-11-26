(:: pragma bea:global-element-parameter parameter="$cargaArchivoFacturas1" element="ns1:cargaArchivoFacturas" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABK/registrarFacturaCobranzas/xsd/registrarFacturaCobranzas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cargaArchivoFacturasResponse" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarFacturaCobranzas";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargaArchivoFacturas/xq/registrarFacturaCobranzasOut/";

declare function xf:registrarFacturaCobranzasOut($cargaArchivoFacturas1 as element(ns1:cargaArchivoFacturas),
    $outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:cargaArchivoFacturasResponse) {
        <ns1:cargaArchivoFacturasResponse>
            <CUSTOMER_ID>{ data($cargaArchivoFacturas1/CUSTOMER_ID) }</CUSTOMER_ID>
            <CONTRACT_ID>{ data($cargaArchivoFacturas1/CONTRACT_ID) }</CONTRACT_ID>
            <AUTH_ALLOWED>NO</AUTH_ALLOWED>
            <BILLS>
                {
                    for $ERROR_ROW at $i in $outputParameters1/ns0:PT_ERRORES/ns0:ERROR_ROW
                    return
                        <BILL>
                            <BILL_NUMBER>{ $i }</BILL_NUMBER>
                            <MESSAGES>
                                {
                                    for $ITEM in $ERROR_ROW/ns0:ITEM
                                    return
                                        <MESSAGE>{ data($ITEM) }</MESSAGE>
                                }
                            </MESSAGES>
                        </BILL>
                }
            </BILLS>
        </ns1:cargaArchivoFacturasResponse>
};

declare variable $cargaArchivoFacturas1 as element(ns1:cargaArchivoFacturas) external;
declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:registrarFacturaCobranzasOut($cargaArchivoFacturas1,
    $outputParameters1)