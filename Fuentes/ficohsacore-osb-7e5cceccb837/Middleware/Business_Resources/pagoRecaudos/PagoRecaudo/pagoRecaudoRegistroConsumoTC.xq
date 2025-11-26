(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo1" element="ns0:pagoRecaudo" location="pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsumoNOR" location="../../../v2/BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoRegistroConsumoTCNuevo/";

declare function xf:pagoRecaudoRegistroConsumoTCNuevo($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $pagoRecaudo1 as element(ns0:pagoRecaudo),
    $purchaseDescription as xs:string,
    $purchaseRefNumber as xs:string)
    as element(ns1:ConsumoNOR) {
        <ns1:ConsumoNOR>
            {
                for $CREDIT_CARD_NUMBER in $pagoRecaudo1/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                return
                    <ns1:noTarjetaCredito>{ data($CREDIT_CARD_NUMBER) }</ns1:noTarjetaCredito>
            }
            {
                for $EXPIRATION_DATE in $pagoRecaudo1/PAYMENT_INFORMATION/EXPIRATION_DATE
                return
                    <ns1:FechaExpiracion>{ data($EXPIRATION_DATE) }</ns1:FechaExpiracion>
            }
            <ns1:montoConsumo>{ fn:string($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_AMOUNT/text()) }</ns1:montoConsumo>
            <ns1:monedaConsumo>{
            	 let $PAYMENT_CURRENCY := fn:string($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_CURRENCY/text())
            	return
            	if ($PAYMENT_CURRENCY = "HNL") then (
            		340
            	) else if ($PAYMENT_CURRENCY = "USD") then (
            		840
            	) else (
            		0
            	)
								}
            </ns1:monedaConsumo>
            <ns1:DescripcionConsumo>{ fn:substring($purchaseDescription,1,25) }</ns1:DescripcionConsumo>
            <ns1:canalConsumo>1</ns1:canalConsumo>
            <ns1:fechaConsumo>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn:current-date()) }</ns1:fechaConsumo>
            <ns1:idRefConsumo>{ $purchaseRefNumber }</ns1:idRefConsumo>
        </ns1:ConsumoNOR>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRecaudo1 as element(ns0:pagoRecaudo) external;
declare variable $purchaseDescription as xs:string external;
declare variable $purchaseRefNumber as xs:string external;

xf:pagoRecaudoRegistroConsumoTCNuevo($autenticacionRequestHeader1,
    $pagoRecaudo1,
    $purchaseDescription,
    $purchaseRefNumber)