(:: pragma bea:global-element-return type="ns1:InboundSOAPRequestDocument/ns1:Headers/ns1:SOAPHeaders" element="ns0:SessionHeader" location="../../../BusinessServices/OrdenEmpaqueCloud/wsdl/ordenEmpaqueCloud.wsdl" ::)

declare namespace ns1 = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_crearOrdenEmpaque";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OrdenEmpaqueTD/xq/ordenEmpaqueCloudHeaderIN/";

declare function xf:ordenEmpaqueCloudHeaderIN($sessionID as xs:string)
    as element() {
    <ns1:Header>
        <ns0:SessionHeader>
            <ns0:sessionId>{ $sessionID }</ns0:sessionId>
        </ns0:SessionHeader>
    </ns1:Header>
};

declare variable $sessionID as xs:string external;

xf:ordenEmpaqueCloudHeaderIN($sessionID)
