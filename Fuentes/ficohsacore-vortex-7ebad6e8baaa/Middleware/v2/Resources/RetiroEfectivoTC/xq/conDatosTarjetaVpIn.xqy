xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$retiroEfectivoTC1" element="ns0:retiroEfectivoTC" location="../xsd/retiroEfectivoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MasterDataPA/conDatosTarjetaVP/xsd/conDatosTarjetaVP_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroEfectivoTCTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosTarjetaVP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroEfectivoTC/xq/conDatosTarjetaVpIn/";

declare function xf:conDatosTarjetaVpIn($retiroEfectivoTC1 as element(ns0:retiroEfectivoTC))
    as element(ns1:InputParameters) {
    let $creditCard := data($retiroEfectivoTC1/CREDIT_CARD)
    return
        <ns1:InputParameters>
            <ns1:CURRENCY>{ data($retiroEfectivoTC1/CURRENCY) }</ns1:CURRENCY>
            <ns1:CREDIT_CARD>{ fn-bea:pad-left($creditCard, 19, '0') }</ns1:CREDIT_CARD>
        </ns1:InputParameters>
};

declare variable $retiroEfectivoTC1 as element(ns0:retiroEfectivoTC) external;

xf:conDatosTarjetaVpIn($retiroEfectivoTC1)