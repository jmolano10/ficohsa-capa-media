(:: pragma  type="anyType" ::)

declare namespace xh = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_GestionesBeneficios";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTarjetaBeneficios/xq/consultaTarjetaBeneficioHeaderInHn/";

declare function xf:consultaTarjetaBeneficioHeaderInHn($IdSession as xs:string)
    as element(*) {
        <xh:Header>
        <ns0:SessionHeader>
            <ns0:sessionId>{ fn:string($IdSession) }</ns0:sessionId>
        </ns0:SessionHeader>
    </xh:Header>
};

declare variable $IdSession as xs:string external;

xf:consultaTarjetaBeneficioHeaderInHn($IdSession)