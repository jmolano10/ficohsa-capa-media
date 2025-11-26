(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../../../Middleware/v2/BusinessServices/MasterDataGT/obtenerTarjetaTitular/xsd/obtenerTarjetaTitular_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerTarjetaTitular";
declare namespace xf = "http://tempuri.org/MWCaja/v2/Resources/CreditCardOperations/CreditCardPayment/obtenerTarjetaTitularGTIn/";

declare function xf:obtenerTarjetaTitularGTIn($CardNumber as xs:string,
    $Org as xs:string,
    $Country as xs:string,
    $Type as xs:int)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $Country }</ns0:Pais>
            <ns0:Org>{ $Org }</ns0:Org>
            <ns0:Numero>{ $CardNumber }</ns0:Numero>
            <ns0:Tipo>{ $Type }</ns0:Tipo>
        </ns0:InputParameters>
};

declare variable $CardNumber as xs:string external;
declare variable $Org as xs:string external;
declare variable $Country as xs:string external;
declare variable $Type as xs:int external;


xf:obtenerTarjetaTitularGTIn($CardNumber,
    $Org,
    $Country,
    $Type)