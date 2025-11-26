(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns1:pagoTarjetaCredito" location="../../xsds/PagoTarjetaCredito/PagoTarjetaCredito.xsd" ::)
(:: pragma bea:global-element-return element="ns0:PagodeTarjetaCredito" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCredito";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCredito/pagoTarjetaCredito/";

declare function getT24DepositType ($genericDepositType as xs:string,$currency as xs:string)  as xs:string { 
	if ($genericDepositType = "CASH") then (
		if ($currency = "HNL") then (
			"TC.MN.MN"
		) else (
			"TC.VARIASMND.ME"
		)
	) else if (data($genericDepositType) = "OWN_CHEQUE") then (
		"FICO.CHQ"
	) else if (data($genericDepositType) = "CLEARING") then (
		"CLEARING"
	) else if (data($genericDepositType) = "INTL_CHQ_US") then (
		"CLEARING.INTL"
	) else (
		"COLL.INTL"
	)
 };

declare function xf:PagoTarjetaCreditoIn($pagoTarjetaCredito as element(ns1:pagoTarjetaCredito),
    $password as xs:string,
    $userName as xs:string,
    $customerId as xs:string,
    $uuid as xs:string)
    as element(ns0:PagodeTarjetaCredito) {
        <ns0:PagodeTarjetaCredito>
            <WebRequestCommon>
                <userName>{ $userName }</userName>
                <password>{ $password }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
            </OfsFunction>
            <TELLERFINANCIALSERVICESFICOCCARDPAYMENTWSType>
                <gTRANSACTION>
                    <mTRANSACTION>
                        <Transaction>{ getT24DepositType(data($pagoTarjetaCredito/PAYMENT_METHOD), data($pagoTarjetaCredito/PAYMENT_CURRENCY)) }</Transaction>
                        {
                            for $DEBIT_ACCOUNT in $pagoTarjetaCredito/DEBIT_ACCOUNT
                            return
                                <SurrogateAccount>{ data($DEBIT_ACCOUNT) }</SurrogateAccount>
                        }
                        <Currency>{ data($pagoTarjetaCredito/PAYMENT_CURRENCY) }</Currency>
                        <Amount>{ data($pagoTarjetaCredito/PAYMENT_AMOUNT) }</Amount>
                        {
                            for $BANK_CODE in $pagoTarjetaCredito/BANK_CODE
                            return
                                <SortCode>{ data($BANK_CODE) }</SortCode>
                        }
                        {
                            for $CHEQUE_NUMBER in $pagoTarjetaCredito/CHEQUE_NUMBER
                            return
                                <ChequeNumber>{ data($CHEQUE_NUMBER) }</ChequeNumber>
                        }
                    </mTRANSACTION>
                </gTRANSACTION>
                <CREDITCARDNUM>{ data($pagoTarjetaCredito/CREDIT_CARD_NUMBER) }</CREDITCARDNUM>
                <LRCRCCY>{ data($pagoTarjetaCredito/BALANCE_CURRENCY) }</LRCRCCY>
                <LRAMTPAY>Other Amt</LRAMTPAY>
                {
                    for $DEPOSITOR_NAME in $pagoTarjetaCredito/DEPOSITOR_NAME
                    return
                        <PANNO>{ data($DEPOSITOR_NAME) }</PANNO>
                }
                <gLR.ECONOMIC.ACT>
                    <mLR.ECONOMIC.ACT>
                        <CLIENTID>{ $customerId }</CLIENTID>
                    </mLR.ECONOMIC.ACT>
                </gLR.ECONOMIC.ACT>
                {
                    for $DEPOSITOR_ID in $pagoTarjetaCredito/DEPOSITOR_ID
                    return
                        <LRFICOIDDEPO>{ data($DEPOSITOR_ID) }</LRFICOIDDEPO>
                }
                {
                    for $CHANNEL in $pagoTarjetaCredito/CHANNEL
                    return
                        <LRCHANNELID>{ '' }</LRCHANNELID>
                }
            </TELLERFINANCIALSERVICESFICOCCARDPAYMENTWSType>
        </ns0:PagodeTarjetaCredito>
};

declare variable $pagoTarjetaCredito as element(ns1:pagoTarjetaCredito) external;
declare variable $password as xs:string external;
declare variable $userName as xs:string external;
declare variable $customerId as xs:string external;
declare variable $uuid as xs:string external;

xf:PagoTarjetaCreditoIn($pagoTarjetaCredito,
    $password,
    $userName,
    $customerId,
    $uuid)