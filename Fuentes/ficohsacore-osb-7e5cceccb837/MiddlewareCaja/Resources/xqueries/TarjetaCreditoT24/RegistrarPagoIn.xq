(:: pragma bea:global-element-parameter parameter="$registrarPago" element="ns0:registrarPago" location="../../wsdls/Alcance.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/AplicaTCT24/ORA_BANK_T24_P_APLICA_TC.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/T24_P_APLICA_TC/";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/TarjetaCreditoT24/RegistrarPagoIn/";

declare function xf:RegistrarPagoIn($registrarPago as element(ns0:registrarPago))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_OPERACION>1</ns1:PN_OPERACION>
            <ns1:PN_MONTO>{ data($registrarPago/ns0:montoPago) }</ns1:PN_MONTO>
            <ns1:PN_NUM_TARJETA>{ data($registrarPago/ns0:noTarjetaCredito) }</ns1:PN_NUM_TARJETA>
            <ns1:PN_MONEDA>{ data($registrarPago/ns0:monedaPago) }</ns1:PN_MONEDA>
            <ns1:PN_FORMAPAGO>{ data($registrarPago/ns0:formaPago) }</ns1:PN_FORMAPAGO>
            <ns1:PN_CODIGOREVERSION/>
            {
                for $canalPago in $registrarPago/ns0:canalPago
                let $usuario := fn:tokenize(data($canalPago), " ")[2]
                return
                                                                                                                
                if(fn:empty($usuario)) then (
                <ns1:PV_CANAL>{ data($canalPago) }</ns1:PV_CANAL>
                )
                else (
                <ns1:PV_CANAL>{ $usuario }</ns1:PV_CANAL>
                )
                                
                                       
            }
            {
                for $fechaPago in $registrarPago/ns0:fechaPago
                return
                    <ns1:PV_FECHA>{ data($fechaPago) }</ns1:PV_FECHA>
            }
            <ns1:PV_FECHAEXP/>
            <ns1:PN_NUMREFERENCIA>{ data($registrarPago/ns0:idRefPago) }</ns1:PN_NUMREFERENCIA>
        </ns1:InputParameters>
};

declare variable $registrarPago as element(ns0:registrarPago) external;

xf:RegistrarPagoIn($registrarPago)