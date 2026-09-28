(:: pragma bea:global-element-parameter parameter="$consultaRecibo" element="ns0:consultaRecibo" location="../../CobranzasH2H/xsd/cobranzasH2HTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CNV/consultaReciboH2H/xsd/consultaReciboH2H_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cobranzasH2HTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaReciboH2H";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/ConsultaReciboH2H/xq/consultaReciboH2HIn/";

declare function xf:consultaReciboH2HIn($consultaRecibo as element(ns0:consultaRecibo),
    $contractId as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CONTRATO>{ $contractId }</ns1:PV_CONTRATO>
            <ns1:PV_CODIGODEUDOR>{ data($consultaRecibo/DEBTOR_CODE) }</ns1:PV_CODIGODEUDOR>
            <ns1:PV_CODIGOTRANSACCION>{ data($consultaRecibo/TRANSACTION_ID) }</ns1:PV_CODIGOTRANSACCION>
        </ns1:InputParameters>
};

declare variable $consultaRecibo as element(ns0:consultaRecibo) external;
declare variable $contractId as xs:string external;

xf:consultaReciboH2HIn($consultaRecibo,
    $contractId)