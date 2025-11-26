(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/osbConSaldosTCOffLine/xsd/osbConSaldosTCOffLine_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConSaldosTCOffLine";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/osbConSaldosTCOffLineIn/";

declare function xf:osbConSaldosTCOffLineIn($cardNumber as xs:string,
    $org as xs:string,
    $country as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $country }</ns0:Pais>
            <ns0:Org>{ $org }</ns0:Org>
            <ns0:NumTarjeta>{ $cardNumber }</ns0:NumTarjeta>
        </ns0:InputParameters>
};

declare variable $cardNumber as xs:string external;
declare variable $org as xs:string external;
declare variable $country as xs:string external;

xf:osbConSaldosTCOffLineIn($cardNumber,
    $org,
    $country)