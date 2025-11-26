(:: pragma bea:global-element-parameter parameter="$actualizaciondetasadecambioResponse" element="ns0:ActualizaciondetasadecambioResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:actualizacionTasaCambioResponse" location="actualizacionTasaCambioTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizacionTasaCambioTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/actualizacionTasaCambio/actualizacionTasaCambioHeaderOut/";

declare function xf:actualizacionTasaCambioOut($actualizaciondetasadecambioResponse as element(ns0:ActualizaciondetasadecambioResponse))
    as element(ns1:actualizacionTasaCambioResponse) {
        <ns1:actualizacionTasaCambioResponse>
            <DATE_TIME>{ concat("20", fn:string($actualizaciondetasadecambioResponse/CURRENCYType/gDATETIME/DATETIME[1]/text()))}</DATE_TIME>
        </ns1:actualizacionTasaCambioResponse>
};

declare variable $actualizaciondetasadecambioResponse as element(ns0:ActualizaciondetasadecambioResponse) external;

xf:actualizacionTasaCambioOut($actualizaciondetasadecambioResponse)