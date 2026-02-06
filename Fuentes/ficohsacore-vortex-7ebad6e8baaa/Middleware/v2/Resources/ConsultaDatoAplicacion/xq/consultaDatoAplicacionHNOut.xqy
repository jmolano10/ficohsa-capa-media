xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/PWS/consultaDatoCreditScore/xsd/consultaDatoCreditScore_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDatoAplicacionResponse" location="../xsd/consultaDatoAplicacionTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDatoCreditScore";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatoAplicacionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatoAplicacion/xq/consultaDatoAplicacionHNOut/";

declare function xf:consultaDatoAplicacionHNOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaDatoAplicacionResponse) {
        <ns0:consultaDatoAplicacionResponse>
            {
                for $P_DATA_VALUE in $outputParameters/ns1:P_DATA_VALUE
                return
                    <ns0:DATA_VALUE>{ data($P_DATA_VALUE) }</ns0:DATA_VALUE>
            }
        </ns0:consultaDatoAplicacionResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaDatoAplicacionHNOut($outputParameters)