(:: pragma bea:global-element-parameter parameter="$consultadesaldodecuentaResponse" element="ns0:ConsultadesaldodecuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaMaestraSaldoCuenta/consultaMaestraSaldoCuentaHeaderOut/";

declare function xf:consultaMaestraSaldoCuentaHeaderOut($consultadesaldodecuentaResponse as element(ns0:ConsultadesaldodecuentaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultadesaldodecuentaResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $consultadesaldodecuentaResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultadesaldodecuentaResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadesaldodecuentaResponse as element(ns0:ConsultadesaldodecuentaResponse) external;

xf:consultaMaestraSaldoCuentaHeaderOut($consultadesaldodecuentaResponse)