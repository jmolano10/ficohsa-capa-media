xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3 = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace ns2="http://soap.sforce.com/schemas/class/WS_crearOrdenEmpaque";
(:: import schema at "../../../../../ProviderServices/v1.0/WSDL/PackingOrder/PackingOrder_BS.wsdl" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/createPackingOrderHeaderIn";

declare variable $sessionId as xs:string external;

declare function ns1:createPackingOrderHeaderIn($sessionId as xs:string) as element() {
    <ns3:Header>
        <ns2:SessionHeader>
            <ns2:sessionId>{fn:data($sessionId)}</ns2:sessionId>
        </ns2:SessionHeader>
    </ns3:Header>
};

ns1:createPackingOrderHeaderIn($sessionId)
