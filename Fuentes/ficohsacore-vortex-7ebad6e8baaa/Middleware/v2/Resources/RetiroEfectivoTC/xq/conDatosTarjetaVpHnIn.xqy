xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$retiroEfectivoTC" element="ns0:retiroEfectivoTC" location="../xsd/retiroEfectivoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MasterDataHN/conDatosTarjetaVp/xsd/conDatosTarjetaVp_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroEfectivoTCTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosTarjetaVp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroEfectivoTC/xq/conDatosTarjetaVpHnIn/";

declare function xf:conDatosTarjetaVpHnIn($retiroEfectivoTC as element(ns0:retiroEfectivoTC))
    as element(ns1:InputParameters) {
    let $creditCard := data($retiroEfectivoTC/CREDIT_CARD)
    return
        <ns1:InputParameters>
            <ns1:CURRENCY>{ data($retiroEfectivoTC/CURRENCY) }</ns1:CURRENCY>
            <ns1:CREDIT_CARD>{ fn-bea:pad-left($creditCard, 19, '0') }</ns1:CREDIT_CARD>
        </ns1:InputParameters>
};

declare variable $retiroEfectivoTC as element(ns0:retiroEfectivoTC) external;

xf:conDatosTarjetaVpHnIn($retiroEfectivoTC)