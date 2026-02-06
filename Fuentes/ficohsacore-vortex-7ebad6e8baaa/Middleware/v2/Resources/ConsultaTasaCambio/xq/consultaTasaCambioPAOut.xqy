xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/consultaTasaCambio/xsd/consultaTasaCambio_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTasaCambioResponse" location="../../../../Business_Resources/Core/consultaTasaCambio/consultaTasaCambioTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTasaCambio";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaTasaCambio/xq/consultaTasaCambioOut/";

declare function xf:consultaTasaCambioOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaTasaCambioResponse) {
        <ns1:consultaTasaCambioResponse>
            <ns1:consultaTasaCambioResponseType>
                <ns1:consultaTasaCambioResponseRecordType>
                    {
                        for $BUY_RATE in $outputParameters1/ns0:BUY_RATE
                        return
                            <BUY_RATE>{ data($BUY_RATE) }</BUY_RATE>
                    }
                    {
                        for $SELL_RATE in $outputParameters1/ns0:SELL_RATE
                        return
                            <SELL_RATE>{ data($SELL_RATE) }</SELL_RATE>
                    }
                </ns1:consultaTasaCambioResponseRecordType>
            </ns1:consultaTasaCambioResponseType>
        </ns1:consultaTasaCambioResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaTasaCambioOut($outputParameters1)