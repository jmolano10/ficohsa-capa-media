(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ATM/RegistrarClientePrestamo/xsd/registrarCliente_db_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarCliente_db";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPrestamoATM/xq/registrarClientePrestamo_dbIn/";

declare function xf:registrarClientePrestamo_dbIn($legalId as xs:string,
    $customerId as xs:string,
    $customerName as xs:string,
    $debitCard as xs:string,
    $debitAccount as xs:string,
    $extraAmount as xs:decimal,
    $extraRate as xs:decimal)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
        	<ns1:PV_DNI>{ fn-bea:trim(fn:data($legalId)) }</ns1:PV_DNI>
        	<ns1:PV_ID_CLIENTE>{ fn-bea:trim(fn:data($customerId)) }</ns1:PV_ID_CLIENTE>
        	<ns1:PV_NOMBRE_CLIENTE>{ fn-bea:trim(fn:data($customerName)) }</ns1:PV_NOMBRE_CLIENTE>
        	<ns1:PV_TARJETA_DEBITO>{ fn-bea:trim(fn:data($debitCard)) }</ns1:PV_TARJETA_DEBITO>
        	<ns1:PV_CUENTA_DEBITO>{ fn-bea:trim(fn:data($debitAccount)) }</ns1:PV_CUENTA_DEBITO>
            <ns1:PN_MONTO_EXTRA>{ $extraAmount }</ns1:PN_MONTO_EXTRA>
            <ns1:PN_TASA>{ $extraRate }</ns1:PN_TASA>
            <ns1:PV_MONEDA>HNL</ns1:PV_MONEDA>
        </ns1:InputParameters>
};

declare variable $legalId as xs:string external;
declare variable $customerId as xs:string external;
declare variable $customerName as xs:string external;
declare variable $debitCard as xs:string external;
declare variable $debitAccount as xs:string external;
declare variable $extraAmount as xs:decimal external;
declare variable $extraRate as xs:decimal external;

xf:registrarClientePrestamo_dbIn($legalId,
    $customerId,
    $customerName,
    $debitCard,
    $debitAccount,
    $extraAmount,
    $extraRate)