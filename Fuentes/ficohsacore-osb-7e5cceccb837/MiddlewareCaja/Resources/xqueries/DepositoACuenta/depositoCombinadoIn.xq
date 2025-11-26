(:: pragma bea:global-element-parameter parameter="$depositoACuenta" element="ns0:depositoACuenta" location="../../xsds/DepositoACuenta/DepositoACuenta.xsd" ::)
(:: pragma bea:global-element-return element="ns1:DepositoCombinado" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositoACuenta";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoACuenta/depositoACuentaIn/";

declare function getT24DepositType ($genericDepositType as xs:string,$currency as xs:string)  as xs:string { 
	if ($genericDepositType = "CASH") then (
		if ($currency = "HNL") then (
			"DP.MN.MN"
		) else (
			"DP.VARIASMND.ME"
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

declare function xf:depositoCombinadoIn($userName as xs:string,
    $password as xs:string,
    $depositoACuenta as element(ns0:depositoACuenta))
    as element(ns1:DepositoCombinado) {
        <ns1:DepositoCombinado>
            <WebRequestCommon>
                <userName>{ $userName }</userName>
                <password>{ $password }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId/>
                <noOfAuth/>
                <replace/>
            </OfsFunction>     
            <TELLERFINANCIALSERVICESFICOINPUTWSType>
                <DepositAccount>{ data($depositoACuenta/ACCOUNT_NUMBER) }</DepositAccount>
                {
                	let $CURRENCY := $depositoACuenta/CURRENCY
                    let $DEPOSIT_ITEMS := $depositoACuenta/DEPOSIT_ITEMS
                    return
	                    <gTRANSACTION>
	                    {
                            for $DEPOSIT_ITEM in $DEPOSIT_ITEMS/DEPOSIT_ITEM
                            return
                                <mTRANSACTION>
                                    <TRANSACTION>
                                    { 
                                    	getT24DepositType(data($DEPOSIT_ITEM/DEPOSIT_TYPE),$CURRENCY)
                                    }
                                    </TRANSACTION>
                                    {
                                        for $CHEQUE_ACCOUNT in $DEPOSIT_ITEM/CHEQUE_ACCOUNT
                                        return
                                            <SURROGATEAC>{ data($CHEQUE_ACCOUNT) }</SURROGATEAC>
                                    }
                                    <CURRENCY>{ data($depositoACuenta/CURRENCY) }</CURRENCY>
                                    {
                                        for $AMOUNT in $DEPOSIT_ITEM/AMOUNT
                                        return
                                            <AMOUNT>{ data($AMOUNT) }</AMOUNT>
                                    }
                                    {
                                        for $BANK_CODE in $DEPOSIT_ITEM/BANK_CODE
                                        return
                                            <SORTCODE>{ data($BANK_CODE) }</SORTCODE>
                                    }
                                    {
                                        for $CHEQUE_NUMBER in $DEPOSIT_ITEM/CHEQUE_NUMBER
                                        return
                                            <CHEQUENUMBER>{ data($CHEQUE_NUMBER) }</CHEQUENUMBER>
                                    }
                                    <sgNARRATIVE>
                                    	<PAYMENTDETAILS>{ fn:substring(data($depositoACuenta/DESCRIPTION),1,34) }</PAYMENTDETAILS>
                                    </sgNARRATIVE>
                                </mTRANSACTION>
	                    }
	                    </gTRANSACTION>  
	            }
                <PANNO>{ data($depositoACuenta/DEPOSITOR_NAME) }</PANNO>
                <LRFICOIDDEPO>{ data( $depositoACuenta/DEPOSITOR_ID) }</LRFICOIDDEPO>
                <LRCHANNELID>{ data($depositoACuenta/CHANNEL) }</LRCHANNELID>
            </TELLERFINANCIALSERVICESFICOINPUTWSType>
        </ns1:DepositoCombinado>
};

declare variable $userName as xs:string external;
declare variable $password as xs:string external;
declare variable $depositoACuenta as element(ns0:depositoACuenta) external;

xf:depositoCombinadoIn(
	$userName,
    $password,
    $depositoACuenta)