xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultadesaldodeprestamoResponse1" element="ns0:ConsultadesaldodeprestamoResponse" location="../../../../Business_Resources/consultaGeneralPrestamo/Resources/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaGeneralPrestamo/xq/consultaPrestamoT24HeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:consultaPrestamoT24HeaderOut($consultadesaldodeprestamoResponse1 as element(ns0:ConsultadesaldodeprestamoResponse))
    as element(ns1:ResponseHeader) {
                if (fn:string($consultadesaldodeprestamoResponse1/Status/successIndicator/text()) = "Success" and 
            fn:string($consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CUSTOMERNAME/text()) != "") then (
            <ns1:ResponseHeader>
                {
                    for $successIndicator in $consultadesaldodeprestamoResponse1/Status/successIndicator
                    return
                    if(fn:upper-case(fn:string(data($successIndicator)))='SUCCESS')then (
                        <successIndicator>Success</successIndicator>
                    )else(
                        <successIndicator>{ data($successIndicator) }</successIndicator>
                    )
                }
                {
                    for $messages in $consultadesaldodeprestamoResponse1/Status/messages
                    return
                        <messages>{ data($messages) }</messages>
                }
            </ns1:ResponseHeader>
        ) else (
            <ns1:ResponseHeader>
                <successIndicator>ERROR</successIndicator>
                <messages>NO RECORDS RETURNED</messages>
            </ns1:ResponseHeader>
        )
};

declare variable $consultadesaldodeprestamoResponse1 as element(ns0:ConsultadesaldodeprestamoResponse) external;

xf:consultaPrestamoT24HeaderOut($consultadesaldodeprestamoResponse1)