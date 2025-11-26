(:: pragma bea:global-element-parameter parameter="$PagoTarjetaCreditoBody" element="ns1:pagoTarjetaCredito" location="../../xsds/PagoTarjetaCredito/PagoTarjetaCredito.xsd" ::)
(:: pragma bea:global-element-return element="ns0:PagodeTCenefectivoCaja" location="../../xsds/PagoTarjetaCreditoCaja_Efectivo/PagoTarjetaCreditoCaja_Efectivo.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCredito";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCredito/PagoTarjetaCreditoCaja_Efectivo/";

declare function xf:PagoTarjetaCreditoCaja_Efectivo($PagoTarjetaCreditoBody as element(ns1:pagoTarjetaCredito),
    $UserName as xs:string,
    $Password as xs:string,
    $CodigoClienteCuenta as xs:string,
    $UUID as xs:string)
    as element(ns0:PagodeTCenefectivoCaja) {
        <ns0:PagodeTCenefectivoCaja>
            <WebRequestCommon>
                <userName>{ $UserName }</userName>
                <password>{ $Password }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $UUID }</messageId>
            </OfsFunction>
            <TELLERFICOCCARDPAYMENTTTWSType>
                <gACCOUNT1>
                    <mACCOUNT1>
                    	{	
	                    	if (data($PagoTarjetaCreditoBody/PAYMENT_CURRENCY) = "HNL") then 
	                    	(<OtherAmount>{ data($PagoTarjetaCreditoBody/PAYMENT_AMOUNT) }</OtherAmount>)
	                        else
	                        (<AmountForeign>{ data($PagoTarjetaCreditoBody/PAYMENT_AMOUNT) }</AmountForeign>)
                        }
                    </mACCOUNT1>
                </gACCOUNT1>
                <Currency>{ data($PagoTarjetaCreditoBody/PAYMENT_CURRENCY) }</Currency>
                <CLIENTID>{ $CodigoClienteCuenta }</CLIENTID>
                <LRCRTCARDNUM>{ data($PagoTarjetaCreditoBody/CREDIT_CARD_NUMBER) }</LRCRTCARDNUM>
                <LRCCARDCCY>{ data($PagoTarjetaCreditoBody/BALANCE_CURRENCY) }</LRCCARDCCY>
            </TELLERFICOCCARDPAYMENTTTWSType>
        </ns0:PagodeTCenefectivoCaja>
};

declare variable $PagoTarjetaCreditoBody as element(ns1:pagoTarjetaCredito) external;
declare variable $UserName as xs:string external;
declare variable $Password as xs:string external;
declare variable $CodigoClienteCuenta as xs:string external;
declare variable $UUID as xs:string external;

xf:PagoTarjetaCreditoCaja_Efectivo($PagoTarjetaCreditoBody,
    $UserName,
    $Password,
    $CodigoClienteCuenta,
    $UUID)
