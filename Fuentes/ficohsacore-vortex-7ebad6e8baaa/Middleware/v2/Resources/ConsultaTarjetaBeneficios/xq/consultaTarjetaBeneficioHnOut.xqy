xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaProductoBeneficiosResponse" location="../../ConsultaProductoBeneficio/xsd/consultaProductoBeneficiosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaProductoBeneficiosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTarjetaBeneficios/xq/consultaTarjetaBeneficioHnOut/";

declare function xf:consultaTarjetaBeneficioHnOut(
    $number as xs:string,
    $apply_benift as xs:string)
    as element(ns0:consultaProductoBeneficiosResponse) {
        <ns0:consultaProductoBeneficiosResponse>
            <PRODUCTS>
                <PRODUCT>
                    <TYPE>TRC</TYPE>
                    <VALUE>{ data($number) }</VALUE>
                    <BENEFIT>PAF</BENEFIT>
                    <APPLY_BENEFIT>{ data($apply_benift) }</APPLY_BENEFIT>
                </PRODUCT>
            </PRODUCTS>
        </ns0:consultaProductoBeneficiosResponse>
};


declare variable $number as xs:string external;
declare variable $apply_benift as xs:string external;

xf:consultaTarjetaBeneficioHnOut(
    $number,
    $apply_benift)