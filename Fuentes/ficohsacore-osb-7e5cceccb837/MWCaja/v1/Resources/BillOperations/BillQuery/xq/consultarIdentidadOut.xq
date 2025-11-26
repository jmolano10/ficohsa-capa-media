(:: pragma bea:global-element-parameter parameter="$consultar_identidadResponse" element="ns0:consultar_identidadResponse" location="../../../../BusinessServices/SegurosGT/PagoSeguro/wsdl/pagoBancoPS.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:billQueryResponse" location="../../xsd/BillOperationsTypes.xsd" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/billOperationsTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/BillOperations/BillQuery/xq/consultarIdentidadOut/";

declare function xf:consultarIdentidadOut($consultar_identidadResponse as element(ns0:consultar_identidadResponse),
    $contractID as xs:string,
    $contractName as xs:string,
    $tipoConvenio as xs:string)
    as element(ns1:billQueryResponse) {
        <ns1:billQueryResponse>
            <ns1:CONTRACT_ID>{ data($contractID) }</ns1:CONTRACT_ID>
            <ns1:CONTRACT_NAME>{ data($contractName) }</ns1:CONTRACT_NAME>
            <ns1:DEBTOR_CODE>{ data($tipoConvenio) }</ns1:DEBTOR_CODE>
            <ns1:DEBTOR_NAME>{ data($consultar_identidadResponse/ns0:consultar_identidadResult/ns0:consulta_cliente[1]/ns0:detalle_poliza/ns0:det_poliza[1]/ns0:contratante) }</ns1:DEBTOR_NAME>
            <ns1:BILLS>
            {
                    for $detallePoliza in $consultar_identidadResponse/ns0:consultar_identidadResult/ns0:consulta_cliente[1]/ns0:detalle_poliza/ns0:det_poliza
                    return                    
                <ns1:BILL>
                    <ns1:ID>{ data($detallePoliza/ns0:poliza) }</ns1:ID>
                    <ns1:DESCRIPTION>{ concat( "PRODUCTO ", data($detallePoliza/ns0:producto), " CUOTA ",  data($detallePoliza/ns0:datos_poliza)) }</ns1:DESCRIPTION>
                    <ns1:CURRENCY>
                           { 
                               if(data($detallePoliza/ns0:moneda) = 'Q') then(
                                   'GTQ'
                                   )elseif(data($detallePoliza/ns0:moneda) = 'US') then(
                                    'USD'
                                    )else()                  
                            }
                    </ns1:CURRENCY>
                    <ns1:ISSUE_DATE>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn-bea:date-from-string-with-format("dd/MM/yyyy",substring(data($detallePoliza/ns0:vigencia),1,11))) }</ns1:ISSUE_DATE>
                    <ns1:DUE_DATE>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn-bea:date-from-string-with-format("dd/MM/yyyy",substring(data($detallePoliza/ns0:vigencia),12,21))) }</ns1:DUE_DATE>
                    <ns1:BILL_AMOUNT>0</ns1:BILL_AMOUNT>
                    <ns1:LATE_FEE>0</ns1:LATE_FEE>
                    <ns1:TOTAL_AMOUNT>0</ns1:TOTAL_AMOUNT>
                    <ns1:EXTRA_INFO>
                        <ns2:PAIR>
                            <ns2:KEY>PRODUCT_TYPE</ns2:KEY>
                            <ns2:VALUE>{ data($detallePoliza/ns0:producto) }</ns2:VALUE>
                        </ns2:PAIR>
                    </ns1:EXTRA_INFO>
                </ns1:BILL>
                
                }
            </ns1:BILLS>
        </ns1:billQueryResponse>
};

declare variable $consultar_identidadResponse as element(ns0:consultar_identidadResponse) external;
declare variable $contractID as xs:string external;
declare variable $contractName as xs:string external;
declare variable $tipoConvenio as xs:string external;

xf:consultarIdentidadOut($consultar_identidadResponse,
    $contractID,
    $contractName,
    $tipoConvenio)