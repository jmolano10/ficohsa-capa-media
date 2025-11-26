(:: pragma bea:schema-type-parameter parameter="$consultadetransaccionswitchResponse1" type="ns0:ConsultadetransaccionswitchResponse" location="../../../../Business_Resources/consultaTransacciones/Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTransaccionSwitchResponse" location="../xsd/consultaTransaccionSwitchTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTransaccionSwitchTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTransaccionSwitch/xq/consultaTransaccionSwitchHNOut/";

declare function xf:consultaTransaccionSwitchHNOut($consultadetransaccionswitchResponse1 as element())
    as element(ns1:consultaTransaccionSwitchResponse) {
        <ns1:consultaTransaccionSwitchResponse>
            {
                for $TXNREFERENCE in $consultadetransaccionswitchResponse1/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/TXNREFERENCE
                return
                    <TRANSACTION_ID>{ data($TXNREFERENCE) }</TRANSACTION_ID>
            }
            {
                for $ATMID in $consultadetransaccionswitchResponse1/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/ATMID
                return
                    <ATM_ID>{ data($ATMID) }</ATM_ID>
            }
            {
                for $NETWORKID in $consultadetransaccionswitchResponse1/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/NETWORKID
                return
                    <NETWORK_ID>{ data($NETWORKID) }</NETWORK_ID>
            }
            {
                for $TRACENUMBER in $consultadetransaccionswitchResponse1/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/TRACENUMBER
                return
                    <ATM_TRACE_NUMBER>{ data($TRACENUMBER) }</ATM_TRACE_NUMBER>
            }
            {
                for $ID in $consultadetransaccionswitchResponse1/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/ID
                return
                    <FULL_TRACE_NUMBER>{ data($ID) }</FULL_TRACE_NUMBER>
            }
            {
                for $TXNDATE in $consultadetransaccionswitchResponse1/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/TXNDATE
                return
                    <TRANSACTION_DATE>{ data($TXNDATE) }</TRANSACTION_DATE>
            }
            {
                for $TXNTIME in $consultadetransaccionswitchResponse1/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/TXNTIME
                return
                    <TRANSACTION_TIME>{ data($TXNTIME) }</TRANSACTION_TIME>
            }
            {
                for $AMOUNT in $consultadetransaccionswitchResponse1/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/AMOUNT
                return
                    <AMOUNT>{ data($AMOUNT) }</AMOUNT>
            }
            {
                for $CURRENCY in $consultadetransaccionswitchResponse1/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $AUTHCODE in $consultadetransaccionswitchResponse1/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/AUTHCODE
                return
                    <AUTHORIZATION>{ data($AUTHCODE) }</AUTHORIZATION>
            }
            {
                for $MCCCODE in $consultadetransaccionswitchResponse1/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/MCCCODE
                return
                    <MCCCODE>{ data($MCCCODE) }</MCCCODE>
            }
            {
                for $BRANCHNAME in $consultadetransaccionswitchResponse1/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/BRANCHNAME
                return
                    <BRANCH_NAME>{ data($BRANCHNAME) }</BRANCH_NAME>
            }
        </ns1:consultaTransaccionSwitchResponse>
};

declare variable $consultadetransaccionswitchResponse1 as element() external;

xf:consultaTransaccionSwitchHNOut($consultadetransaccionswitchResponse1)
