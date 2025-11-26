(:: pragma  parameter="$anyType1" type="xs:anyType" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/ws_gestiones";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaTarjetaBeneficio/xq/creaGestionGenericaHIn/";
declare namespace xh = "http://schemas.xmlsoap.org/soap/envelope/";

declare function xf:creaGestionGenericaHIn($sessionId as xs:string)
    as element(*) {
        <xh:Header>
	        <ns0:SessionHeader>
	            <ns0:sessionId>{ fn:string($sessionId) }</ns0:sessionId>
	        </ns0:SessionHeader>
	    </xh:Header>
};

declare variable $sessionId as xs:string external;

xf:creaGestionGenericaHIn($sessionId)