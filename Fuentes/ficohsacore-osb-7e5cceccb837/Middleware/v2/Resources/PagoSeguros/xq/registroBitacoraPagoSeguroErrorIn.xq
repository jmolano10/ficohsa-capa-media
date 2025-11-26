(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CNV/registroBitacoraPagoSeguro/xsd/RegistroBitacoraPagoSeguro_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/RegistroBitacoraPagoSeguro";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoSeguros/xq/registroBitacoraPagoSeguroError/";

declare function xf:registroBitacoraPagoSeguroError($uuid as xs:string,
    $cuenta as xs:string,
    $poliza as xs:string,
    $pagoSeguroRequest as xs:string,
    $mensajeError as xs:string)
    as element(ns0:InputParameters) {
         <ns0:InputParameters>
            <ns0:PV_UUID>{ $uuid }</ns0:PV_UUID>
            <ns0:PV_CUENTA>{ $cuenta }</ns0:PV_CUENTA>
            <ns0:PV_POLIZA>{ $poliza }</ns0:PV_POLIZA>
            <ns0:PC_REQUEST>{ $pagoSeguroRequest }</ns0:PC_REQUEST>
            <ns0:PC_RESPONSE>{ $pagoSeguroRequest }</ns0:PC_RESPONSE>
            <ns0:PV_PRODUCT></ns0:PV_PRODUCT>
            <ns0:PV_CREDICT_ACCOUNT></ns0:PV_CREDICT_ACCOUNT>
            <ns0:PV_PAYMENT_CURRENCY></ns0:PV_PAYMENT_CURRENCY>
            <ns0:PV_PAYMENT_AMOUNT></ns0:PV_PAYMENT_AMOUNT>    
            <ns0:PV_STATUS>N</ns0:PV_STATUS>            
            <ns0:PV_MESSAGE_ERROR>{ $mensajeError }</ns0:PV_MESSAGE_ERROR>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $cuenta as xs:string external;
declare variable $poliza as xs:string external;
declare variable $pagoSeguroRequest as xs:string external;
declare variable $mensajeError as xs:string external;

xf:registroBitacoraPagoSeguroError($uuid,
    $cuenta,
    $poliza,
    $pagoSeguroRequest,
    $mensajeError)