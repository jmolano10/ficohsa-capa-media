(:: pragma bea:global-element-parameter parameter="$consultadetransaccionswitchResponse" element="ns0:ConsultadetransaccionswitchResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTransaccionSwitchResponse" location="consultaTransaccionSwitchTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTransaccionSwitchTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaTransaccionSwitch/consultaTransaccionSwitchOut/";

declare function xf:consultaTransaccionSwitchOut($consultadetransaccionswitchResponse as element(ns0:ConsultadetransaccionswitchResponse))
    as element(ns1:consultaTransaccionSwitchResponse) {
        <ns1:consultaTransaccionSwitchResponse>
            {
                for $TXNREFERENCE in $consultadetransaccionswitchResponse/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/TXNREFERENCE
                return
                    <TRANSACTION_ID>{ data($TXNREFERENCE) }</TRANSACTION_ID>
            }
            {
                for $ATMID in $consultadetransaccionswitchResponse/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/ATMID
                return
                    <ATM_ID>{ data($ATMID) }</ATM_ID>
            }
            {
                for $NETWORKID in $consultadetransaccionswitchResponse/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/NETWORKID
                return
                    <NETWORK_ID>{ data($NETWORKID) }</NETWORK_ID>
            }
            {
                for $TRACENUMBER in $consultadetransaccionswitchResponse/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/TRACENUMBER
                return
                    <ATM_TRACE_NUMBER>{ data($TRACENUMBER) }</ATM_TRACE_NUMBER>
            }
            {
                for $ID in $consultadetransaccionswitchResponse/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/ID
                return
                    <FULL_TRACE_NUMBER>{ data($ID) }</FULL_TRACE_NUMBER>
            }
            {
                for $TXNDATE in $consultadetransaccionswitchResponse/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/TXNDATE
                return
                    <TRANSACTION_DATE>{ data($TXNDATE) }</TRANSACTION_DATE>
            }
            {
                for $TXNTIME in $consultadetransaccionswitchResponse/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/TXNTIME
                return
                    <TRANSACTION_TIME>{ data($TXNTIME) }</TRANSACTION_TIME>
            }
            {
                for $AMOUNT in $consultadetransaccionswitchResponse/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/AMOUNT
                return
                    <AMOUNT>{ data($AMOUNT) }</AMOUNT>
            }
            {
                for $CURRENCY in $consultadetransaccionswitchResponse/WSSWITCHTRANSACTIONType[1]/gWSSWITCHTRANSACTIONDetailType/mWSSWITCHTRANSACTIONDetailType[1]/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
        </ns1:consultaTransaccionSwitchResponse>
};

declare variable $consultadetransaccionswitchResponse as element(ns0:ConsultadetransaccionswitchResponse) external;

xf:consultaTransaccionSwitchOut($consultadetransaccionswitchResponse)