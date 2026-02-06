xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$ResponseTransferACH" element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/ProgramadasACHTransferHeaderOut/";

declare function xf:ProgramadasACHTransferHeaderOut($ResponseTransferACH as element(ns0:ResponseHeader))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $ResponseTransferACH/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $ResponseTransferACH/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $ResponseTransferACH/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $valueDate in $ResponseTransferACH/valueDate
                return
                    <valueDate>{ data($valueDate) }</valueDate>
            }
        </ns0:ResponseHeader>
};

declare variable $ResponseTransferACH as element(ns0:ResponseHeader) external;

xf:ProgramadasACHTransferHeaderOut($ResponseTransferACH)