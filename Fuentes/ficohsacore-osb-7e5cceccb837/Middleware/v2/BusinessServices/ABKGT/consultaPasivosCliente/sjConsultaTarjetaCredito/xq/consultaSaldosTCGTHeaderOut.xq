(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaPasivosCliente/sjConsultaTarjetaCredito/consultaSaldosTarjetaCreditoHeaderOut/";

declare function xf:consultaSaldosTarjetaCreditoHeaderOut()
as element(ns0:ResponseHeader) {
    <ns0:ResponseHeader>
        <successIndicator>SUCCESS</successIndicator>
    </ns0:ResponseHeader>
};


xf:consultaSaldosTarjetaCreditoHeaderOut()