xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaProductoBeneficios" location="../xsd/consultaProductoBeneficiosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaProductoBeneficiosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoBeneficio/xq/consultaTRCBeneIn/";

declare function xf:consultaTRCBeneIn($TYPE as xs:string,
    $VALUE as xs:string,
    $BENEFIT as xs:string,
    $REGION as xs:string)
    as element(ns0:consultaProductoBeneficios) {
        <ns0:consultaProductoBeneficios>
            <PRODUCTS>
                <PRODUCT>
                    <TYPE>{ $TYPE }</TYPE>
                    <VALUE>{ $VALUE }</VALUE>
                    <BENEFIT>{ $BENEFIT }</BENEFIT>
                    <REGION>{ $REGION }</REGION>
                </PRODUCT>
            </PRODUCTS>
        </ns0:consultaProductoBeneficios>
};

declare variable $TYPE as xs:string external;
declare variable $VALUE as xs:string external;
declare variable $BENEFIT as xs:string external;
declare variable $REGION as xs:string external;

xf:consultaTRCBeneIn($TYPE,
    $VALUE,
    $BENEFIT,
    $REGION)