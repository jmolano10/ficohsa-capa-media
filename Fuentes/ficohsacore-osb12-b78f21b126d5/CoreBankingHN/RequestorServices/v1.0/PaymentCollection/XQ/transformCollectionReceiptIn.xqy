xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/TransformCollectionReceipt";
(:: import schema at "../../../../ProviderServices/XSD/TransformCollectionReceipt/TransformCollectionReceipt_sp.xsd" ::)

declare variable $username as xs:string external;
declare variable $dealslip as xs:string external;

declare function local:func($username as xs:string, 
                            $dealslip as xs:string) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PV_USUARIO>{ $username }</ns1:PV_USUARIO>
        <ns1:PV_DEALSLIP>{ $dealslip }</ns1:PV_DEALSLIP>
    </ns1:InputParameters>
};

local:func($username, $dealslip)