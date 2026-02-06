xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/PMSV/validaAccesoPMS/xsd/validaAccesoPMS_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaAccesoPMS";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivos/xq/validarAccesoPMSIn/";

declare function xf:validarAccesoPMSIn($CUSTOMER_ID as xs:string,
    $USER_NAME as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CUSTOMER_ID>{ $CUSTOMER_ID }</ns0:CUSTOMER_ID>
            <ns0:USER_NAME>{ $USER_NAME }</ns0:USER_NAME>
        </ns0:InputParameters>
};

declare variable $CUSTOMER_ID as xs:string external;
declare variable $USER_NAME as xs:string external;

xf:validarAccesoPMSIn($CUSTOMER_ID,
    $USER_NAME)