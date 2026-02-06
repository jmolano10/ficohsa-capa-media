xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:actualizaEstadoTDResponse" location="../xsd/actualizaEstadoTDTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaEstadoTDTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoTD/xq/actualizaEstadoTDOUT/";

declare function getCardStatus($cardStatus as xs:string) as xs:string {
	if ($cardStatus = "90") then ("ISSUED")
    elseif ($cardStatus = "91") then ("RETURNED")
    elseif ($cardStatus = "92") then ("SCRAP")
    elseif ($cardStatus = "93") then ("CANCEL")
    elseif ($cardStatus = "94") then ("ACTIVE")
    elseif ($cardStatus = "95") then ("DESTROYED")
    elseif ($cardStatus = "96") then ("BLOCKED")
    else("")
};


declare function xf:actualizaEstadoTDOUT($CardNumberIN as xs:string,
    $CardSatusIN as xs:string)
    as element(ns0:actualizaEstadoTDResponse) {
        <ns0:actualizaEstadoTDResponse>
            <CARD_NUMBER>{ $CardNumberIN }</CARD_NUMBER>
            <CARD_STATUS>{ getCardStatus($CardSatusIN) }</CARD_STATUS>
        </ns0:actualizaEstadoTDResponse>
};

declare variable $CardNumberIN as xs:string external;
declare variable $CardSatusIN as xs:string external;

xf:actualizaEstadoTDOUT($CardNumberIN,
    $CardSatusIN)