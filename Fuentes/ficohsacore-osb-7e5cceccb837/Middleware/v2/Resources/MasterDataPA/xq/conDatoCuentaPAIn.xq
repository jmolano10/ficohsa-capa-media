(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataPA/conDatoCuenta/xsd/conDatoCuenta_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataPA/xq/conDatoCuentaPAIn/";

declare function xf:conDatoCuentaPAIn($countryCode as xs:string,
    $org as xs:string,
    $accountNumber as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $countryCode }</ns0:Pais>
            {
            	if($org != "")then(
            		<ns0:Org>{ $org }</ns0:Org>
            	)else()
            }
            <ns0:NumCuenta>{ fn-bea:pad-left($accountNumber, 19, '0') }</ns0:NumCuenta>
        </ns0:InputParameters>
};

declare variable $countryCode as xs:string external;
declare variable $org as xs:string external;
declare variable $accountNumber as xs:string external;

xf:conDatoCuentaPAIn($countryCode,
    $org,
    $accountNumber)