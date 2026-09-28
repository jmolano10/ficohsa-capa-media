(:: pragma bea:global-element-parameter parameter="$consultadesaldodecuentaResponse1" element="ns0:ConsultadesaldodecuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaSaldoCuenta/consultaSaldoCuentaHeaderOut/";

declare function xf:consultaSaldoCuentaHeaderOut($consultadesaldodecuentaResponse1 as element(ns0:ConsultadesaldodecuentaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultadesaldodecuentaResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $consultadesaldodecuentaResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultadesaldodecuentaResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadesaldodecuentaResponse1 as element(ns0:ConsultadesaldodecuentaResponse) external;

xf:consultaSaldoCuentaHeaderOut($consultadesaldodecuentaResponse1)