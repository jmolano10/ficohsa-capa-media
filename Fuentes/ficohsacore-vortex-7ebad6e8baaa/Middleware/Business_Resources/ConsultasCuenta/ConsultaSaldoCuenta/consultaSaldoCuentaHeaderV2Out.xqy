xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldoCuentaResponse1" element="ns0:ConsultaSaldoCuentaResponse" location="../Resources/ConsultaSaldoCuenta/xsd/services_1.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaSaldoCuenta/consultaSaldoCuentaHeaderOut/";

declare function xf:consultaSaldoCuentaHeaderOut($consultaSaldoCuentaResponse1 as element(ns0:ConsultaSaldoCuentaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
           {
                for $transactionId in $consultaSaldoCuentaResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $consultaSaldoCuentaResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultaSaldoCuentaResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultaSaldoCuentaResponse1 as element(ns0:ConsultaSaldoCuentaResponse) external;

xf:consultaSaldoCuentaHeaderOut($consultaSaldoCuentaResponse1)