(:: pragma bea:global-element-parameter parameter="$ecs1" element="ns0:ecs" location="../../wsdls/PagoTarjetaCreditoProxyCiti.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/RegistrarPagoTcProxyCiti/registraPagoTcProxyCiti_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraPagoTcProxyCiti";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCreditoProxyCiti/registrarRevTcProxyCitiIn/";

declare function xf:registrarRevTcProxyCitiIn($ecs1 as element(ns0:ecs),
    $uuid as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_UUID>{ $uuid }</ns1:PV_UUID>
            <ns1:PV_OPERACION>3</ns1:PV_OPERACION>
            {
                for $numero_cuenta in $ecs1/ns0:numero_cuenta
                return
                    <ns1:PN_NUMEROTARJETA>{ data($numero_cuenta) }</ns1:PN_NUMEROTARJETA>
            }
            {
                let $moneda := fn:string($ecs1/ns0:moneda/text())
                return
                    if ($moneda = ("1","LPS")) then (
                    	<ns1:PV_MONEDA>{ "HNL" }</ns1:PV_MONEDA>
                    ) else if ($moneda = "1") then (
                    	<ns1:PV_MONEDA>{ "USD" }</ns1:PV_MONEDA>
                    ) else (
                    	<ns1:PV_MONEDA>{ $moneda }</ns1:PV_MONEDA>
                    )
            }            
            <ns1:PN_MONTO>{ data($ecs1/ns0:total) }</ns1:PN_MONTO>
            <ns1:PV_SERVICIO>{ data($ecs1/ns0:servicio) }</ns1:PV_SERVICIO>
            {
                for $oficina in $ecs1/ns0:oficina
                return
                    <ns1:PV_OFICINA>{ data($oficina) }</ns1:PV_OFICINA>
            }
            {
                for $terminal in $ecs1/ns0:terminal
                return
                    <ns1:PV_TERMINAL>{ data($terminal) }</ns1:PV_TERMINAL>
            }
            {
                for $cajero in $ecs1/ns0:cajero
                return
                    <ns1:PV_CAJERO>{ data($cajero) }</ns1:PV_CAJERO>
            }
            {
                for $codigo_transaccion in $ecs1/ns0:codigo_transaccion
                return
                    <ns1:PV_CODTRANSACCION>{ data($codigo_transaccion) }</ns1:PV_CODTRANSACCION>
            }
            {
                for $numero_cuenta_cheque in $ecs1/ns0:numero_cuenta_cheque
                return
                    <ns1:PV_NUMEROCUENTA>{ data($numero_cuenta_cheque) }</ns1:PV_NUMEROCUENTA>
            }
            <ns1:PN_NUMEROCHEQUE>{ data($ecs1/ns0:numero_cheque) }</ns1:PN_NUMEROCHEQUE>            
            <ns1:PV_REFERENCIA>{ data($ecs1/ns0:out_referencia) }</ns1:PV_REFERENCIA>
            <ns1:PV_AUTORIZACION>{ data($ecs1/ns0:out_autorizacion) }</ns1:PV_AUTORIZACION>
            <ns1:PV_IDTRANSACCION/>
            <ns1:PV_ESTADO>A</ns1:PV_ESTADO>
        </ns1:InputParameters>
};

declare variable $ecs1 as element(ns0:ecs) external;
declare variable $uuid as xs:string external;

xf:registrarRevTcProxyCitiIn($ecs1,
    $uuid)