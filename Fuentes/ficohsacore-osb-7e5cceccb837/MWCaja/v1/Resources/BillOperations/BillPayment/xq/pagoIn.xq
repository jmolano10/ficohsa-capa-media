(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../../BusinessServices/AbanksGT/PagoPolizaSeguro/xsd/MCPagoPolizaSeguro_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pago" location="../../../../BusinessServices/SegurosGT/PagoSeguro/wsdl/pagoBancoPS.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCPagoPolizaSeguro";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/BillOperations/BillPayment/xq/pagoIn/";

declare function xf:pagoIn($outputParameters as element(ns1:OutputParameters),
    $parameter as xs:string,
    $nroRecibido as xs:string)
    as element(ns0:Pago) {
        <ns0:Pago>
            <ns0:cod_identifica_banco>{ data($parameter) }</ns0:cod_identifica_banco>
            <ns0:nro_recibo>{ data($nroRecibido) }</ns0:nro_recibo>
            <ns0:moneda>
            {                                        
                               if(upper-case(data($outputParameters/ns1:PR_TRANSACTION_INFO/ns1:CURRENCY)) = 'GTQ') then(
                                   'Q'
                                   )elseif(upper-case(data($outputParameters/ns1:PR_TRANSACTION_INFO/ns1:CURRENCY)) = 'USD') then(
                                    'US'
                                    )else()
             }
             </ns0:moneda>
            <ns0:monto>{ data($outputParameters/ns1:PR_TRANSACTION_INFO/ns1:AMOUNT) }</ns0:monto>
            <ns0:monto_pagar>{ data($outputParameters/ns1:PR_TRANSACTION_INFO/ns1:AMOUNT) }</ns0:monto_pagar>
            <ns0:fecha>{ fn-bea:date-to-string-with-format("dd/MM/yyyy",fn:current-date()) }</ns0:fecha>
            <ns0:hora>{ fn-bea:time-to-string-with-format("HH:mm",fn:current-time())  }</ns0:hora>
            <ns0:nro_referencias>{ data($outputParameters/ns1:PR_TRANSACTION_INFO/ns1:TXN_REF_ID) }</ns0:nro_referencias>
            <ns0:tasa_cambio>{ data($outputParameters/ns1:PN_TASA_DE_CAMBIO) }</ns0:tasa_cambio>
        </ns0:Pago>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $parameter as xs:string external;
declare variable $nroRecibido as xs:string external;

xf:pagoIn($outputParameters,
    $parameter,
    $nroRecibido)