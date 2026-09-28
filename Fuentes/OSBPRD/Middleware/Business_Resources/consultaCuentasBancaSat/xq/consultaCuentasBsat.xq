(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../v2/BusinessServices/ABKGT/consultaListaCuentas/xsd/consultaListaCuentas_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaCuentas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/consultaCuentasBancaSat/xq/consultaCuentasBsat/";

declare function xf:consultaCuentasBsat($customerId as xs:string,
    $assetType as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CUSTOMER_ID>{ $customerId }</ns1:PV_CUSTOMER_ID>
            <ns1:PV_ASSET_TYPE>{ $assetType }</ns1:PV_ASSET_TYPE>
        </ns1:InputParameters>
};

declare variable $customerId as xs:string external;
declare variable $assetType as xs:string external;

xf:consultaCuentasBsat($customerId,
    $assetType)