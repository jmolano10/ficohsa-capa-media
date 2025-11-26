(:: pragma bea:global-element-parameter parameter="$PagoTarjetaCreditoBody" element="ns1:pagoTarjetaCredito" location="../../xsds/PagoTarjetaCredito/PagoTarjetaCredito.xsd" ::)
(:: pragma bea:global-element-return element="ns0:PagodeTCenchqlocalCaja" location="../../xsds/PagoTarjetaCreditoCaja_ChqLocal/PagoTarjetaCreditoCaja_ChqLocal.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCredito";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCredito/PagoTarjetaCreditoCaja_ChqLocal/";

declare function xf:PagoTarjetaCreditoCaja_ChqLocal($UserName as xs:string,
    $Password as xs:string,
    $CodigoClienteCuenta as xs:string,
    $UUID as xs:string,
    $PagoTarjetaCreditoBody as element(ns1:pagoTarjetaCredito))
    as element(ns0:PagodeTCenchqlocalCaja) {
        <ns0:PagodeTCenchqlocalCaja>
            <WebRequestCommon>
                <userName>{ $UserName }</userName>
                <password>{ $Password }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $UUID }</messageId>
            </OfsFunction>
            <TELLERFICOCCARDPAYCHQLOCALWSType>
                <CurrencyAcctDebit>{ data($PagoTarjetaCreditoBody/PAYMENT_CURRENCY) }</CurrencyAcctDebit>
				<gACCOUNT1>
                    <mACCOUNT1>
						{	
	                    	if (data($PagoTarjetaCreditoBody/PAYMENT_CURRENCY) = "HNL") then 
	                    	(<OtherAmount>{ data($PagoTarjetaCreditoBody/PAYMENT_AMOUNT) }</OtherAmount>)
	                        else
	                        (<AmountUSD>{ data($PagoTarjetaCreditoBody/PAYMENT_AMOUNT) }</AmountUSD>)
                        }     
                    </mACCOUNT1>
                </gACCOUNT1>         
                <Currency>{ data($PagoTarjetaCreditoBody/PAYMENT_CURRENCY) }</Currency>
                <gCHEQUENUMBER>
                    <mCHEQUENUMBER>
                        {
                            for $CHEQUE_NUMBER in $PagoTarjetaCreditoBody/CHEQUE_NUMBER
                            return
                                <ChequeNumber>{ data($CHEQUE_NUMBER) }</ChequeNumber>
                        }
                        {
                            for $BANK_CODE in $PagoTarjetaCreditoBody/BANK_CODE
                            return
                                <SortCode>{ data($BANK_CODE) }</SortCode>
                        }
                    </mCHEQUENUMBER>
                </gCHEQUENUMBER>
                <LRCRTCARDNUM>{ data($PagoTarjetaCreditoBody/CREDIT_CARD_NUMBER) }</LRCRTCARDNUM>
                <LRCCARDCCY>{ data($PagoTarjetaCreditoBody/BALANCE_CURRENCY) }</LRCCARDCCY>
            </TELLERFICOCCARDPAYCHQLOCALWSType>
        </ns0:PagodeTCenchqlocalCaja>
};

declare variable $UserName as xs:string external;
declare variable $Password as xs:string external;
declare variable $CodigoClienteCuenta as xs:string external;
declare variable $UUID as xs:string external;
declare variable $PagoTarjetaCreditoBody as element(ns1:pagoTarjetaCredito) external;

xf:PagoTarjetaCreditoCaja_ChqLocal($UserName,
    $Password,
    $CodigoClienteCuenta,
    $UUID,
    $PagoTarjetaCreditoBody)
