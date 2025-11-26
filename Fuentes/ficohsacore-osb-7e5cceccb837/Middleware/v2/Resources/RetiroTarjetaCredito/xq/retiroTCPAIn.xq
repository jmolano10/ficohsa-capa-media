(:: pragma bea:global-element-parameter parameter="$retiroTarjetaCredito" element="ns0:retiroTarjetaCredito" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$onlinePaymentV4Response" element="ns2:OnlinePaymentV4Response" location="../../../BusinessServices/VisionPlusPA/onlineTransactions_v4/wsdl/OnlineTransactions_v4.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PWS/retiroTC/xsd/retiroTC_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";
declare namespace ns2 = "http://www.procesa.com/fdcs/ot";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/retiroTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCredito/xq/retiroTCPAIn/";

declare function xf:retiroTCPAIn($retiroTarjetaCredito as element(ns0:retiroTarjetaCredito),
    $onlinePaymentV4Response as element(ns2:OnlinePaymentV4Response),
    $org as xs:string,
    $merchant as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_MERCHAT_NUMBER>{ $merchant }</ns1:PV_MERCHAT_NUMBER>
            <ns1:PV_NUMERO_TARJETA>{ data($retiroTarjetaCredito/CREDIT_CARD_INFO/VALUE) }</ns1:PV_NUMERO_TARJETA>
            <ns1:PN_VALOR_EFECTIVO>{ data($retiroTarjetaCredito/AMOUNT) }</ns1:PN_VALOR_EFECTIVO>
            <ns1:PN_ORG>{ data($org) }</ns1:PN_ORG>
            <ns1:PV_NUMERO_AUTORIZACION>{ data($onlinePaymentV4Response/AuthorizationCode) }</ns1:PV_NUMERO_AUTORIZACION>
            <ns1:PV_REFERENCIA_RECUPERACION>{ data($onlinePaymentV4Response/RRN37) }</ns1:PV_REFERENCIA_RECUPERACION>
            <ns1:PV_APLICADO>
            {
                    let $status  := fn-bea:trim(fn:upper-case(data($onlinePaymentV4Response/ActionDescription)))
                    return
                        if ($status = 'APPROVED') then(
                               'S')
                        else(
                        if ($status = 'DECLINED') then(
                                'N')
                            else('')
                            )    
                }
            </ns1:PV_APLICADO>
            <ns1:PV_RESPONSE_CODE>{ data($onlinePaymentV4Response/VPrespCode) }</ns1:PV_RESPONSE_CODE>
        </ns1:InputParameters>
};

declare variable $retiroTarjetaCredito as element(ns0:retiroTarjetaCredito) external;
declare variable $onlinePaymentV4Response as element(ns2:OnlinePaymentV4Response) external;
declare variable $org as xs:string external;
declare variable $merchant as xs:string external;

xf:retiroTCPAIn($retiroTarjetaCredito,
    $onlinePaymentV4Response,
    $org,
    $merchant)
