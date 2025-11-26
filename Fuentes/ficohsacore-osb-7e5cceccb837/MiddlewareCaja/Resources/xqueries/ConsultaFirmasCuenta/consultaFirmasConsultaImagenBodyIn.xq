(:: pragma bea:global-element-parameter parameter="$consultaImagenFirmas1" element="ns0:consultaImagenFirmas" location="../../xsds/ConsultaImagenFirmas/consultaImagenFirmasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaImagenFirmas" location="../../../../Middleware/Business_Resources/consultasImagen/ConsultaImagenFirmas/consultaImagenFirmasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaImagenFirmasTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaFirmasCuenta/consultaFirmasConsultaImagenBodyIn/";

declare function xf:consultaFirmasConsultaImagenBodyIn($consultaImagenFirmas1 as element(ns0:consultaImagenFirmas))
    as element(ns0:consultaImagenFirmas) {
        <ns0:consultaImagenFirmas>
            <ACCOUNT_NUMBER>{ data($consultaImagenFirmas1/ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
        </ns0:consultaImagenFirmas>
};

declare variable $consultaImagenFirmas1 as element(ns0:consultaImagenFirmas) external;

xf:consultaFirmasConsultaImagenBodyIn($consultaImagenFirmas1)