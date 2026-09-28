xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaPasivosCliente/sjConsultaTarjetaCreditoAll/consultaListaPasivosAllHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";

declare function xf:consultaListaPasivosAllHeaderOut()
as element(ns0:ResponseHeader) {
       <ns0:ResponseHeader>
        <successIndicator>SUCCESS</successIndicator>
    </ns0:ResponseHeader>
};


xf:consultaListaPasivosAllHeaderOut()