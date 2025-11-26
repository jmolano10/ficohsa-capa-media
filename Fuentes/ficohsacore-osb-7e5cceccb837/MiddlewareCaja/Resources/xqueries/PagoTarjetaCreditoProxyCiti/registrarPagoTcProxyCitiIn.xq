(:: pragma bea:global-element-parameter parameter="$ecs1" element="ns1:ecs" location="../../wsdls/PagoTarjetaCreditoProxyCiti.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../xsds/General/obtenerSecuencia/obtenerSecuencia_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../xsds/RegistrarPagoTcProxyCiti/registraPagoTcProxyCiti_sp.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraPagoTcProxyCiti";
declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerSecuencia";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistrarPagoTcProxyCiti/registrarPagoTcProxyCitiIn/";

declare function xf:registrarPagoTcProxyCitiIn($ecs1 as element(ns1:ecs),
    $outputParameters1 as element(ns0:OutputParameters), 
    $uuid as xs:string,
    $transactionId as xs:string,
    $cardHolderName as xs:string,
    $cardHolnderLegalId as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
			<ns2:PV_UUID>{ $uuid }</ns2:PV_UUID> 
            <ns2:PV_OPERACION>2</ns2:PV_OPERACION>
            {
                for $numero_cuenta in $ecs1/ns1:numero_cuenta
                return
                    <ns2:PN_NUMEROTARJETA>{ data($numero_cuenta) }</ns2:PN_NUMEROTARJETA>
            }
            {
                let $moneda := fn:string($ecs1/ns1:moneda/text())
                return
                    if ($moneda = ("1","LPS")) then (
                    	<ns2:PV_MONEDA>{ "HNL" }</ns2:PV_MONEDA>
                    ) else if ($moneda = "2") then (
                    	<ns2:PV_MONEDA>{ "USD" }</ns2:PV_MONEDA>
                    ) else (
                    	<ns2:PV_MONEDA>{ $moneda }</ns2:PV_MONEDA>
                    )
            }
            <ns2:PN_MONTO>{ data($ecs1/ns1:total) }</ns2:PN_MONTO>
            <ns2:PV_SERVICIO>{ data($ecs1/ns1:servicio) }</ns2:PV_SERVICIO>
            {
                for $oficina in $ecs1/ns1:oficina
                return
                    <ns2:PV_OFICINA>{ data($oficina) }</ns2:PV_OFICINA>
            }
            {
                for $terminal in $ecs1/ns1:terminal
                return
                    <ns2:PV_TERMINAL>{ data($terminal) }</ns2:PV_TERMINAL>
            }
            {
                for $cajero in $ecs1/ns1:cajero
                return
                    <ns2:PV_CAJERO>{ data($cajero) }</ns2:PV_CAJERO>
            }
            {
                for $codigo_transaccion in $ecs1/ns1:codigo_transaccion
                return
                    <ns2:PV_CODTRANSACCION>{ data($codigo_transaccion) }</ns2:PV_CODTRANSACCION>
            }
            {
                for $numero_cuenta_cheque in $ecs1/ns1:numero_cuenta_cheque
                return
                    <ns2:PV_NUMEROCUENTA>{ data($numero_cuenta_cheque) }</ns2:PV_NUMEROCUENTA>
            }
            <ns2:PN_NUMEROCHEQUE>{ data($ecs1/ns1:numero_cheque) }</ns2:PN_NUMEROCHEQUE>
            <ns2:PV_REFERENCIA>{ fn:string($ecs1/ns1:out_referencia/text()) }</ns2:PV_REFERENCIA>
            {
                for $PV_SECUENCIA in $outputParameters1/ns0:PV_SECUENCIA
                return
                    <ns2:PV_AUTORIZACION>{ data($PV_SECUENCIA) }</ns2:PV_AUTORIZACION>
            }
            <ns2:PV_IDTRANSACCION>{ $transactionId }</ns2:PV_IDTRANSACCION>
            <ns2:PV_ESTADO>A</ns2:PV_ESTADO>
            <ns2:PV_NOMBRECLIENTE>{ $cardHolderName }</ns2:PV_NOMBRECLIENTE>
            <ns2:PV_IDENTIDADCLIENTE>{ $cardHolnderLegalId }</ns2:PV_IDENTIDADCLIENTE>
        </ns2:InputParameters>
};

declare variable $ecs1 as element(ns1:ecs) external;
declare variable $outputParameters1 as element(ns0:OutputParameters) external;
declare variable $uuid as xs:string external;
declare variable $transactionId as xs:string external;
declare variable $cardHolderName as xs:string external;
declare variable $cardHolnderLegalId as xs:string external;

xf:registrarPagoTcProxyCitiIn($ecs1,
    $outputParameters1,
    $uuid,
    $transactionId,
    $cardHolderName,
    $cardHolnderLegalId)