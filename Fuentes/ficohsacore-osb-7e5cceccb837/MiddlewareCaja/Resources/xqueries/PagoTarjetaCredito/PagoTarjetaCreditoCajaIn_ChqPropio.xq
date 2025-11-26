(:: pragma bea:global-element-parameter parameter="$PagoTarjetaCreditoBody" element="ns1:pagoTarjetaCredito" location="../../xsds/PagoTarjetaCredito/PagoTarjetaCredito.xsd" ::)
(:: pragma bea:global-element-return element="ns0:PagodeTCenchqpropioCaja" location="../../xsds/PagoTarjetaCreditoCaja_ChqPropio/PagoTarjetaCreditoCaja_ChqPropio.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCredito";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCredito/PagoTarjetaCreditoCajaIn_ChqPropio/";

declare function xf:PagoTarjetaCreditoCajaIn_ChqPropio($UserName as xs:string,
    $Password as xs:string,
    $CodigoClienteCuenta as xs:string,
    $UUID as xs:string,
    $PagoTarjetaCreditoBody as element(ns1:pagoTarjetaCredito))
    as element(ns0:PagodeTCenchqpropioCaja) {
        <ns0:PagodeTCenchqpropioCaja>
            <WebRequestCommon>
                <userName>{ $UserName }</userName>
                <password>{ $Password }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $UUID }</messageId>
            </OfsFunction>
            <TELLERFICOCCARDPAYOWNCHQWSType>
                <gACCOUNT1>
                    <mACCOUNT1>
                        {
                            for $DEBIT_ACCOUNT in $PagoTarjetaCreditoBody/DEBIT_ACCOUNT
                            return
                                <SurrogateAccount>{ data($DEBIT_ACCOUNT) }</SurrogateAccount>
                        }
						{	
	                    	if (data($PagoTarjetaCreditoBody/PAYMENT_CURRENCY) = "HNL") then 
	                    	(<OtherAmount>{ data($PagoTarjetaCreditoBody/PAYMENT_AMOUNT) }</OtherAmount>)
	                        else
	                        (<AmountUSD>{ data($PagoTarjetaCreditoBody/PAYMENT_AMOUNT) }</AmountUSD>)
                        }     
                    </mACCOUNT1>
                </gACCOUNT1>
                <Currency>{ data($PagoTarjetaCreditoBody/PAYMENT_CURRENCY) }</Currency>
                {
                    for $DEBIT_ACCOUNT in $PagoTarjetaCreditoBody/DEBIT_ACCOUNT
                    return
                        <PrimaryAccount>{ data($DEBIT_ACCOUNT) }</PrimaryAccount>
                }
                <gCHEQUENUMBER>
                    <mCHEQUENUMBER>
                        {
                            for $CHEQUE_NUMBER in $PagoTarjetaCreditoBody/CHEQUE_NUMBER
                            return
                                <ChequeNumber>{ data($CHEQUE_NUMBER) }</ChequeNumber>
                        }
                    </mCHEQUENUMBER>
                </gCHEQUENUMBER>
                <LRCRTCARDNUM>{ data($PagoTarjetaCreditoBody/CREDIT_CARD_NUMBER) }</LRCRTCARDNUM>
                <LRCCARDCCY>{ data($PagoTarjetaCreditoBody/BALANCE_CURRENCY) }</LRCCARDCCY>
            </TELLERFICOCCARDPAYOWNCHQWSType>
        </ns0:PagodeTCenchqpropioCaja>
};

declare variable $UserName as xs:string external;
declare variable $Password as xs:string external;
declare variable $CodigoClienteCuenta as xs:string external;
declare variable $UUID as xs:string external;
declare variable $PagoTarjetaCreditoBody as element(ns1:pagoTarjetaCredito) external;

xf:PagoTarjetaCreditoCajaIn_ChqPropio($UserName,
    $Password,
    $CodigoClienteCuenta,
    $UUID,
    $PagoTarjetaCreditoBody)
