xquery version "2004-draft";
(:: pragma  parameter="$anyType1" type="xs:anyType" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_GestionesBeneficios";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaTarjetaBeneficio/xq/ingresaTarjetaBeneficioHeaderHnIn/";
declare namespace xh = "http://schemas.xmlsoap.org/soap/envelope/";

declare function xf:ingresaTarjetaBeneficioHeaderHnIn($IDSession as xs:string)
    as element(*) {
    <xh:Header>
        <ns0:SessionHeader>
            <ns0:sessionId>{ fn:string($IDSession) }</ns0:sessionId>
        </ns0:SessionHeader>
    </xh:Header>
};

declare variable $IDSession as xs:string external;

xf:ingresaTarjetaBeneficioHeaderHnIn($IDSession)