(:: pragma bea:global-element-return element="ns0:ingresaCuentaBeneficio" location="../../IngresaCuentaBeneficio/xsd/ingresaCuentaBeneficioTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ingresaCuentaBeneficioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaCobranzaAutomatica/xq/ingresaGestionSFIn/";

declare function xf:ingresaGestionSFIn($ACCOUNT as xs:string,
    $LEGAL_ID as xs:string,
    $CUSTOMER_ID as xs:string,
    $CUSTOMER_NAME as xs:string,
    $BENEFIT as xs:string,
    $REASON as xs:string,
    $PLAN as xs:string,
    $MATTER as xs:string,
    $DESCRIPTION as xs:string,
    $MANAGEMENT as xs:string)
    as element(ns0:ingresaCuentaBeneficio) {
        <ns0:ingresaCuentaBeneficio>
            <PRODUCT>
                <ACCOUNT>{ $ACCOUNT }</ACCOUNT>
            </PRODUCT>
            <CLIENT>
                <LEGAL_ID>{ $LEGAL_ID }</LEGAL_ID>
                <CUSTOMER_ID>{ $CUSTOMER_ID }</CUSTOMER_ID>
                <FULL_NAME>{ $CUSTOMER_NAME }</FULL_NAME>
            </CLIENT>
            <BENEFIT>
                <TYPE>{ $BENEFIT }</TYPE>
            </BENEFIT>
            <REASON>{ $REASON }</REASON>
            <PLAN_TYPE>{ $PLAN }</PLAN_TYPE>
            <MATTER>{ $MATTER }</MATTER>
            <DESCRIPTION>{ $DESCRIPTION }</DESCRIPTION>
            <MANAGEMENT_TYPE>{ $MANAGEMENT }</MANAGEMENT_TYPE>
        </ns0:ingresaCuentaBeneficio>
};

declare variable $ACCOUNT as xs:string external;
declare variable $LEGAL_ID as xs:string external;
declare variable $CUSTOMER_ID as xs:string external;
declare variable $CUSTOMER_NAME as xs:string external;
declare variable $BENEFIT as xs:string external;
declare variable $REASON as xs:string external;
declare variable $PLAN as xs:string external;
declare variable $MATTER as xs:string external;
declare variable $DESCRIPTION as xs:string external;
declare variable $MANAGEMENT as xs:string external;

xf:ingresaGestionSFIn($ACCOUNT,
    $LEGAL_ID,
    $CUSTOMER_ID,
    $CUSTOMER_NAME,
    $BENEFIT,
    $REASON,
    $PLAN,
    $MATTER,
    $DESCRIPTION,
    $MANAGEMENT)
