(:: pragma bea:global-element-parameter parameter="$consultarResponse" element="ns0:consultarResponse" location="../../../../BusinessServices/SegurosGT/PagoSeguro/wsdl/pagoBancoPS.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:billQueryResponse" location="../../xsd/BillOperationsTypes.xsd" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/billOperationsTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/BillOperations/BillQuery/xq/consultarOut/";

declare function xf:consultarOut($consultarResponse as element(ns0:consultarResponse),
    $contractID as xs:string,
    $contractName as xs:string)
    as element(ns1:billQueryResponse) {
        <ns1:billQueryResponse>
            <ns1:CONTRACT_ID>{ data($contractID) }</ns1:CONTRACT_ID>
            <ns1:CONTRACT_NAME>{ data($contractName) }</ns1:CONTRACT_NAME>
            <ns1:DEBTOR_CODE>{ data($consultarResponse/ns0:consultarResult/ns0:consulta_poliza[1]/ns0:poliza) }</ns1:DEBTOR_CODE>
            <ns1:DEBTOR_NAME>{ data($consultarResponse/ns0:consultarResult/ns0:consulta_poliza[1]/ns0:nombre_aseg) }</ns1:DEBTOR_NAME>
            <ns1:BILLS>
                {
                    let $producto := data($consultarResponse/ns0:consultarResult/ns0:consulta_poliza[1]/ns0:producto)
                    for $cuota in $consultarResponse/ns0:consultarResult/ns0:consulta_poliza[1]/ns0:detalle_cuotas/ns0:cuotas
                    return
                        <ns1:BILL>
                            <ns1:ID>{ data($cuota/ns0:nro_recibo) }</ns1:ID>
                            <ns1:DESCRIPTION>{ concat( "PRODUCTO ", $producto, " CUOTA ",  data($cuota/ns0:nro_cuota)) }</ns1:DESCRIPTION>
                            <ns1:CURRENCY>
                            { 
                               if(upper-case(data($cuota/ns0:moneda)) = 'Q') then(
                                   'GTQ'
                                   )elseif(upper-case(data($cuota/ns0:moneda)) = 'USD') then(
                                    'USD'
                                    )else()                  
                            }
                            </ns1:CURRENCY>
                            <ns1:ISSUE_DATE>{ data($cuota/ns0:fec_factura) }</ns1:ISSUE_DATE>
                            <ns1:DUE_DATE>{ data($cuota/ns0:fec_vencimiento) }</ns1:DUE_DATE>
                            <ns1:BILL_AMOUNT>{ data($cuota/ns0:monto) }</ns1:BILL_AMOUNT>
                            <ns1:LATE_FEE>0</ns1:LATE_FEE>
                            <ns1:TOTAL_AMOUNT>{ data($cuota/ns0:monto) }</ns1:TOTAL_AMOUNT>
                            <ns1:EXTRA_INFO>
                        		<ns2:PAIR>
                            			<ns2:KEY>INSTALLMENT_NUMBER</ns2:KEY>
                            			<ns2:VALUE>{ data($cuota/ns0:nro_cuota) }</ns2:VALUE>
                        		</ns2:PAIR>
                    		</ns1:EXTRA_INFO>
                        </ns1:BILL>
                }
            </ns1:BILLS>
        </ns1:billQueryResponse>
};

declare variable $consultarResponse as element(ns0:consultarResponse) external;
declare variable $contractID as xs:string external;
declare variable $contractName as xs:string external;

xf:consultarOut($consultarResponse,
    $contractID,
    $contractName)