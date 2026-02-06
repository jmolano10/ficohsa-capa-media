xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoDePaquetesMovilesFTResponse" element="ns1:PagoDePaquetesMovilesFTResponse" location="../../../BusinessServices/T24/PaquetesMoviles/xsd/XMLSchema_-578407725.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CompraPaquete/xq/compraPaqueteMovilHdrOut/";

declare function xf:compraPaqueteMovilHdrOut($pagoDePaquetesMovilesFTResponse as element(ns1:PagoDePaquetesMovilesFTResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $pagoDePaquetesMovilesFTResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $pagoDePaquetesMovilesFTResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $DEBITVALUEDATE in $pagoDePaquetesMovilesFTResponse/FUNDSTRANSFERType/DEBITVALUEDATE
                return
                    <valueDate>{ data($DEBITVALUEDATE) }</valueDate>
            }
        </ns0:ResponseHeader>
};

declare variable $pagoDePaquetesMovilesFTResponse as element(ns1:PagoDePaquetesMovilesFTResponse) external;

xf:compraPaqueteMovilHdrOut($pagoDePaquetesMovilesFTResponse)