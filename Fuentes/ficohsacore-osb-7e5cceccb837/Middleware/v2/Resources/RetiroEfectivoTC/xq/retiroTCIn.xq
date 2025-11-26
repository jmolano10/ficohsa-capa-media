(:: pragma bea:global-element-parameter parameter="$retiroEfectivoTC1" element="ns0:retiroEfectivoTC" location="../xsd/retiroEfectivoTCTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/MasterDataPA/conDatosTarjetaVP/xsd/conDatosTarjetaVP_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$onlinePaymentV4Response1" element="ns3:OnlinePaymentV4Response" location="../../../BusinessServices/VisionPlusPA/onlineTransactions_v4/wsdl/OnlineTransactions_v4.wsdl" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/PWS/retiroTC/xsd/retiroTC_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroEfectivoTCTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/retiroTC";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosTarjetaVP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroEfectivoTC/xq/retiroTCIn/";
declare namespace ns3 = "http://www.procesa.com/fdcs/ot";

declare function xf:retiroTCIn($retiroEfectivoTC1 as element(ns0:retiroEfectivoTC),
    $outputParameters1 as element(ns1:OutputParameters),
    $onlinePaymentV4Response1 as element(ns3:OnlinePaymentV4Response))
    as element(ns2:InputParameters) {
    let $creditCard := data($retiroEfectivoTC1/CREDIT_CARD)
    return
        <ns2:InputParameters>
            <ns2:PV_MERCHAT_NUMBER>{ data($retiroEfectivoTC1/MERCHANT_NUMBER) }</ns2:PV_MERCHAT_NUMBER>
            <ns2:PV_NUMERO_TARJETA>{ fn-bea:pad-left($creditCard, 19, '0') }</ns2:PV_NUMERO_TARJETA>
            <ns2:PN_VALOR_EFECTIVO>{ data($retiroEfectivoTC1/AMOUNT) }</ns2:PN_VALOR_EFECTIVO>
            <ns2:PN_ORG>{ data($outputParameters1/ns1:ORG) }</ns2:PN_ORG>
            <ns2:PN_ISO_MONEDA>{ data($retiroEfectivoTC1/CURRENCY) }</ns2:PN_ISO_MONEDA>
            <ns2:PV_NUMERO_AUTORIZACION>{ data($onlinePaymentV4Response1/AuthorizationCode) }</ns2:PV_NUMERO_AUTORIZACION>
            <ns2:PV_REFERENCIA_RECUPERACION>{ data($onlinePaymentV4Response1/RRN37) }</ns2:PV_REFERENCIA_RECUPERACION>
            <ns2:PV_APLICADO>
                {
                    let $status  := fn-bea:trim(fn:upper-case(data($onlinePaymentV4Response1/ActionDescription)))
                    return
                        if ($status = 'APPROVED') then(
                               'S')
                        else(
                        if ($status = 'DECLINED') then(
                                'N')
                            else('')
                            )    
                }
            </ns2:PV_APLICADO>
            <ns2:PV_RESPONSE_CODE>{ data($onlinePaymentV4Response1/VPrespCode) }</ns2:PV_RESPONSE_CODE>
        </ns2:InputParameters>
};

declare variable $retiroEfectivoTC1 as element(ns0:retiroEfectivoTC) external;
declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $onlinePaymentV4Response1 as element(ns3:OnlinePaymentV4Response) external;

xf:retiroTCIn($retiroEfectivoTC1,
    $outputParameters1,
    $onlinePaymentV4Response1)