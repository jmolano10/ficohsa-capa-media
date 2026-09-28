(:: pragma bea:global-element-parameter parameter="$consultadetasadecambiosubastaResponse" element="ns0:ConsultadetasadecambiosubastaResponse" location="../Resources/XMLSchema_-1176801753.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasDivisas/ConsultaTasaCambioSubasta/consultaTasaCambioSubastaHeaderOut/";

declare function xf:consultaTasaCambioSubastaHeaderOut($consultadetasadecambiosubastaResponse as element(ns0:ConsultadetasadecambiosubastaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $consultadetasadecambiosubastaResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultadetasadecambiosubastaResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadetasadecambiosubastaResponse as element(ns0:ConsultadetasadecambiosubastaResponse) external;

xf:consultaTasaCambioSubastaHeaderOut($consultadetasadecambiosubastaResponse)