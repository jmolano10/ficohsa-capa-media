(:: pragma bea:global-element-parameter parameter="$retiroATMConCupon" element="ns2:retiroATMConCupon" location="../xsd/retiroATMConCuponTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:coupontransfer" location="../../../BusinessServices/TENGO/xsd/XMLSchema_-1112897975.xsd" ::)

declare namespace ns0 = "http://www.utiba.com/delirium/ws/Misc";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/retiroATMConCuponTypes";
declare namespace ns1 = "urn:UMARKETSCWS";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroATMConCupon/xq/redimirCuponTengoIn/";
declare namespace ns3 = "http://www.utiba.com/delirium/ws/StdQuery";

declare function xf:redimirCuponTengoIn($sessionId as xs:string,
	$retiroATMConCupon as element(ns2:retiroATMConCupon))
    as element(ns1:coupontransfer) {
        <ns1:coupontransfer>
            <ns1:coupontransferRequestType>
                <ns3:extra_trans_data>
                    <ns0:keyValuePairs>
                        <ns0:key>CANAL</ns0:key>
                        <ns0:value>{ data($retiroATMConCupon/CHANNEL) }</ns0:value>
                    </ns0:keyValuePairs>
                    <ns0:keyValuePairs>
                        <ns0:key>CODIGO</ns0:key>
                        <ns0:value>{ data($retiroATMConCupon/TERMINAL_ID) }</ns0:value>
                    </ns0:keyValuePairs>
                    <ns0:keyValuePairs>
                        <ns0:key>TraceNumberATM</ns0:key>
                        <ns0:value>{ data($retiroATMConCupon/TERMINAL_REFERENCE) }</ns0:value>
                    </ns0:keyValuePairs>
                </ns3:extra_trans_data>
                <ns1:sessionid>{ $sessionId }</ns1:sessionid>
                {
                    for $AMOUNT in $retiroATMConCupon/AMOUNT
                    return
                        <ns1:amount>{ data($AMOUNT) }</ns1:amount>
                }
                <ns1:couponid>{ data($retiroATMConCupon/COUPON_ID) }</ns1:couponid>
            </ns1:coupontransferRequestType>
        </ns1:coupontransfer>
};

declare variable $retiroATMConCupon as element(ns2:retiroATMConCupon) external;
declare variable $sessionId as xs:string external;

xf:redimirCuponTengoIn($sessionId,
	$retiroATMConCupon)
