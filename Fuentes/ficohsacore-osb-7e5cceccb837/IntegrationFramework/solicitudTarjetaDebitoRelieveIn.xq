xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$solicitudTarjetaDebitoRelieve" element="ns2:solicitudTarjetaDebitoRelieve" location="../Middleware/v2/Resources/SolicitudTarjetaDebitoRelieve/xsd/solicitudTarjetaDebitoRelieveTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:SolicituddeTDconRelieve" location="../Middleware/Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace xf = "http://tempuri.org/IntegrationFramework/solicitudTarjetaDebitoRelieveIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/solicitudTarjetaDebitoRelieveTypes";
declare namespace ns1 = "T24WebServicesImpl";

declare function xf:solicitudTarjetaDebitoRelieveIn($requestHeader as element(ns0:RequestHeader),
    $solicitudTarjetaDebitoRelieve as element(ns2:solicitudTarjetaDebitoRelieve))
    as element(ns1:SolicituddeTDconRelieve) {
        <ns1:SolicituddeTDconRelieve/>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $solicitudTarjetaDebitoRelieve as element(ns2:solicitudTarjetaDebitoRelieve) external;

xf:solicitudTarjetaDebitoRelieveIn($requestHeader,
    $solicitudTarjetaDebitoRelieve)
