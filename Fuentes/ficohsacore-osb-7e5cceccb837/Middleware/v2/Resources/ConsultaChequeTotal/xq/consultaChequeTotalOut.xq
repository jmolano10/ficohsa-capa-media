(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/chequeTotal/xsd/chequeTotal_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaChequeTotalResponse" location="../../ConsultaChequesCompensacion/xsd/consultaChequesCompensacionTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/chequeTotal";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaChequesCompensacionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaChequeTotal/xq/consultaChequeTotalOut/";

declare function xf:consultaChequeTotalOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaChequeTotalResponse) {
        <ns1:consultaChequeTotalResponse>
            {
                for $PN_TOTAL_DOCUMENTOS in $outputParameters/ns0:PN_TOTAL_DOCUMENTOS
                return
                    <TOTAL_DOCUMENTS>{ data($PN_TOTAL_DOCUMENTOS) }</TOTAL_DOCUMENTS>
            }
            {
                for $PN_TOTAL_MONTOS in $outputParameters/ns0:PN_TOTAL_MONTOS
                return
                    <TOTAL_AMOUNT>{ data($PN_TOTAL_MONTOS) }</TOTAL_AMOUNT>
            }
        </ns1:consultaChequeTotalResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaChequeTotalOut($outputParameters)
