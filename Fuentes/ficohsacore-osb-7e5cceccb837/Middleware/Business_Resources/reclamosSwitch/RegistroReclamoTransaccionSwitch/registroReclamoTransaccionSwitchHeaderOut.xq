(:: pragma bea:local-element-parameter parameter="$status" type="ns0:ReclamoswitchvisaenficohsaResponse/Status" location="../Resources/XMLSchema_-1759531368.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$fUNDSTRANSFERType" type="ns0:ReclamoswitchvisaenficohsaResponse/FUNDSTRANSFERType" location="../Resources/XMLSchema_-1759531368.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/reclamosSwitch/RegistroReclamoTransaccionSwitch/registroReclamoTransaccionSwitchHeaderOut/";

declare function xf:registroReclamoTransaccionSwitchHeaderOut($status as element(),
    $fUNDSTRANSFERType as element())
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $CREDITVALUEDATE in $fUNDSTRANSFERType/CREDITVALUEDATE
                return
                    <valueDate>{ data($CREDITVALUEDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $status as element() external;
declare variable $fUNDSTRANSFERType as element() external;

xf:registroReclamoTransaccionSwitchHeaderOut($status,
    $fUNDSTRANSFERType)