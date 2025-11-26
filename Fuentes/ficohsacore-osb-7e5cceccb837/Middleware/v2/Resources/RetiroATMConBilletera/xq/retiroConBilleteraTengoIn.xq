(:: pragma bea:global-element-parameter parameter="$retiroATMConBilletera" element="ns2:retiroATMConBilletera" location="../xsd/retiroATMConBilleteraTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transfer" location="../../../BusinessServices/TENGO/xsd/XMLSchema_-1112897975.xsd" ::)

declare namespace ns0 = "http://www.utiba.com/delirium/ws/Misc";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/retiroATMConBilleteraTypes";
declare namespace ns1 = "urn:UMARKETSCWS";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroATMConBilletera/xq/retiroConBilleteraTengoIn/";
declare namespace ns3 = "http://www.utiba.com/delirium/ws/StdQuery";

declare function xf:retiroConBilleteraTengoIn($sessionId as xs:string,
	$destination as xs:string,
    $retiroATMConBilletera as element(ns2:retiroATMConBilletera))
    as element(ns1:transfer) {
        <ns1:transfer>
            <ns1:transferRequest>
                <ns3:extra_trans_data>
                    <ns0:keyValuePairs>
                        <ns0:key>CANAL</ns0:key>
                        <ns0:value>{ data($retiroATMConBilletera/CHANNEL) }</ns0:value>
                    </ns0:keyValuePairs>
                    <ns0:keyValuePairs>
                        <ns0:key>CODIGO</ns0:key>
                        <ns0:value>{ data($retiroATMConBilletera/TERMINAL_ID) }</ns0:value>
                    </ns0:keyValuePairs>
                    <ns0:keyValuePairs>
                        <ns0:key>TraceNumberATM</ns0:key>
                        <ns0:value>{ data($retiroATMConBilletera/TERMINAL_REFERENCE) }</ns0:value>
                    </ns0:keyValuePairs>
                </ns3:extra_trans_data>
                <ns1:sessionid>{ $sessionId }</ns1:sessionid>
                <ns1:suppress_confirm>true</ns1:suppress_confirm>
                <ns1:to>{ $destination }</ns1:to>
                <ns1:amount>{ data($retiroATMConBilletera/AMOUNT) }</ns1:amount>
            </ns1:transferRequest>
        </ns1:transfer>
};

declare variable $sessionId as xs:string external;
declare variable $destination as xs:string external;
declare variable $retiroATMConBilletera as element(ns2:retiroATMConBilletera) external;

xf:retiroConBilleteraTengoIn($sessionId,
	$destination,
    $retiroATMConBilletera)
