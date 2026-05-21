<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetFICOPENTypes.xsd" ::)

declare variable $requestService as element() (:: schema-element(ns2:getFICOPEN) ::) external;
declare variable $tipoIdentificacion as xs:string external;
declare variable $numIdentificacion as xs:string external;

declare function local:funcGetFICOPENToCloudCode($requestService as element() (:: schema-element(ns2:getFICOPEN) ::), 
                                                 $tipoIdentificacion as xs:string, 
                                                 $numIdentificacion as xs:string) 
                                                 as element() (:: schema-element(ns1:getFICOPEN) ::) {
    <ns1:getFICOPEN>
        <codigoCuenta>{fn:data($requestService/CodeNumber)}</codigoCuenta>
        <fechaInicialConsulta>{fn:data($requestService/StartDate)}</fechaInicialConsulta>
        <fechaFinalConsulta>{fn:data($requestService/EndDate)}</fechaFinalConsulta>
    </ns1:getFICOPEN>
};

local:funcGetFICOPENToCloudCode($requestService, $tipoIdentificacion, $numIdentificacion)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_GetFICOPEN/Schemas/CloudCodeTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetFICOPENTypes.xsd">
            <con:schema ref="SBHN_Pension_GetFICOPEN/Schemas/GetFICOPENTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>