xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../EsquemasGenerales/headerElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoCobranzas" element="ns3:pagoCobranzas" location="../../CobranzasH2H/xsd/cobranzasH2HTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../BusinessServices/INTFC/consultaConveniosYCuentasH2H/xsd/consultaConveniosYCuentasH2H_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjPagoCobranzas" location="../../../BusinessServices/SJS/pagoCobranzasH2H/xsd/sjPagoCobranzasH2H.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjCobranzasH2HTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaConveniosYCuentasH2H";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/PagoCobranzasH2H/xq/sjPagoRecaudoH2HIn/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/cobranzasH2HTypes";

declare function xf:sjPagoRecaudoH2HIn($requestHeader as element(ns1:RequestHeader),
    $pagoCobranzas as element(ns3:pagoCobranzas),
    $outputParameters as element(ns2:OutputParameters))
    as element(ns0:sjPagoCobranzas) {
        <ns0:sjPagoCobranzas>
            <USER_NAME>{ upper-case(data($requestHeader/Authentication/UserName)) }</USER_NAME>
            <PASSWORD>{ data($requestHeader/Authentication/Password) }</PASSWORD>
            <SOURCE_BANK>{ data($requestHeader/Region/SourceBank) }</SOURCE_BANK>
            <CUSTOMER_ID>{ data($pagoCobranzas/CUSTOMER_ID) }</CUSTOMER_ID>
            <SERVICES>
                {
                    for $SERVICE in $pagoCobranzas/SERVICES/SERVICE
                    return
                        <SERVICE>
                            <ID>{ data($SERVICE/ID) }</ID>                            
                                {
                                    let $infoConvenio := $outputParameters/ns2:PT_CONVENIO/ns2:PT_CONVENIO_ITEM[ ns2:CONVENIO = data($SERVICE/ID) ]
                                    return(                                        
                                        (
                                        	for $CONTRATO in $infoConvenio/ns2:CONTRATO
                                            return
                                                <CONTRACT_ID>{ data($CONTRATO) }</CONTRACT_ID>
                                        ),
                                        <NAME>{ data($infoConvenio/ns2:DESCRIPCIONCONTRATO) }</NAME>,
                                        (
                                            for $CUENTA in $infoConvenio/ns2:CUENTAS[ ns2:CUENTAS_ITEM = data($SERVICE/PAYMENT_INFORMATION/PYMT_ID) ]
                                            return
                                                <ACCOUNT>{ data($CUENTA) }</ACCOUNT>
                                        )
                                    )
                                }
                                {
                                    let $PAYMENT_INFORMATION := $SERVICE/PAYMENT_INFORMATION
                                    return
                                        <PAYMENT_INFORMATION>
                                            <PYMT_METHOD>{ data($PAYMENT_INFORMATION/PYMT_METHOD) }</PYMT_METHOD>
                                            <PYMT_ID>{ data($PAYMENT_INFORMATION/PYMT_ID) }</PYMT_ID>
                                            <PYMT_CURRENCY>{ data($PAYMENT_INFORMATION/PYMT_CURRENCY) }</PYMT_CURRENCY>
                                        </PAYMENT_INFORMATION>
                                }
                                <DEBTORS>{ $SERVICE/DEBTORS/@* , $SERVICE/DEBTORS/node() }</DEBTORS>                                
                            </SERVICE>
                        }
            </SERVICES>
        </ns0:sjPagoCobranzas>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $pagoCobranzas as element(ns3:pagoCobranzas) external;
declare variable $outputParameters as element(ns2:OutputParameters) external;

xf:sjPagoRecaudoH2HIn($requestHeader,
    $pagoCobranzas,
    $outputParameters)