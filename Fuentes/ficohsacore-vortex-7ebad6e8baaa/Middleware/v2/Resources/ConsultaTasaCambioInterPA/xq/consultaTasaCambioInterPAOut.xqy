xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/consultaTasaCambioInterPA/xsd/consultaTasaCambioInterPA_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTasaCambioInterPAResponse" location="../xsd/consultaTasaCambioInterPATypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioInterPATypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTasaCambioInterPA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTasaCambioInterPA/xq/consultaTasaCambioInterPAOut/";

declare function xf:consultaTasaCambioInterPAOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaTasaCambioInterPAResponse) {
        <ns0:consultaTasaCambioInterPAResponse>
            <ns0:consultaTasaCambioInterPAResponseType>
                <ns0:consultaTasaCambioInterPAResponseRecordType>
                    {
                        for $BUY_RATE in $outputParameters1/ns1:BUY_RATE
                        return
                            <BUY_RATE>{ data($BUY_RATE) }</BUY_RATE>
                    }
                    {
                        for $SELL_RATE in $outputParameters1/ns1:SELL_RATE
                        return
                            <SELL_RATE>{ data($SELL_RATE) }</SELL_RATE>
                    }
                    <MATH_OPERATOR>{ data($outputParameters1/ns1:MATH_OPERATOR) }</MATH_OPERATOR>
                </ns0:consultaTasaCambioInterPAResponseRecordType>
            </ns0:consultaTasaCambioInterPAResponseType>
        </ns0:consultaTasaCambioInterPAResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaTasaCambioInterPAOut($outputParameters1)