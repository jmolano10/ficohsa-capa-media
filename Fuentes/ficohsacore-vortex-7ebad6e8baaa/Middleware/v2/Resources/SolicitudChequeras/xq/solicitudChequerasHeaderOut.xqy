xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$solicituddechequeraResponse1" element="ns0:SolicituddechequeraResponse" location="../../../../Business_Resources/solicitudChequeras/Resources/XMLSchema_21306858.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/solicitudChequeras/SolicitudChequeras/solicitudChequerasHeaderOut/";

declare function xf:solicitudChequerasHeaderOut($solicituddechequeraResponse1 as element(ns0:SolicituddechequeraResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $solicituddechequeraResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $solicituddechequeraResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $solicituddechequeraResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $solicituddechequeraResponse1/FICOHCHECKBOOKREQUESTType/gDATETIME/DATETIME
                    return
                        <valueDate>{ data($DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $solicituddechequeraResponse1 as element(ns0:SolicituddechequeraResponse) external;

xf:solicitudChequerasHeaderOut($solicituddechequeraResponse1)