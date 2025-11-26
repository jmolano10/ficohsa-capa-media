xquery version "1.0" encoding "Cp1252";
(:: pragma  parameter="$ResponseParameters" type="xs:anyType" ::)
(:: pragma bea:global-element-return element="ns0:reversarPagoResponse" location="../../wsdls/Alcance.wsdl" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/TarjetaCreditoT24/ReversarPagoCitiOut/";
declare namespace ns0 = "http://tempuri.org/";

declare function xf:ReversarPagoCitiOut($ResponseParameters as element(*))
    as element(ns0:reversarPagoResponse) {
        <ns0:reversarPagoResponse>
            
                {
                    for $ITEM at $i in $ResponseParameters
					return
					<ns0:reversarPagoResult>
                        <ns0:estatusConfirmacion>{ data($ITEM/errorCode) }</ns0:estatusConfirmacion>
                        <ns0:mensajeConfirmacion>{ data($ITEM/errorMessage) }</ns0:mensajeConfirmacion>
                    </ns0:reversarPagoResult>
                }
                
            
        </ns0:reversarPagoResponse>
};

declare variable $ResponseParameters as element(*) external;

xf:ReversarPagoCitiOut($ResponseParameters)