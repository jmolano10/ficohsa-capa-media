(:: pragma bea:local-element-complex-parameter parameter="$SourceRegionalDetails" type="RegionalDetails/SOURCE" location="../../ArtefactosGenerales/xsd/KeyValuePair.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v2/BusinessServices/ABKGT/aplicaCargoCuenta/xsd/AplicaCargoCuenta_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/AplicaCargoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/Debitos/xq/DebitGTIn/";

declare function xf:DebitGTIn($UserName as xs:string,
    $TransactionType as xs:string,
    $SourceAccount as xs:string,
    $Amount as xs:string,
    $CreditCardNumber as xs:string,
    $InterfaceReferenceNumber as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_NUMERO_CUENTA>{ $SourceAccount }</ns0:PN_NUMERO_CUENTA>
            <ns0:PN_REFERENCIA_INTERFAZ>{ $InterfaceReferenceNumber }</ns0:PN_REFERENCIA_INTERFAZ>
            <ns0:PN_MONTO>{ fn:number($Amount) }</ns0:PN_MONTO>
            <ns0:PV_CODIGO_TIPO_TRANSACCION>{ xs:integer($TransactionType) }</ns0:PV_CODIGO_TIPO_TRANSACCION>
            <ns0:PV_USUARIO_SERVICIO>{ $UserName }</ns0:PV_USUARIO_SERVICIO>
            <ns0:PV_DESCRIPCION>{ $CreditCardNumber }</ns0:PV_DESCRIPCION>
        </ns0:InputParameters>
};

declare variable $UserName as xs:string external;
declare variable $TransactionType as xs:string external;
declare variable $SourceAccount as xs:string external;
declare variable $Amount as xs:string external;
declare variable $CreditCardNumber as xs:string external;
declare variable $InterfaceReferenceNumber as xs:string external;

xf:DebitGTIn($UserName,
    $TransactionType,
    $SourceAccount,
    $Amount,
    $CreditCardNumber,
    $InterfaceReferenceNumber)
