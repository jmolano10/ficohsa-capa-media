xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaTasaCambio/xsd/ConsultaTasaCambio_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTasaCambioResponse" location="../../../../Business_Resources/Core/consultaTasaCambio/consultaTasaCambioTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaTasaCambio";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaTasaCambio/xq/consultaTasaCambioOut/";

declare function xf:consultaTasaCambioOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaTasaCambioResponse) {
        <ns0:consultaTasaCambioResponse>
            <ns0:consultaTasaCambioResponseType>
                {
                    let $OutputParameters := $outputParameters1
                    return
                        <ns0:consultaTasaCambioResponseRecordType>
                            {
                                for $BUY_RATE in $OutputParameters/ns1:BUY_RATE
                                return
                                    <BUY_RATE>{ data($BUY_RATE) }</BUY_RATE>
                            }
                            {
                                for $SELL_RATE in $OutputParameters/ns1:SELL_RATE
                                return
                                    <SELL_RATE>{ data($SELL_RATE) }</SELL_RATE>
                            }
                        </ns0:consultaTasaCambioResponseRecordType>
                }
            </ns0:consultaTasaCambioResponseType>
        </ns0:consultaTasaCambioResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaTasaCambioOut($outputParameters1)