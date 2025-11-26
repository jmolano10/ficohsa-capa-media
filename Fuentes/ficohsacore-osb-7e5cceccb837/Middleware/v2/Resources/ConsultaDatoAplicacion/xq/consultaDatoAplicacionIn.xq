(:: pragma bea:global-element-return element="ns0:consultaDatoAplicacion" location="../xsd/consultaDatoAplicacionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatoAplicacionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatoAplicacion/xq/consultaDatoCreditScoreIn/";

declare function xf:consultaDatoCreditScoreIn($applicationName as xs:string,
    $dataIdentifier as xs:string)
    as element(ns0:consultaDatoAplicacion) {
        <ns0:consultaDatoAplicacion>
            <ns0:APPLICATION_NAME>{ $applicationName }</ns0:APPLICATION_NAME>
            <ns0:DATA_IDENTIFIER>{ $dataIdentifier }</ns0:DATA_IDENTIFIER>
        </ns0:consultaDatoAplicacion>
};

declare variable $applicationName as xs:string external;
declare variable $dataIdentifier as xs:string external;

xf:consultaDatoCreditScoreIn($applicationName,
    $dataIdentifier)
