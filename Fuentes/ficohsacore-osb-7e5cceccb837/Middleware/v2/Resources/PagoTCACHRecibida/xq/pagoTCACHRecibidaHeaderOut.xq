(:: pragma bea:global-element-parameter parameter="$pagoTCporACHRecibidaenLineaResponse1" element="ns1:PagoTCporACHRecibidaenLineaResponse" location="../../../BusinessServices/T24/ACHRecibidas/xsd/XMLSchema_478367602.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTCACHRecibida/xq/pagoTCACHRecibidaHeaderOut/";

declare function xf:pagoTCACHRecibidaHeaderOut($pagoTCporACHRecibidaenLineaResponse1 as element(ns1:PagoTCporACHRecibidaenLineaResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $pagoTCporACHRecibidaenLineaResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $pagoTCporACHRecibidaenLineaResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $pagoTCporACHRecibidaenLineaResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $DRVALUEDATE in $pagoTCporACHRecibidaenLineaResponse1/TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/DRVALUEDATE
                return
                    <valueDate>{ data($DRVALUEDATE) }</valueDate>
            }
        </ns0:ResponseHeader>
};

declare variable $pagoTCporACHRecibidaenLineaResponse1 as element(ns1:PagoTCporACHRecibidaenLineaResponse) external;

xf:pagoTCACHRecibidaHeaderOut($pagoTCporACHRecibidaenLineaResponse1)