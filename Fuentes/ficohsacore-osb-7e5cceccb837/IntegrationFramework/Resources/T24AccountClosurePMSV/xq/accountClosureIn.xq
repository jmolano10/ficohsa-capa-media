(:: pragma bea:global-element-parameter parameter="$aCCOUNTCLOSURE" element="ns0:ACCOUNTCLOSURE" location="../xsd/ACCOUNTCLOSURE-ACCOUNTCLOSURE.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/cancelAccount/xsd/cancelAccount_sp.xsd" ::)

declare namespace ns2 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cancelAccount";
declare namespace ns0 = "http://www.temenos.com/T24/event/ACCOUNTCLOSURE/ACCOUNTCLOSURE";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24AccountClosurePMSV/xq/accountClosureIn/";

declare function xf:accountClosureIn($aCCOUNTCLOSURE as element(ns0:ACCOUNTCLOSURE))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_COUNTRYCODE>HN</ns1:PV_COUNTRYCODE>
            {
                for $accountNumber in $aCCOUNTCLOSURE/ns0:accountNumber
                return
                    <ns1:PV_ACCOUNTNUMBER>{ data($accountNumber) }</ns1:PV_ACCOUNTNUMBER>
            }
            <ns1:PV_CANCELDATE>{ data($aCCOUNTCLOSURE/ns0:capitalDate) }</ns1:PV_CANCELDATE>
            {
                let $result :=
                    for $dateTime in $aCCOUNTCLOSURE/ns0:dateTimeList/ns0:dateTime
                    return
                        <ns1:PV_TIMESTAMPSOURCE>{ data($dateTime) }</ns1:PV_TIMESTAMPSOURCE>
                return
                    $result[1]
            }
        </ns1:InputParameters>
};

declare variable $aCCOUNTCLOSURE as element(ns0:ACCOUNTCLOSURE) external;

xf:accountClosureIn($aCCOUNTCLOSURE)
