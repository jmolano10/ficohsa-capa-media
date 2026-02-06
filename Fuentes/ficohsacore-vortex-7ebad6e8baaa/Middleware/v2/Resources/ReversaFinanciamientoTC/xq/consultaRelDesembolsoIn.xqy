xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$reversaFinanciamiento" element="ns1:reversaFinanciamiento" location="../../FinanciamientoTC/xsd/financiamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/INTFC/consulltaRelDesembolso/xsd/consultaRelDesembolso_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRelDesembolso";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/financiamientoTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversaFinanciamientoTC/xq/consultaRelDesembolsoIn/";

declare function xf:consultaRelDesembolsoIn($Usuario as xs:string,
    $SecuenciaCanal as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_USUARIO>{ $Usuario }</ns0:PV_USUARIO>
            <ns0:PV_SECUENCIACANAL>{ $SecuenciaCanal }</ns0:PV_SECUENCIACANAL>
        </ns0:InputParameters>
};

declare variable $Usuario as xs:string external;
declare variable $SecuenciaCanal as xs:string external;

xf:consultaRelDesembolsoIn($Usuario,
    $SecuenciaCanal)