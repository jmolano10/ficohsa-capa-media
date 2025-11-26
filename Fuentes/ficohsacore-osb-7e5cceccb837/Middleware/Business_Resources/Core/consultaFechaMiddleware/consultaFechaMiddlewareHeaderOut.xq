(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaFechaMiddleware/consultaFechaMiddlewareHeaderOut/";

declare function xf:consultaFechaMiddlewareHeaderOut()
as element(ns0:ResponseHeader) {
    <ns0:ResponseHeader>
        <successIndicator>Success</successIndicator>
    </ns0:ResponseHeader>
};


xf:consultaFechaMiddlewareHeaderOut()