(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/DCP/registrarVentaMenor/xsd/registraVentaMenor_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registraVentaMenorResponse" location="../xsd/registraVentaMenorTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraVentaMenor";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registraVentaMenorTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraVentaMenor/xq/registraVentaMenorOut/";

declare function xf:registraVentaMenorOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:registraVentaMenorResponse) {
        <ns1:registraVentaMenorResponse>
            <TRANSACTION_ID>{ data($outputParameters/ns0:PERC) }</TRANSACTION_ID>
            <ERROR_MESSAGE>{ data($outputParameters/ns0:PERM) }</ERROR_MESSAGE>
        </ns1:registraVentaMenorResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:registraVentaMenorOut($outputParameters)